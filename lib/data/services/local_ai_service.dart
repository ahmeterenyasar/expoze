import '../content/task_templates.dart';
import '../models/task_model.dart';
import '../models/task_template.dart';

abstract class ILocalAIService {
  Future<List<TaskModel>> generateNextTasks(List<String> focusAreas, int currentAnxiety);
}

class LocalAIService implements ILocalAIService {
  @override
  Future<List<TaskModel>> generateNextTasks(List<String> focusAreas, int currentAnxiety) async {
    final anxiety = currentAnxiety.clamp(1, 10);
    final now = DateTime.now();
    final normalizedFocusAreas = focusAreas.map((item) => item.trim()).where((item) => item.isNotEmpty).toList();

    final byFocus = normalizedFocusAreas.isEmpty
        ? <TaskTemplate>[]
        : kTaskTemplates.where((t) => normalizedFocusAreas.contains(t.focusAreaId)).toList();
    final pool = byFocus.isNotEmpty ? byFocus : kTaskTemplates;

    // Test mode: show all tasks for selected focus areas instead of limiting to 3.
    final matching = pool.where((t) => t.matchesAnxiety(anxiety)).toList();
    final source = matching.isNotEmpty ? matching : pool;
    final picked = _orderBalanced(source, normalizedFocusAreas, anxiety);

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

  List<TaskTemplate> _orderBalanced(
    List<TaskTemplate> source,
    List<String> focusAreas,
    int anxiety,
  ) {
    if (source.isEmpty) {
      return const <TaskTemplate>[];
    }

    final ordered = List<TaskTemplate>.from(source)
      ..sort((a, b) {
        final aMid = (a.minAnxiety + a.maxAnxiety) / 2;
        final bMid = (b.minAnxiety + b.maxAnxiety) / 2;
        return (aMid - anxiety).abs().compareTo((bMid - anxiety).abs());
      });

    if (focusAreas.length <= 1) {
      return ordered;
    }

    final byArea = <String, List<TaskTemplate>>{};
    for (final area in focusAreas) {
      byArea[area] = ordered.where((item) => item.focusAreaId == area).toList();
    }

    final selected = <TaskTemplate>[];
    var round = 0;
    while (selected.length < ordered.length) {
      var addedInThisRound = false;
      for (final area in focusAreas) {
        final areaItems = byArea[area];
        if (areaItems == null || areaItems.length <= round) {
          continue;
        }
        final candidate = areaItems[round];
        if (selected.contains(candidate)) {
          continue;
        }
        selected.add(candidate);
        addedInThisRound = true;
        if (selected.length == ordered.length) {
          break;
        }
      }
      if (!addedInThisRound) {
        break;
      }
      round += 1;
    }

    if (selected.length < ordered.length) {
      for (final item in ordered) {
        if (selected.contains(item)) {
          continue;
        }
        selected.add(item);
        if (selected.length == ordered.length) {
          break;
        }
      }
    }

    return selected;
  }
}
