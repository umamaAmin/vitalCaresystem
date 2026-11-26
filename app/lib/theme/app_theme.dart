import 'package:material_ui/material_ui.dart';

/// Brand text shown on the logo (Figma says EASY CARE). Change here if needed.
const String kAppBrand = 'EASY CARE';
const String kAppName = 'Health Mate';

class AppColors {
  static const navy = Color(0xFF2E3192);
  static const ink = Color(0xFF1B1F3B);
  static const muted = Color(0xFF5F6480);
  static const bgStart = Color(0xFFFFFFFF);
  static const bgEnd = Color(0xFFE6EAFF);
  static const fieldBorder = Color(0xFFE3E6F5);
  static const red = Color(0xFFFF4D4F);
  static const redSoft = Color(0xFFFFEAEA);
  static const green = Color(0xFF22B14C);
  static const amber = Color(0xFFFFC21A);
  static const iconGrey = Color(0xFF7B7B7B);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.navy),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: AppColors.ink,
          displayColor: AppColors.ink,
        ),
  );
}
