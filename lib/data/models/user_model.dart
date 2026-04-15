class UserModel {
  const UserModel({required this.id, required this.currentCourageLevel, required this.totalXP});

  final String id;
  final int currentCourageLevel;
  final int totalXP;

  UserModel copyWith({String? id, int? currentCourageLevel, int? totalXP}) {
    return UserModel(id: id ?? this.id, currentCourageLevel: currentCourageLevel ?? this.currentCourageLevel, totalXP: totalXP ?? this.totalXP);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'currentCourageLevel': currentCourageLevel, 'totalXP': totalXP};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] as String, currentCourageLevel: json['currentCourageLevel'] as int, totalXP: json['totalXP'] as int);
  }
}
