import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class FearMapItemCard extends StatelessWidget {
  const FearMapItemCard({
    super.key,
    required this.order,
    required this.title,
    required this.subtitle,
    required this.intensity,
    required this.dotColor,
    required this.onRemove,
  });

  final int order;
  final String title;
  final String subtitle;
  final int intensity;
  final Color dotColor;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundCream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutral250),
      ),
      child: Row(
        children: [
          const Icon(Icons.drag_indicator_rounded, color: AppColors.sage300),
          const SizedBox(width: 8),
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$order',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: List.generate(5, (index) {
              final active = index < intensity;
              return Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active ? dotColor : AppColors.neutral250,
                ),
              );
            }),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.close_rounded,
              size: 16,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
