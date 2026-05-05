import '../models/task_model.dart';
import '../services/local_ai_service.dart';
import '../services/local_db_service.dart';

abstract class ITaskRepository {
  Future<List<TaskModel>> getUpcomingTasks();
  Future<TaskModel> completeTask(String taskId);
  Future<List<TaskModel>> generateNewTasks({required List<String> focusAreas, required int currentAnxiety});
}

class TaskRepository implements ITaskRepository {
  const TaskRepository({required ILocalAIService aiService, required ILocalDbService dbService}) : _aiService = aiService, _dbService = dbService;

  final ILocalAIService _aiService;
  final ILocalDbService _dbService;

  @override
  Future<List<TaskModel>> getUpcomingTasks() async {
    final tasks = await _dbService.getAllTasks();
    return tasks.where((task) => !task.isCompleted).toList();
  }

  @override
  Future<TaskModel> completeTask(String taskId) async {
    final existingTask = await _dbService.getTaskById(taskId);
    if (existingTask == null) {
      throw StateError('Task not found for id: $taskId');
    }

    final completedTask = existingTask.copyWith(isCompleted: true);
    await _dbService.upsertTask(completedTask);
    return completedTask;
  }

  @override
  Future<List<TaskModel>> generateNewTasks({required List<String> focusAreas, required int currentAnxiety}) async {
    final newTasks = await _aiService.generateNextTasks(focusAreas, currentAnxiety);
    await _dbService.upsertTasks(newTasks);
    return newTasks;
  }
}
