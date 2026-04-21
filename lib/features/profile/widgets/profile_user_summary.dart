import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class ProfileUserSummary extends StatelessWidget {
  const ProfileUserSummary({
    super.key,
    required this.displayName,
    required this.courageLevel,
    required this.totalXp,
  });

  final String displayName;
  final int courageLevel;
  final int totalXp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: AppColors.sage150,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withOpacity(0.35)),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '✩ Courage Level $courageLevel · $totalXp XP',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
