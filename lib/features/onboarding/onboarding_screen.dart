import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/theme.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_selectable_chip.dart';
import '../../data/services/local_db_service.dart';
import 'cubit/onboarding_cubit.dart';
import 'cubit/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    super.key,
    required this.dbService,
  });

  final ILocalDbService dbService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(dbService: dbService)..start(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  static const List<_FocusOption> _options = [
    _FocusOption(
      id: 'speaking',
      title: 'Public speaking',
      subtitle: 'Presentations, talks, toasts',
      icon: Icons.mic_none_rounded,
      iconBg: AppColors.sage150,
      iconColor: AppColors.primary,
    ),
    _FocusOption(
      id: 'strangers',
      title: 'Meeting strangers',
      subtitle: 'Networking, new places, events',
      icon: Icons.group_outlined,
      iconBg: Color(0xFFEEF0FB),
      iconColor: AppColors.lilac500,
    ),
    _FocusOption(
      id: 'eating',
      title: 'Eating alone',
      subtitle: 'Cafes, restaurants, lunch breaks',
      icon: Icons.restaurant_menu_rounded,
      iconBg: Color(0xFFFAF0EB),
      iconColor: AppColors.orange600,
    ),
    _FocusOption(
      id: 'calls',
      title: 'Making phone calls',
      subtitle: 'Appointments, orders, check-ins',
      icon: Icons.call_outlined,
      iconBg: Color(0xFFEAF3DE),
      iconColor: AppColors.lime700,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 40, 28, 36),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final selectedIds = _selectedIdsFromState(state);
              final selectedCount = selectedIds.length;
              final canContinue = selectedCount > 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Step 1 of 3',
                        style: AppTextStyles.subtitleCaps.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 0,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: SizedBox(
                            height: 4,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(color: AppColors.neutral250),
                                FractionallySizedBox(
                                  widthFactor: 0.333,
                                  alignment: Alignment.centerLeft,
                                  child: Container(color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'Getting started',
                    style: AppTextStyles.subtitleCaps,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'What would you like\nto work on today?',
                    style: AppTextStyles.headline,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose one or more. You can always change this later.',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 28),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _options.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final option = _options[index];
                        final isSelected = selectedIds.contains(option.id);
                        return CustomSelectableChip(
                          title: option.title,
                          subtitle: option.subtitle,
                          icon: option.icon,
                          iconBackgroundColor: option.iconBg,
                          iconColor: option.iconColor,
                          selected: isSelected,
                          onTap: () => _toggleSelection(
                            context,
                            option.id,
                            selectedIds,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: 'Continue',
                    enabled: canContinue,
                    onPressed: canContinue ? () => context.read<OnboardingCubit>().nextStep() : null,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      _hintText(selectedCount),
                      style: AppTextStyles.taskSubtitle.copyWith(
                        color: const Color(0xFF9BB5AF),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  static Set<String> _selectedIdsFromState(OnboardingState state) {
    final raw = state.focusArea;
    if (raw == null || raw.trim().isEmpty) {
      return <String>{};
    }

    return raw.split(',').map((value) => value.trim()).where((value) => value.isNotEmpty).toSet();
  }

  static void _toggleSelection(
    BuildContext context,
    String id,
    Set<String> selectedIds,
  ) {
    final next = <String>{...selectedIds};
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }

    context.read<OnboardingCubit>().updateFocusArea(next.join(','));
  }

  static String _hintText(int selectedCount) {
    if (selectedCount <= 0) {
      return 'Select at least one to continue';
    }
    if (selectedCount == 1) {
      return '1 area selected';
    }
    return '$selectedCount areas selected';
  }
}

class _FocusOption {
  const _FocusOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
}
