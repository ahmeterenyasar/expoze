class TaskModel {
  const TaskModel({required this.id, required this.title, required this.description, required this.anxietyLevel, required this.isCompleted, required this.createdAt});

  final String id;
  final String title;
  final String description;
  final int anxietyLevel;
  final bool isCompleted;
  final DateTime createdAt;

  TaskModel copyWith({String? id, String? title, String? description, int? anxietyLevel, bool? isCompleted, DateTime? createdAt}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      anxietyLevel: anxietyLevel ?? this.anxietyLevel,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'title': title, 'description': description, 'anxietyLevel': anxietyLevel, 'isCompleted': isCompleted, 'createdAt': createdAt.toIso8601String()};
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      anxietyLevel: json['anxietyLevel'] as int,
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
