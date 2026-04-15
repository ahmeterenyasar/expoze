import '../models/task_model.dart';
import '../models/user_model.dart';

abstract class ILocalDbService {
  Future<void> init();
  Future<List<TaskModel>> getAllTasks();
  Future<TaskModel?> getTaskById(String id);
  Future<void> upsertTask(TaskModel task);
  Future<void> upsertTasks(List<TaskModel> tasks);
  Future<void> deleteTask(String id);
  Future<void> clearTasks();

  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
}

class LocalDbService implements ILocalDbService {
  final Map<String, TaskModel> _taskStore = <String, TaskModel>{};
  UserModel? _user;
  bool _isInitialized = false;

  @override
  Future<void> init() async {
    // Real implementation can initialize Isar/Hive and adapters/collections.
    _isInitialized = true;
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError('LocalDbService is not initialized. Call init() first.');
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    _ensureInitialized();
    return _taskStore.values.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<TaskModel?> getTaskById(String id) async {
    _ensureInitialized();
    return _taskStore[id];
  }

  @override
  Future<void> upsertTask(TaskModel task) async {
    _ensureInitialized();
    _taskStore[task.id] = task;
  }

  @override
  Future<void> upsertTasks(List<TaskModel> tasks) async {
    _ensureInitialized();
    for (final task in tasks) {
      _taskStore[task.id] = task;
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    _ensureInitialized();
    _taskStore.remove(id);
  }

  @override
  Future<void> clearTasks() async {
    _ensureInitialized();
    _taskStore.clear();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    _ensureInitialized();
    _user = user;
  }

  @override
  Future<UserModel?> getUser() async {
    _ensureInitialized();
    return _user;
  }
}
