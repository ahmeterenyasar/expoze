import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/task_model.dart';
import 'swipe_complete_action.dart';

class DailyChallengeCard extends StatelessWidget {
  const DailyChallengeCard({
    super.key,
    required this.task,
    required this.onComplete,
    this.swipeResetSignal = 0,
  });

  final TaskModel task;
  final VoidCallback onComplete;
  final int swipeResetSignal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 22),
      decoration: BoxDecoration(
        color: AppColors.forest800,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Daily challenge',
                style: AppTextStyles.subtitleCaps.copyWith(
                  color: AppColors.sage300,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.sage700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 12,
                      color: AppColors.sage300,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '~5 min',
                      style: AppTextStyles.taskSubtitle.copyWith(
                        color: AppColors.sage300,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.sage700,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.coffee_outlined,
              size: 22,
              color: AppColors.sage200,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            task.title,
            style: AppTextStyles.headline.copyWith(
              color: AppColors.backgroundCream,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            task.description,
            style: AppTextStyles.body.copyWith(
              color: AppColors.sage300,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TagChip(label: 'Anxiety ${task.anxietyLevel}/10'),
              _TagChip(label: '+${_xpForTask(task.anxietyLevel)} XP'),
            ],
          ),
          const SizedBox(height: 22),
          SwipeCompleteAction(
            resetSignal: swipeResetSignal,
            onCompleted: onComplete,
          ),
        ],
      ),
    );
  }

  int _xpForTask(int anxietyLevel) {
    return 20 + (anxietyLevel * 5);
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.sage700,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.taskSubtitle.copyWith(
          color: AppColors.sage300,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
