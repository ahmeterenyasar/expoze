import '../../../data/models/task_model.dart';

sealed class TaskState {
  const TaskState();
}

final class TaskInitial extends TaskState {
  const TaskInitial();
}

final class TaskLoading extends TaskState {
  const TaskLoading();
}

final class TaskLoaded extends TaskState {
  const TaskLoaded({required this.tasks});

  final List<TaskModel> tasks;

  int get pendingCount => tasks.where((task) => !task.isCompleted).length;
}

final class TaskError extends TaskState {
  const TaskError(this.message);

  final String message;
}
