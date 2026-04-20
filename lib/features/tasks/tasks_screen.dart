import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/theme.dart';
import '../../core/widgets/custom_bottom_nav_bar.dart';
import '../../data/models/task_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/task_repository.dart';
import '../../data/services/local_ai_service.dart';
import '../../data/services/local_db_service.dart';
import 'cubit/task_cubit.dart';
import 'cubit/task_state.dart';
import 'widgets/daily_challenge_card.dart';
import 'widgets/locked_task_row.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({
    super.key,
    required this.dbService,
  });

  final ILocalDbService dbService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskCubit(
        taskRepository: TaskRepository(
          aiService: LocalAIService(),
          dbService: dbService,
        ),
      )..loadUpcomingTasks(),
      child: _TasksView(dbService: dbService),
    );
  }
}

class _TasksView extends StatefulWidget {
  const _TasksView({required this.dbService});

  final ILocalDbService dbService;

  @override
  State<_TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<_TasksView> {
  UserModel? _user;
  bool _isLoadingUser = true;
  bool _didRequestInitialTasks = false;
  bool _showCompletionOverlay = false;
  int _swipeResetSignal = 0;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await widget.dbService.getUser();
    if (!mounted) {
      return;
    }

    setState(() {
      _user = user;
      _isLoadingUser = false;
    });
  }

  Future<void> _ensureTasksIfNeeded(List<TaskModel> tasks) async {
    if (_didRequestInitialTasks || tasks.isNotEmpty || _isLoadingUser) {
      return;
    }

    _didRequestInitialTasks = true;
    final focusArea = _resolveFocusArea();
    final anxiety = _resolveCurrentAnxiety();

    await context.read<TaskCubit>().generateTasks(
      focusArea: focusArea,
      currentAnxiety: anxiety,
    );
  }

  String _resolveFocusArea() {
    final focusAreas = _user?.onboardingFocusAreas ?? const <String>[];
    if (focusAreas.isEmpty) {
      return 'social confidence';
    }

    return focusAreas.first;
  }

  int _resolveCurrentAnxiety() {
    final courageLevel = _user?.currentCourageLevel ?? 3;
    return (11 - courageLevel.clamp(1, 10)).clamp(1, 10);
  }

  Future<void> _handleCompleteTask(TaskModel task) async {
    await context.read<TaskCubit>().completeTask(task.taskId);

    if (!mounted) {
      return;
    }

    setState(() {
      _showCompletionOverlay = true;
    });
  }

  void _resetCompletionOverlay() {
    setState(() {
      _showCompletionOverlay = false;
      _swipeResetSignal += 1;
    });
  }

  void _onNavItemSelected(int index) {
    if (index == 0) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This section will be available soon.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state is TaskLoaded) {
            _ensureTasksIfNeeded(state.tasks);
          }
        },
        builder: (context, state) {
          if (state is TaskLoading && !_didRequestInitialTasks) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TaskLoaded) {
            return _TasksContent(
              user: _user,
              tasks: state.tasks,
              showCompletionOverlay: _showCompletionOverlay,
              swipeResetSignal: _swipeResetSignal,
              onCompleteTask: _handleCompleteTask,
              onDismissOverlay: _resetCompletionOverlay,
            );
          }

          if (state is TaskError) {
            return Center(
              child: Text(
                'Could not load tasks right now.',
                style: AppTextStyles.body,
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onItemSelected: _onNavItemSelected,
        items: const [
          CustomBottomNavBarItem(
            label: 'Tasks',
            icon: Icon(Icons.task_alt_rounded),
          ),
          CustomBottomNavBarItem(
            label: 'Progress',
            icon: Icon(Icons.bar_chart_rounded),
          ),
          CustomBottomNavBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_outline_rounded),
          ),
        ],
      ),
    );
  }
}

class _TasksContent extends StatelessWidget {
  const _TasksContent({
    required this.user,
    required this.tasks,
    required this.showCompletionOverlay,
    required this.swipeResetSignal,
    required this.onCompleteTask,
    required this.onDismissOverlay,
  });

  final UserModel? user;
  final List<TaskModel> tasks;
  final bool showCompletionOverlay;
  final int swipeResetSignal;
  final ValueChanged<TaskModel> onCompleteTask;
  final VoidCallback onDismissOverlay;

  @override
  Widget build(BuildContext context) {
    final challengeTask = tasks.isNotEmpty ? tasks.first : null;
    final upcomingTasks = tasks.length > 1 ? tasks.skip(1).toList() : const <TaskModel>[];
    final topInset = MediaQuery.paddingOf(context).top;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (screenWidth * 0.06).clamp(16.0, 28.0);

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            topInset + 20,
            horizontalPadding,
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(user: user),
              const SizedBox(height: 22),
              if (challengeTask != null)
                DailyChallengeCard(
                  task: challengeTask,
                  swipeResetSignal: swipeResetSignal,
                  onComplete: () => onCompleteTask(challengeTask),
                )
              else
                _NoTaskCard(),
              const SizedBox(height: 18),
              Text(
                'Upcoming micro-tasks',
                style: AppTextStyles.subtitleCaps.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),
              Column(
                children: upcomingTasks.isEmpty
                    ? const [
                        LockedTaskRow(
                          title: 'Complete your daily challenge first',
                          subtitle: 'Next tasks unlock after completion',
                          xpLabel: '+0 XP',
                        ),
                      ]
                    : upcomingTasks
                          .map(
                            (task) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: LockedTaskRow(
                                title: task.title,
                                subtitle: 'Unlocks after today\'s challenge',
                                xpLabel: '+${20 + (task.anxietyLevel * 5)} XP',
                              ),
                            ),
                          )
                          .toList(),
              ),
              SizedBox(height: MediaQuery.paddingOf(context).bottom + 16),
            ],
          ),
        ),
        if (showCompletionOverlay)
          Positioned.fill(
            child: Container(
              color: AppColors.backgroundCream,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.sage150,
                      borderRadius: BorderRadius.circular(72),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColors.primary,
                      size: 34,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Challenge complete!',
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'You earned XP. The next task is now unlocked.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onDismissOverlay,
                      child: const Text('Back to tasks'),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final xp = user?.totalXP ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.sage200,
                borderRadius: BorderRadius.circular(36),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.person_outline_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Hey there',
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.sage150,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$xp XP',
                    style: AppTextStyles.taskTitle.copyWith(
                      color: AppColors.sage800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Good morning,\nyou\'ve got this!',
          style: AppTextStyles.headline,
        ),
        const SizedBox(height: 6),
        Text(
          '1 challenge ready for you today',
          style: AppTextStyles.body,
        ),
      ],
    );
  }
}

class _NoTaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        'Preparing your first challenge...',
        style: AppTextStyles.body,
      ),
    );
  }
}
