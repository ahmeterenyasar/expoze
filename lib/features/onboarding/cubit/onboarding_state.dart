import '../../../data/models/user_model.dart';

enum OnboardingStatus { initial, inProgress, completed, error }

class OnboardingState {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.stepIndex = 0,
    this.focusAreas = const <String>[],
    this.focusArea,
    this.currentAnxiety,
    this.baselineCourageLevel,
    this.dailyCommitmentMinutes,
    this.isSavingFocusAreas = false,
    this.createdUser,
    this.errorMessage,
  });

  final OnboardingStatus status;
  final int stepIndex;
  final List<String> focusAreas;
  final String? focusArea;
  final int? currentAnxiety;
  final int? baselineCourageLevel;
  final int? dailyCommitmentMinutes;
  final bool isSavingFocusAreas;
  final UserModel? createdUser;
  final String? errorMessage;

  static const int totalSteps = 4;

  bool get isLastStep => stepIndex >= totalSteps - 1;

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? stepIndex,
    List<String>? focusAreas,
    String? focusArea,
    int? currentAnxiety,
    int? baselineCourageLevel,
    int? dailyCommitmentMinutes,
    bool? isSavingFocusAreas,
    UserModel? createdUser,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      stepIndex: stepIndex ?? this.stepIndex,
      focusAreas: focusAreas ?? this.focusAreas,
      focusArea: focusArea ?? this.focusArea,
      currentAnxiety: currentAnxiety ?? this.currentAnxiety,
      baselineCourageLevel: baselineCourageLevel ?? this.baselineCourageLevel,
      dailyCommitmentMinutes: dailyCommitmentMinutes ?? this.dailyCommitmentMinutes,
      isSavingFocusAreas: isSavingFocusAreas ?? this.isSavingFocusAreas,
      createdUser: createdUser ?? this.createdUser,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }
}
