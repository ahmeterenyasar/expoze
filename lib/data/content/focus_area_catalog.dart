import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

class FocusAreaOption {
  const FocusAreaOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
}

const List<FocusAreaOption> kFocusAreaCatalog = <FocusAreaOption>[
  FocusAreaOption(
    id: 'speaking',
    title: 'Public speaking',
    subtitle: 'Presentations, talks, toasts',
    icon: Icons.mic_none_rounded,
    iconBg: AppColors.sage150,
    iconColor: AppColors.primary,
  ),
  FocusAreaOption(
    id: 'strangers',
    title: 'Meeting strangers',
    subtitle: 'Networking, new places, events',
    icon: Icons.group_outlined,
    iconBg: Color(0xFFEEF0FB),
    iconColor: AppColors.lilac500,
  ),
  FocusAreaOption(
    id: 'eating',
    title: 'Eating alone',
    subtitle: 'Cafes, restaurants, lunch breaks',
    icon: Icons.restaurant_menu_rounded,
    iconBg: Color(0xFFFAF0EB),
    iconColor: AppColors.orange600,
  ),
  FocusAreaOption(
    id: 'calls',
    title: 'Making phone calls',
    subtitle: 'Appointments, orders, check-ins',
    icon: Icons.call_outlined,
    iconBg: Color(0xFFEAF3DE),
    iconColor: AppColors.lime700,
  ),
];
