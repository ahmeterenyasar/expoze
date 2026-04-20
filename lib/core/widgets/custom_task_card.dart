import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomTaskCard extends StatelessWidget {
  const CustomTaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.leadingIcon,
    this.leadingIconColor = AppColors.primary,
    this.leadingBackgroundColor = AppColors.neutral100,
    this.trailing,
    this.selected = false,
    this.onTap,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
    this.titleStyle,
    this.subtitleStyle,
    this.borderColor,
    this.backgroundColor = AppColors.surface,
    this.selectedBackgroundColor,
    this.selectedBorderColor,
    this.borderWidth = 1,
    this.selectedBorderWidth = 2,
    this.selectedTitleColor,
  });

  final String title;
  final String subtitle;
  final Widget? leadingIcon;
  final Color leadingIconColor;
  final Color leadingBackgroundColor;
  final Widget? trailing;
  final bool selected;
  final VoidCallback? onTap;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Color? borderColor;
  final Color backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? selectedBorderColor;
  final double borderWidth;
  final double selectedBorderWidth;
  final Color? selectedTitleColor;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = selected ? (selectedBorderColor ?? AppColors.primary) : (borderColor ?? AppColors.neutral250);
    final effectiveBackgroundColor = selected ? (selectedBackgroundColor ?? backgroundColor) : backgroundColor;

    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: ShapeDecoration(
        color: effectiveBackgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: selected ? selectedBorderWidth : borderWidth,
            color: effectiveBorderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: ShapeDecoration(
              color: leadingBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            alignment: Alignment.center,
            child:
                leadingIcon ??
                Icon(
                  Icons.task_alt_outlined,
                  size: 22,
                  color: leadingIconColor,
                ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: (titleStyle ?? AppTextStyles.taskTitle).copyWith(
                    color: selected ? (selectedTitleColor ?? (titleStyle?.color ?? AppTextStyles.taskTitle.color)) : titleStyle?.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: subtitleStyle ?? AppTextStyles.taskSubtitle,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          trailing ??
              Container(
                width: 22,
                height: 22,
                decoration: ShapeDecoration(
                  color: selected ? AppColors.primary : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: selected ? AppColors.primary : AppColors.neutral300,
                    ),
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: selected ? 1 : 0,
                  duration: const Duration(milliseconds: 180),
                  child: const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
        ],
      ),
    );

    if (onTap == null) {
      return card;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      ),
    );
  }
}
