import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const List<String> _fallbackFamilies = ['Poppins'];

  static TextStyle _outfit({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.outfit(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      textStyle: const TextStyle(
        fontFamilyFallback: _fallbackFamilies,
      ),
    );
  }

  // Brand wordmark: friendly and modern with heavier weight.
  static final TextStyle wordmark = _outfit(
    color: AppColors.sage900,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.2,
  );

  // Subtitle: understated small-caps feeling.
  static final TextStyle subtitleCaps = _outfit(
    color: AppColors.sage500,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
  );

  static final TextStyle navItemActive = _outfit(
    color: AppColors.sage600,
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle navItemInactive = _outfit(
    color: AppColors.neutral700,
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle buttonLabel = _outfit(
    color: AppColors.surface,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static final TextStyle taskTitle = _outfit(
    color: AppColors.sage900,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  static final TextStyle taskSubtitle = _outfit(
    color: AppColors.sage500,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
