import 'dart:async';

import '../models/task_model.dart';

abstract class ILocalAIService {
  Future<List<TaskModel>> generateNextTasks(String focusArea, int currentAnxiety);
}

class LocalAIService implements ILocalAIService {
  @override
  Future<List<TaskModel>> generateNextTasks(String focusArea, int currentAnxiety) async {
    // Simulates a local llama.cpp inference delay.
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final now = DateTime.now();
    final clampedAnxiety = currentAnxiety.clamp(1, 10);

    return List<TaskModel>.generate(3, (index) {
      final taskNumber = index + 1;
      final suggestedAnxiety = (clampedAnxiety + index).clamp(1, 10);

      return TaskModel(
        taskId: '${now.microsecondsSinceEpoch}_$taskNumber',
        title: 'Exposure $taskNumber: $focusArea',
        description: 'Take a short action around "$focusArea" for 2-5 minutes.',
        anxietyLevel: suggestedAnxiety,
        isCompleted: false,
        createdAt: now,
      );
    });
  }
}
