import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/task_repository.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit({required ITaskRepository taskRepository}) : _taskRepository = taskRepository, super(const TaskInitial());

  final ITaskRepository _taskRepository;

  Future<void> loadUpcomingTasks() async {
    emit(const TaskLoading());

    try {
      final tasks = await _taskRepository.getUpcomingTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (error) {
      emit(TaskError(error.toString()));
    }
  }

  Future<void> generateTasks({required List<String> focusAreas, required int currentAnxiety}) async {
    emit(const TaskLoading());

    try {
      await _taskRepository.generateNewTasks(focusAreas: focusAreas, currentAnxiety: currentAnxiety);
      final updatedTasks = await _taskRepository.getUpcomingTasks();
      emit(TaskLoaded(tasks: updatedTasks));
    } catch (error) {
      emit(TaskError(error.toString()));
    }
  }

  Future<void> completeTask(String taskId) async {
    final previousState = state;

    emit(const TaskLoading());
    try {
      await _taskRepository.completeTask(taskId);
      final updatedTasks = await _taskRepository.getUpcomingTasks();
      emit(TaskLoaded(tasks: updatedTasks));
    } catch (error) {
      if (previousState is TaskLoaded) {
        emit(previousState);
      }
      emit(TaskError(error.toString()));
    }
  }
}
