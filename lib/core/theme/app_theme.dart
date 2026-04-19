import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static final TextTheme _baseTextTheme = GoogleFonts.outfitTextTheme().apply(
    bodyColor: AppColors.sage900,
    displayColor: AppColors.sage900,
  );

  static final ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundCream,
    colorScheme: const ColorScheme.light(
      primary: AppColors.sage700,
      onPrimary: AppColors.surface,
      secondary: AppColors.sage400,
      onSecondary: AppColors.sage900,
      surface: AppColors.surface,
      onSurface: AppColors.sage900,
      outline: AppColors.neutral300,
    ),
    textTheme: _baseTextTheme,
    useMaterial3: true,
  );
}
