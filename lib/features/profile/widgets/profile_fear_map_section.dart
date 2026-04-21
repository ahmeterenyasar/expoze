import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../cubit/profile_state.dart';
import 'fear_map_item_card.dart';

class ProfileFearMapSection extends StatelessWidget {
  const ProfileFearMapSection({
    super.key,
    required this.items,
    required this.selectedIntensity,
    required this.onIntensitySelected,
    required this.onAddPressed,
    required this.onDraftChanged,
    required this.onRemove,
    required this.fearNameController,
  });

  final List<ProfileFearItem> items;
  final int selectedIntensity;
  final ValueChanged<int> onIntensitySelected;
  final VoidCallback onAddPressed;
  final ValueChanged<String> onDraftChanged;
  final ValueChanged<int> onRemove;
  final TextEditingController fearNameController;

  Color _dotColorForIntensity(int intensity) {
    if (intensity >= 4) {
      return AppColors.orange600;
    }
    if (intensity == 3) {
      return AppColors.lilac500;
    }
    return AppColors.sage700;
  }

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
        children: <Widget>[
          Text(
            'MY FEAR MAP',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              letterSpacing: 1.1,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Drag to reorder by intensity.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 10),
          ...List<Widget>.generate(items.length, (int index) {
            final ProfileFearItem item = items[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == items.length - 1 ? 0 : 8,
              ),
              child: FearMapItemCard(
                order: index + 1,
                title: item.title,
                subtitle: item.subtitle,
                intensity: item.intensity,
                dotColor: _dotColorForIntensity(item.intensity),
                onRemove: () => onRemove(index),
              ),
            );
          }),
          const SizedBox(height: 10),
          TextField(
            controller: fearNameController,
            onChanged: onDraftChanged,
            decoration: InputDecoration(
              hintText: 'Name your fear (it can be unusual!)',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.sage200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.sage200),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Text(
                'Intensity:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              ...List<Widget>.generate(5, (int i) {
                final int value = i + 1;
                final bool selected = selectedIntensity == value;
                return GestureDetector(
                  onTap: () => onIntensitySelected(value),
                  child: Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(right: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? AppColors.sage200
                          : AppColors.neutral100,
                    ),
                    child: Text(
                      '$value',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onAddPressed,
            child: Container(
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withOpacity(0.35)),
              ),
              child: Text(
                '+ Add to my fear map',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
