import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  UserModel({
    this.id = Isar.autoIncrement,
    required this.userId,
    required this.currentCourageLevel,
    required this.totalXP,
    this.onboardingFocusAreas = const <String>[],
  });

  Id id;

  @Index(unique: true, replace: true)
  late String userId;

  late int currentCourageLevel;
  late int totalXP;
  List<String> onboardingFocusAreas;

  UserModel copyWith({
    Id? id,
    String? userId,
    int? currentCourageLevel,
    int? totalXP,
    List<String>? onboardingFocusAreas,
  }) {
    return UserModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      currentCourageLevel: currentCourageLevel ?? this.currentCourageLevel,
      totalXP: totalXP ?? this.totalXP,
      onboardingFocusAreas: onboardingFocusAreas ?? this.onboardingFocusAreas,
    );
  }
}
