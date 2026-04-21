import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/local_db_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required ILocalDbService dbService})
    : _dbService = dbService,
      super(const ProfileState());

  final ILocalDbService _dbService;

  Future<void> load() async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));

    try {
      final UserModel? user = await _dbService.getUser();
      final List<TaskModel> allTasks = await _dbService.getAllTasks();

      final List<TaskModel> topTasks = allTasks
          .where((TaskModel task) => !task.isCompleted)
          .take(3)
          .toList();

      final List<ProfileFearItem> fearItems = topTasks.isNotEmpty
          ? topTasks
                .map(
                  (TaskModel task) => ProfileFearItem(
                    title: task.title,
                    subtitle: task.description,
                    intensity: task.anxietyLevel.clamp(1, 5),
                  ),
                )
                .toList()
          : const <ProfileFearItem>[
              ProfileFearItem(
                title: 'Calling a plumber',
                subtitle: 'Asking for help from strangers',
                intensity: 4,
              ),
              ProfileFearItem(
                title: 'Eating alone at a restaurant',
                subtitle: 'Being visibly solo in public',
                intensity: 3,
              ),
              ProfileFearItem(
                title: 'Asking Wi-Fi at a coffee shop',
                subtitle: 'Small public requests',
                intensity: 2,
              ),
            ];

      emit(
        state.copyWith(
          status: ProfileStatus.loaded,
          displayName: user?.userId.isNotEmpty == true
              ? user!.userId
              : 'Alex Rivera',
          courageLevel: user?.currentCourageLevel ?? 4,
          totalXp: user?.totalXP ?? 320,
          fearMap: fearItems,
          reflections: const <ReflectionEntry>[
            ReflectionEntry(
              date: 'Apr 8, 2026',
              title: 'Asking Wi-Fi at a coffee shop',
              description: 'I was so nervous going in. My heart was racing...',
              badgeText: 'Anxiety: 8→3',
              badgeColor: AppColors.sage700,
            ),
            ReflectionEntry(
              date: 'Apr 5, 2026',
              title: 'Ordering at the counter',
              description: 'I almost left the queue twice. But I stayed...',
              badgeText: 'Anxiety: 7→5',
              badgeColor: AppColors.amber700,
            ),
            ReflectionEntry(
              date: 'Feb 2, 2026',
              title: 'Saying hi to a neighbour',
              description: 'This felt absolutely impossible before I did it...',
              badgeText: 'Anxiety: 9→4',
              badgeColor: AppColors.lilac700,
            ),
          ],
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'Profile could not be loaded.',
        ),
      );
    }
  }

  void setDraftFearName(String value) {
    emit(state.copyWith(draftFearName: value));
  }

  void setSelectedIntensity(int intensity) {
    emit(state.copyWith(selectedIntensity: intensity.clamp(1, 5)));
  }

  void addDraftFear() {
    final String draft = state.draftFearName.trim();
    if (draft.isEmpty) {
      return;
    }

    final List<ProfileFearItem> updated = <ProfileFearItem>[
      ...state.fearMap,
      ProfileFearItem(
        title: draft,
        subtitle: 'Added from profile',
        intensity: state.selectedIntensity,
      ),
    ];

    emit(state.copyWith(fearMap: updated, draftFearName: ''));
  }

  void removeFearAt(int index) {
    if (index < 0 || index >= state.fearMap.length) {
      return;
    }

    final List<ProfileFearItem> updated = List<ProfileFearItem>.from(
      state.fearMap,
    )..removeAt(index);
    emit(state.copyWith(fearMap: updated));
  }

  void setRhythm(TherapyRhythm rhythm) {
    emit(state.copyWith(selectedRhythm: rhythm));
  }
}
