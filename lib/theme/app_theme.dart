import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
class AppTheme {
  AppTheme._();

  // Terminal color scheme - Enhanced Hacker Phosphor
  static const Color primaryTerminal =
      Color(0xFF00FF00); // Bright phosphor green
  static const Color primaryVariantTerminal = Color(0xFF008000); // Dimmed green
  static const Color secondaryTerminal =
      Color(0xFF00FF00); // Consistent with primary
  static const Color backgroundTerminal = Color(0xFF000000); // Pure black
  static const Color surfaceTerminal =
      Color(0xFF000000); // Consistent black surfaces
  static const Color errorTerminal = Color(0xFFFF0000); // Classic terminal red
  static const Color warningTerminal = Color(0xFFFFFF00); // Terminal yellow
  static const Color inactiveTerminal = Color(0xFF004000); // Very dark green
  static const Color onPrimaryTerminal = Color(0xFF000000); // Black on green
  static const Color onSecondaryTerminal = Color(0xFF000000); // Black on green
  static const Color onBackgroundTerminal = Color(0xFF00FF00); // Green on black
  static const Color onSurfaceTerminal = Color(0xFF00FF00); // Green on black
  static const Color onErrorTerminal = Color(0xFF000000); // Black on red

  // Enhanced hacker terminal colors
  static const Color matrixGreen =
      Color(0xFF00DD00); // Slightly brighter matrix green
  static const Color scanlineGreen =
      Color(0xFF003300); // Very dark green for scan lines
  static const Color glowGreen =
      Color(0xFF88FF88); // Light green for glow effects
  static const Color hackingBlue = Color(0xFF0088FF); // Cyber blue accent
  static const Color dataOrange = Color(0xFFFF8800); // Data stream orange
  static const Color criticalRed = Color(0xFFFF4444); // Enhanced red for alerts

  // Text emphasis colors for terminal theme
  static const Color textHighEmphasisTerminal = Color(0xFF00FF00); // Full green
  static const Color textMediumEmphasisTerminal =
      Color(0xCC00FF00); // 80% green
  static const Color textDisabledTerminal = Color(0x61004000); // Very dim green
  static const Color textGlowTerminal = Color(0xFFAAFFAA); // Glow effect text

  /// Terminal theme (primary theme for anonymous messaging)
  static ThemeData terminalTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryTerminal,
      onPrimary: onPrimaryTerminal,
      primaryContainer: primaryVariantTerminal,
      onPrimaryContainer: onPrimaryTerminal,
      secondary: secondaryTerminal,
      onSecondary: onSecondaryTerminal,
      secondaryContainer: primaryVariantTerminal,
      onSecondaryContainer: onSecondaryTerminal,
      tertiary: secondaryTerminal,
      onTertiary: onSecondaryTerminal,
      tertiaryContainer: primaryVariantTerminal,
      onTertiaryContainer: onSecondaryTerminal,
      error: errorTerminal,
      onError: onErrorTerminal,
      surface: surfaceTerminal,
      onSurface: onSurfaceTerminal,
      onSurfaceVariant: onSurfaceTerminal,
      outline: primaryTerminal,
      outlineVariant: inactiveTerminal,
      shadow: Colors.transparent, // No shadows in terminal
      scrim: Colors.transparent,
      inverseSurface: primaryTerminal,
      onInverseSurface: backgroundTerminal,
      inversePrimary: backgroundTerminal,
    ),
    scaffoldBackgroundColor: backgroundTerminal,
    cardColor: backgroundTerminal,
    dividerColor: primaryTerminal,
    appBarTheme: AppBarTheme(
      color: backgroundTerminal,
      foregroundColor: primaryTerminal,
      elevation: 0.0, // No elevation for flat terminal aesthetic
      titleTextStyle: GoogleFonts.courierPrime(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: primaryTerminal,
      ),
    ),
    cardTheme: CardThemeData(
      color: backgroundTerminal,
      elevation: 0.0, // No shadows
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Sharp corners for terminal
        side: BorderSide(color: primaryTerminal, width: 1.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundTerminal,
      selectedItemColor: primaryTerminal,
      unselectedItemColor: inactiveTerminal,
      elevation: 0.0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: backgroundTerminal,
      foregroundColor: primaryTerminal,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: primaryTerminal, width: 1.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: backgroundTerminal,
        backgroundColor: primaryTerminal,
        elevation: 0.0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        textStyle: GoogleFonts.courierPrime(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryTerminal,
        backgroundColor: backgroundTerminal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        side: BorderSide(color: primaryTerminal, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        textStyle: GoogleFonts.courierPrime(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryTerminal,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        textStyle: GoogleFonts.courierPrime(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    textTheme: _buildTerminalTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: backgroundTerminal,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: primaryTerminal, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: inactiveTerminal, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: primaryTerminal, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: errorTerminal, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: errorTerminal, width: 2.0),
      ),
      labelStyle: GoogleFonts.courierPrime(
        color: textMediumEmphasisTerminal,
        fontSize: 14,
      ),
      hintStyle: GoogleFonts.courierPrime(
        color: textDisabledTerminal,
        fontSize: 14,
      ),
      prefixStyle: GoogleFonts.courierPrime(
        color: primaryTerminal,
        fontSize: 14,
      ),
      suffixStyle: GoogleFonts.courierPrime(
        color: primaryTerminal,
        fontSize: 14,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryTerminal;
        }
        return inactiveTerminal;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryTerminal.withValues(alpha: 0.3);
        }
        return inactiveTerminal.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryTerminal;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(backgroundTerminal),
      side: BorderSide(color: primaryTerminal, width: 1.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryTerminal;
        }
        return Colors.transparent;
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryTerminal,
      linearTrackColor: inactiveTerminal,
      circularTrackColor: inactiveTerminal,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryTerminal,
      thumbColor: primaryTerminal,
      overlayColor: primaryTerminal.withValues(alpha: 0.2),
      inactiveTrackColor: inactiveTerminal,
      trackHeight: 2.0,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: primaryTerminal,
      unselectedLabelColor: inactiveTerminal,
      indicatorColor: primaryTerminal,
      labelStyle: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: primaryTerminal,
        border: Border.all(color: primaryTerminal, width: 1.0),
      ),
      textStyle: GoogleFonts.courierPrime(
        color: backgroundTerminal,
        fontSize: 12,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: backgroundTerminal,
      contentTextStyle: GoogleFonts.courierPrime(
        color: primaryTerminal,
        fontSize: 14,
      ),
      actionTextColor: primaryTerminal,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: primaryTerminal, width: 1.0),
      ),
    ),
    dialogTheme: DialogThemeData(backgroundColor: backgroundTerminal),
  );

  /// Light theme (fallback - maintains terminal aesthetic with inverted colors)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: backgroundTerminal,
      onPrimary: primaryTerminal,
      primaryContainer: Color(0xFF333333),
      onPrimaryContainer: primaryTerminal,
      secondary: backgroundTerminal,
      onSecondary: primaryTerminal,
      secondaryContainer: Color(0xFF333333),
      onSecondaryContainer: primaryTerminal,
      tertiary: backgroundTerminal,
      onTertiary: primaryTerminal,
      tertiaryContainer: Color(0xFF333333),
      onTertiaryContainer: primaryTerminal,
      error: errorTerminal,
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: backgroundTerminal,
      onSurfaceVariant: backgroundTerminal,
      outline: backgroundTerminal,
      outlineVariant: Color(0xFF666666),
      shadow: Colors.transparent,
      scrim: Colors.transparent,
      inverseSurface: backgroundTerminal,
      onInverseSurface: primaryTerminal,
      inversePrimary: primaryTerminal,
    ),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    cardColor: Color(0xFFFFFFFF),
    dividerColor: backgroundTerminal,
    textTheme: _buildLightTerminalTextTheme(),
    dialogTheme: DialogThemeData(backgroundColor: Color(0xFFFFFFFF)),
  );

  /// Dark theme (same as terminal theme for consistency)
  static ThemeData darkTheme = terminalTheme;

  /// Helper method to build terminal text theme
  static TextTheme _buildTerminalTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.courierPrime(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      displayMedium: GoogleFonts.courierPrime(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      displaySmall: GoogleFonts.courierPrime(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      headlineLarge: GoogleFonts.courierPrime(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      headlineMedium: GoogleFonts.courierPrime(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      headlineSmall: GoogleFonts.courierPrime(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      titleLarge: GoogleFonts.courierPrime(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.courierPrime(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      titleSmall: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      bodyLarge: GoogleFonts.courierPrime(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      bodyMedium: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      bodySmall: GoogleFonts.courierPrime(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasisTerminal,
        letterSpacing: 0,
      ),
      labelLarge: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisTerminal,
        letterSpacing: 0,
      ),
      labelMedium: GoogleFonts.courierPrime(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasisTerminal,
        letterSpacing: 0,
      ),
      labelSmall: GoogleFonts.courierPrime(
        fontSize: 10,
        fontWeight: FontWeight.w300,
        color: textDisabledTerminal,
        letterSpacing: 0,
      ),
    );
  }

  /// Helper method to build light terminal text theme
  static TextTheme _buildLightTerminalTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.courierPrime(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      displayMedium: GoogleFonts.courierPrime(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      displaySmall: GoogleFonts.courierPrime(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      headlineLarge: GoogleFonts.courierPrime(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      headlineMedium: GoogleFonts.courierPrime(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      headlineSmall: GoogleFonts.courierPrime(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      titleLarge: GoogleFonts.courierPrime(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.courierPrime(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      titleSmall: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      bodyLarge: GoogleFonts.courierPrime(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      bodyMedium: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      bodySmall: GoogleFonts.courierPrime(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF666666),
        letterSpacing: 0,
      ),
      labelLarge: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: backgroundTerminal,
        letterSpacing: 0,
      ),
      labelMedium: GoogleFonts.courierPrime(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF666666),
        letterSpacing: 0,
      ),
      labelSmall: GoogleFonts.courierPrime(
        fontSize: 10,
        fontWeight: FontWeight.w300,
        color: Color(0xFF999999),
        letterSpacing: 0,
      ),
    );
  }
}
