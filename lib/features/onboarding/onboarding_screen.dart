import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/content/focus_area_catalog.dart';

import '../../core/theme/theme.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_task_card.dart';
import '../../data/services/local_db_service.dart';
import '../tasks/tasks_screen.dart';
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
      child: _OnboardingView(dbService: dbService),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView({required this.dbService});

  final ILocalDbService dbService;

  static const List<FocusAreaOption> _options = kFocusAreaCatalog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: BlocConsumer<OnboardingCubit, OnboardingState>(
          listenWhen: (previous, current) {
            final shouldNavigate = previous.isSavingFocusAreas && !current.isSavingFocusAreas && current.createdUser != null && current.status != OnboardingStatus.error;
            return shouldNavigate || current.status == OnboardingStatus.error;
          },
          listener: (context, state) {
            if (state.status == OnboardingStatus.error && state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
              return;
            }

            Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (_) => TasksScreen(dbService: dbService),
              ),
            );
          },
          builder: (context, state) {
            final selectedIds = state.focusAreas.toSet();
            final selectedCount = selectedIds.length;
            final canContinue = selectedCount > 0;

            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(overscroll: false),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 20, 28, 20),
                child: Column(
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
                    ..._options.asMap().entries.map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      final isSelected = selectedIds.contains(option.id);
                      return Padding(
                        padding: EdgeInsets.only(bottom: index == _options.length - 1 ? 0 : 12),
                        child: CustomTaskCard(
                          title: option.title,
                          subtitle: option.subtitle,
                          selected: isSelected,
                          onTap: () => context.read<OnboardingCubit>().toggleFocusArea(option.id),
                          leadingBackgroundColor: option.iconBg,
                          leadingIconColor: option.iconColor,
                          leadingIcon: Icon(option.icon, size: 22, color: option.iconColor),
                          backgroundColor: AppColors.surface,
                          selectedBackgroundColor: AppColors.sage150,
                          borderColor: AppColors.neutral250,
                          selectedBorderColor: AppColors.primary,
                          borderWidth: 1.5,
                          selectedBorderWidth: 2,
                          selectedTitleColor: const Color(0xFF1D5C4F),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    CustomButton(
                      label: state.isSavingFocusAreas ? 'Saving...' : 'Continue',
                      enabled: canContinue && !state.isSavingFocusAreas,
                      onPressed: canContinue && !state.isSavingFocusAreas ? () => context.read<OnboardingCubit>().saveStepOneAndContinue() : null,
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
                ),
              ),
            );
          },
        ),
      ),
    );
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
