import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../cubit/profile_state.dart';
import 'reflection_entry_card.dart';

class ProfileReflectionArchiveSection extends StatelessWidget {
  const ProfileReflectionArchiveSection({
    super.key,
    required this.entries,
  });

  final List<ReflectionEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neutral250),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'REFLECTION ARCHIVE',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  letterSpacing: 1.1,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${entries.length} entries',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...List<Widget>.generate(entries.length, (int index) {
            final ReflectionEntry item = entries[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == entries.length - 1 ? 0 : 8,
              ),
              child: ReflectionEntryCard(
                date: item.date,
                title: item.title,
                description: item.description,
                badgeText: item.badgeText,
                badgeColor: item.badgeColor,
              ),
            );
          }),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.sage200),
            ),
            child: Text(
              'View all ${entries.length} entries',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
