import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

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
  Isar? _isar;
  bool _isInitialized = false;

  @override
  Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    _isar = await Isar.open(
      <CollectionSchema>[
        TaskModelSchema,
        UserModelSchema,
      ],
      name: 'expoze_db',
      directory: (await getApplicationDocumentsDirectory()).path,
      inspector: true,
    );

    _isInitialized = true;
  }

  Isar _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError('LocalDbService is not initialized. Call init() first.');
    }

    final isar = _isar;
    if (isar == null || isar.isOpen == false) {
      throw StateError('Isar instance is unavailable.');
    }

    return isar;
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final isar = _ensureInitialized();
    return isar.taskModels.where().sortByCreatedAtDesc().findAll();
  }

  @override
  Future<TaskModel?> getTaskById(String taskId) async {
    final isar = _ensureInitialized();
    return isar.taskModels.filter().taskIdEqualTo(taskId).findFirst();
  }

  @override
  Future<void> upsertTask(TaskModel task) async {
    final isar = _ensureInitialized();

    await isar.writeTxn(() async {
      await isar.taskModels.put(task);
    });
  }

  @override
  Future<void> upsertTasks(List<TaskModel> tasks) async {
    if (tasks.isEmpty) {
      return;
    }

    final isar = _ensureInitialized();

    await isar.writeTxn(() async {
      await isar.taskModels.putAll(tasks);
    });
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final isar = _ensureInitialized();

    await isar.writeTxn(() async {
      await isar.taskModels.deleteByTaskId(taskId);
    });
  }

  @override
  Future<void> clearTasks() async {
    final isar = _ensureInitialized();

    await isar.writeTxn(() async {
      await isar.taskModels.clear();
    });
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final isar = _ensureInitialized();

    await isar.writeTxn(() async {
      final existing = await isar.userModels.filter().userIdEqualTo(user.userId).findFirst();
      if (existing != null) {
        user.id = existing.id;
      }
      await isar.userModels.put(user);
    });
  }

  @override
  Future<UserModel?> getUser() async {
    final isar = _ensureInitialized();
    return isar.userModels.where().findFirst();
  }
}
