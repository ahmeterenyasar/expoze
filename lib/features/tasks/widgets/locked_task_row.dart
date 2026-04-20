import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class LockedTaskRow extends StatelessWidget {
  const LockedTaskRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.xpLabel,
  });

  final String title;
  final String subtitle;
  final String xpLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: ShapeDecoration(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.neutral220),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.lock_outline_rounded,
              size: 16,
              color: AppColors.neutral700,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.taskTitle.copyWith(
                    color: AppColors.neutral800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.taskSubtitle.copyWith(
                    color: AppColors.neutral700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            xpLabel,
            style: AppTextStyles.taskSubtitle.copyWith(
              color: AppColors.neutral700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
