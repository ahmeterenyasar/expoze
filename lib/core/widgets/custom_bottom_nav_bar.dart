import 'package:flutter/material.dart';

import '../theme/theme.dart';

const List<CustomBottomNavBarItem> appBottomNavItems =
    <CustomBottomNavBarItem>[
      CustomBottomNavBarItem(
        label: 'Tasks',
        icon: Icon(Icons.task_alt_rounded),
      ),
      CustomBottomNavBarItem(
        label: 'Progress',
        icon: Icon(Icons.bar_chart_rounded),
      ),
      CustomBottomNavBarItem(
        label: 'Profile',
        icon: Icon(Icons.person_outline_rounded),
      ),
    ];

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onItemSelected,
    this.backgroundColor = AppColors.surface,
    this.borderColor = AppColors.neutral200,
    this.activeColor = AppColors.primary,
    this.inactiveColor = AppColors.neutral700,
    this.padding = const EdgeInsets.only(
      top: 14,
      left: 20,
      right: 20,
      bottom: 18,
    ),
    this.itemSpacing = 16,
  });

  final List<CustomBottomNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onItemSelected;
  final Color backgroundColor;
  final Color borderColor;
  final Color activeColor;
  final Color inactiveColor;
  final EdgeInsetsGeometry padding;
  final double itemSpacing;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = EdgeInsets.fromLTRB(20, 14, 20, 18);

    return Container(
      width: double.infinity,
      padding: effectivePadding,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final bool isActive = index == currentIndex;
          final TextStyle labelStyle =
              item.labelStyle ?? (isActive ? AppTextStyles.navItemActive : AppTextStyles.navItemInactive).copyWith(color: isActive ? activeColor : inactiveColor);

          return InkWell(
            onTap: onItemSelected == null ? null : () => onItemSelected!(index),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: isActive ? activeColor : inactiveColor,
                      size: item.iconSize,
                    ),
                    child: item.icon,
                  ),
                  SizedBox(height: itemSpacing),
                  Text(item.label, style: labelStyle),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CustomBottomNavBarItem {
  const CustomBottomNavBarItem({
    required this.label,
    required this.icon,
    this.iconSize = 22,
    this.labelStyle,
  });

  final String label;
  final Widget icon;
  final double iconSize;
  final TextStyle? labelStyle;
}
