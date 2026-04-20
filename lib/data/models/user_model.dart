class UserModel {
  const UserModel({
    required this.id,
    required this.currentCourageLevel,
    required this.totalXP,
    this.onboardingFocusAreas = const <String>[],
  });

  final String id;
  final int currentCourageLevel;
  final int totalXP;
  final List<String> onboardingFocusAreas;

  UserModel copyWith({
    String? id,
    int? currentCourageLevel,
    int? totalXP,
    List<String>? onboardingFocusAreas,
  }) {
    return UserModel(
      id: id ?? this.id,
      currentCourageLevel: currentCourageLevel ?? this.currentCourageLevel,
      totalXP: totalXP ?? this.totalXP,
      onboardingFocusAreas: onboardingFocusAreas ?? this.onboardingFocusAreas,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'currentCourageLevel': currentCourageLevel,
      'totalXP': totalXP,
      'onboardingFocusAreas': onboardingFocusAreas,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      currentCourageLevel: json['currentCourageLevel'] as int,
      totalXP: json['totalXP'] as int,
      onboardingFocusAreas: (json['onboardingFocusAreas'] as List<dynamic>?)?.cast<String>() ?? const <String>[],
    );
  }
}
