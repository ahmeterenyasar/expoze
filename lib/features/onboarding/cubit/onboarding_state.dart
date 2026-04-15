import '../../../data/models/user_model.dart';

enum OnboardingStatus { initial, inProgress, completed, error }

class OnboardingState {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.stepIndex = 0,
    this.focusArea,
    this.currentAnxiety,
    this.baselineCourageLevel,
    this.dailyCommitmentMinutes,
    this.createdUser,
    this.errorMessage,
  });

  final OnboardingStatus status;
  final int stepIndex;
  final String? focusArea;
  final int? currentAnxiety;
  final int? baselineCourageLevel;
  final int? dailyCommitmentMinutes;
  final UserModel? createdUser;
  final String? errorMessage;

  static const int totalSteps = 4;

  bool get isLastStep => stepIndex >= totalSteps - 1;

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? stepIndex,
    String? focusArea,
    int? currentAnxiety,
    int? baselineCourageLevel,
    int? dailyCommitmentMinutes,
    UserModel? createdUser,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      stepIndex: stepIndex ?? this.stepIndex,
      focusArea: focusArea ?? this.focusArea,
      currentAnxiety: currentAnxiety ?? this.currentAnxiety,
      baselineCourageLevel: baselineCourageLevel ?? this.baselineCourageLevel,
      dailyCommitmentMinutes: dailyCommitmentMinutes ?? this.dailyCommitmentMinutes,
      createdUser: createdUser ?? this.createdUser,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }
}
