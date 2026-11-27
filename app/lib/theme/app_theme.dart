import 'package:material_ui/material_ui.dart';
import 'app_palette.dart';

/// Brand text shown on the logo. Change here if needed.
const String kAppBrand = 'EASY CARE';
const String kAppName = 'Health Mate';

/// Old names are kept so every existing screen follows the new palette
/// automatically. "navy" is now the main teal brand colour.
class AppColors {
  static const navy = AppPalette.teal;
  static const ink = AppPalette.ink;
  static const muted = AppPalette.muted;
  static const bgStart = AppPalette.mint;
  static const bgEnd = Color(0xFFD5F3EE);
  static const fieldBorder = Color(0xFFCDE9E4);
  static const red = Color(0xFFE5484D);
  static const redSoft = Color(0xFFFDECEC);
  static const green = Color(0xFF22A06B);
  static const amber = Color(0xFFF5A524);
  static const iconGrey = AppPalette.teal;

  // New helpers
  static const tint = Color(0xFFE6F6F3);      // soft teal fill for fields/boxes
  static const tintDeep = AppPalette.mintDeep; // avatar / icon circles
}

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppPalette.teal,
    primary: AppPalette.teal,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppPalette.mint,
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: AppPalette.ink,
          displayColor: AppPalette.ink,
        ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppPalette.tealDark,
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? AppPalette.teal : null,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? Colors.white : null,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? AppPalette.teal : null,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppPalette.teal),
    ),
  );
}