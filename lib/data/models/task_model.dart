import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
  TaskModel({
    this.id = Isar.autoIncrement,
    required this.taskId,
    required this.title,
    required this.description,
    required this.anxietyLevel,
    this.isCompleted = false,
    required this.createdAt,
  });

  Id id;

  @Index(unique: true, replace: true)
  late String taskId;

  late String title;
  late String description;
  late int anxietyLevel;
  late bool isCompleted;
  late DateTime createdAt;

  TaskModel copyWith({
    Id? id,
    String? taskId,
    String? title,
    String? description,
    int? anxietyLevel,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      anxietyLevel: anxietyLevel ?? this.anxietyLevel,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
