import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'My profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.sage150,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.edit_outlined,
            size: 18,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
