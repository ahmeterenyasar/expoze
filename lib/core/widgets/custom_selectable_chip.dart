import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomSelectableChip extends StatelessWidget {
  const CustomSelectableChip({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.selected,
    required this.onTap,
    this.selectedTitleColor = const Color(0xFF1D5C4F),
    this.borderRadius = 20,
    this.unselectedBorderColor = AppColors.neutral250,
    this.selectedBorderColor = AppColors.primary,
    this.selectedBackgroundColor = AppColors.sage150,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedTitleColor;
  final double borderRadius;
  final Color unselectedBorderColor;
  final Color selectedBorderColor;
  final Color selectedBackgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: padding,
          decoration: BoxDecoration(
            color: selected ? selectedBackgroundColor : AppColors.surface,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: selected ? selectedBorderColor : unselectedBorderColor,
              width: selected ? 2 : 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.taskTitle.copyWith(
                        color: selected ? selectedTitleColor : AppColors.sage900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle, style: AppTextStyles.taskSubtitle),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: selected ? selectedBorderColor : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? selectedBorderColor : AppColors.neutral300,
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: selected ? 1 : 0,
                  child: const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
