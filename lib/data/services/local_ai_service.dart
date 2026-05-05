import '../content/task_templates.dart';
import '../models/task_model.dart';
import '../models/task_template.dart';

abstract class ILocalAIService {
  Future<List<TaskModel>> generateNextTasks(String focusArea, int currentAnxiety);
}

class LocalAIService implements ILocalAIService {
  @override
  Future<List<TaskModel>> generateNextTasks(String focusArea, int currentAnxiety) async {
    final anxiety = currentAnxiety.clamp(1, 10);
    final now = DateTime.now();

    final byFocus = kTaskTemplates.where((t) => t.focusAreaId == focusArea).toList();
    final pool = byFocus.isNotEmpty ? byFocus : kTaskTemplates;

    final matching = pool.where((t) => t.matchesAnxiety(anxiety)).toList();
    final source = matching.isNotEmpty ? matching : pool;

    source.sort((a, b) {
      final aMid = (a.minAnxiety + a.maxAnxiety) / 2;
      final bMid = (b.minAnxiety + b.maxAnxiety) / 2;
      return (aMid - anxiety).abs().compareTo((bMid - anxiety).abs());
    });

    final picked = _pickUnique(source, count: 3);

    return List<TaskModel>.generate(picked.length, (index) {
      final template = picked[index];
      return TaskModel(
        taskId: '${template.id}_${now.microsecondsSinceEpoch}_$index',
        title: template.title,
        description: template.description,
        anxietyLevel: anxiety,
        createdAt: now,
      );
    });
  }

  List<TaskTemplate> _pickUnique(List<TaskTemplate> items, {required int count}) {
    if (items.length <= count) {
      return items;
    }
    return items.take(count).toList();
  }
}
