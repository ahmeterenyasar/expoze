import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';
import '../../../data/services/local_db_service.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required ILocalDbService dbService}) : _dbService = dbService, super(const OnboardingState());

  final ILocalDbService _dbService;
  static const String _defaultUserId = 'local-user';

  void start() {
    emit(state.copyWith(status: OnboardingStatus.inProgress, stepIndex: 0, clearErrorMessage: true));
    _loadSavedFocusAreas();
  }

  Future<void> _loadSavedFocusAreas() async {
    try {
      final user = await _dbService.getUser();
      final savedFocusAreas = user?.onboardingFocusAreas ?? const <String>[];
      if (savedFocusAreas.isEmpty) {
        return;
      }

      emit(
        state.copyWith(
          focusAreas: List<String>.from(savedFocusAreas),
          focusArea: savedFocusAreas.join(','),
          createdUser: user,
          clearErrorMessage: true,
        ),
      );
    } catch (_) {
      // Loading saved draft is best-effort.
    }
  }

  void toggleFocusArea(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return;
    }

    final current = List<String>.from(state.focusAreas);
    if (current.contains(normalized)) {
      current.remove(normalized);
    } else {
      current.add(normalized);
    }

    emit(
      state.copyWith(
        focusAreas: current,
        focusArea: current.join(','),
        clearErrorMessage: true,
      ),
    );
  }

  void updateFocusArea(String value) {
    final parsed = value.split(',').map((item) => item.trim()).where((item) => item.isNotEmpty).toList();

    emit(
      state.copyWith(
        focusAreas: parsed,
        focusArea: parsed.join(','),
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> saveStepOneAndContinue() async {
    final selected = state.focusAreas;
    if (selected.isEmpty) {
      emit(
        state.copyWith(
          status: OnboardingStatus.error,
          errorMessage: 'Focus area is required.',
        ),
      );
      return;
    }

    emit(state.copyWith(isSavingFocusAreas: true, clearErrorMessage: true));

    try {
      final existingUser = await _dbService.getUser();
      final nextUser = (existingUser ?? UserModel(userId: _defaultUserId, currentCourageLevel: 1, totalXP: 0)).copyWith(
        onboardingFocusAreas: List<String>.from(selected),
      );

      await _dbService.saveUser(nextUser);

      emit(
        state.copyWith(
          isSavingFocusAreas: false,
          createdUser: nextUser,
          clearErrorMessage: true,
        ),
      );

      nextStep();
    } catch (error) {
      emit(
        state.copyWith(
          status: OnboardingStatus.error,
          isSavingFocusAreas: false,
          errorMessage: error.toString(),
        ),
      );
    }
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
      final user = UserModel(
        userId: userId,
        currentCourageLevel: state.baselineCourageLevel!,
        totalXP: 0,
        onboardingFocusAreas: List<String>.from(state.focusAreas),
      );

      await _dbService.saveUser(user);

      emit(state.copyWith(status: OnboardingStatus.completed, createdUser: user, clearErrorMessage: true));
    } catch (error) {
      emit(state.copyWith(status: OnboardingStatus.error, errorMessage: error.toString()));
    }
  }

  String? _validateCurrentStep(OnboardingState current) {
    switch (current.stepIndex) {
      case 0:
        if (current.focusAreas.isEmpty) {
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
    if (current.focusAreas.isEmpty) {
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
