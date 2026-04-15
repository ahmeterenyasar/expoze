import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';
import '../../../data/services/local_db_service.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required ILocalDbService dbService}) : _dbService = dbService, super(const OnboardingState());

  final ILocalDbService _dbService;

  void start() {
    emit(state.copyWith(status: OnboardingStatus.inProgress, stepIndex: 0, clearErrorMessage: true));
  }

  void updateFocusArea(String value) {
    emit(state.copyWith(focusArea: value.trim(), clearErrorMessage: true));
  }

  void updateCurrentAnxiety(int value) {
    emit(state.copyWith(currentAnxiety: value.clamp(1, 10), clearErrorMessage: true));
  }

  void updateBaselineCourageLevel(int value) {
    emit(state.copyWith(baselineCourageLevel: value.clamp(1, 100), clearErrorMessage: true));
  }

  void updateDailyCommitmentMinutes(int value) {
    emit(state.copyWith(dailyCommitmentMinutes: value.clamp(1, 180), clearErrorMessage: true));
  }

  void nextStep() {
    final validationError = _validateCurrentStep(state);
    if (validationError != null) {
      emit(state.copyWith(status: OnboardingStatus.error, errorMessage: validationError));
      return;
    }

    if (state.isLastStep) {
      return;
    }

    emit(state.copyWith(status: OnboardingStatus.inProgress, stepIndex: state.stepIndex + 1, clearErrorMessage: true));
  }

  void previousStep() {
    if (state.stepIndex <= 0) {
      return;
    }

    emit(state.copyWith(status: OnboardingStatus.inProgress, stepIndex: state.stepIndex - 1, clearErrorMessage: true));
  }

  Future<void> completeOnboarding({required String userId}) async {
    final validationError = _validateAllSteps(state);
    if (validationError != null) {
      emit(state.copyWith(status: OnboardingStatus.error, errorMessage: validationError));
      return;
    }

    try {
      final user = UserModel(id: userId, currentCourageLevel: state.baselineCourageLevel!, totalXP: 0);

      await _dbService.saveUser(user);

      emit(state.copyWith(status: OnboardingStatus.completed, createdUser: user, clearErrorMessage: true));
    } catch (error) {
      emit(state.copyWith(status: OnboardingStatus.error, errorMessage: error.toString()));
    }
  }

  String? _validateCurrentStep(OnboardingState current) {
    switch (current.stepIndex) {
      case 0:
        final focus = current.focusArea;
        if (focus == null || focus.isEmpty) {
          return 'Focus area is required.';
        }
      case 1:
        if (current.currentAnxiety == null) {
          return 'Current anxiety level is required.';
        }
      case 2:
        if (current.baselineCourageLevel == null) {
          return 'Baseline courage level is required.';
        }
      case 3:
        if (current.dailyCommitmentMinutes == null) {
          return 'Daily commitment is required.';
        }
    }
    return null;
  }

  String? _validateAllSteps(OnboardingState current) {
    if (current.focusArea == null || current.focusArea!.isEmpty) {
      return 'Focus area is required.';
    }
    if (current.currentAnxiety == null) {
      return 'Current anxiety level is required.';
    }
    if (current.baselineCourageLevel == null) {
      return 'Baseline courage level is required.';
    }
    if (current.dailyCommitmentMinutes == null) {
      return 'Daily commitment is required.';
    }
    return null;
  }
}
