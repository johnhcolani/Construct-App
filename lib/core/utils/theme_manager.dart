import 'package:flutter/material.dart';
import 'color_manager.dart';

class ThemeManager {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorManager.backgroundLight,
    primaryColor: ColorManager.primaryBlue,
    colorScheme: ColorScheme.light(
      primary: ColorManager.primaryBlue,
      secondary: ColorManager.secondaryTeal,
      surface: ColorManager.surfaceGrey,
      error: ColorManager.errorRed,
      onPrimary: ColorManager.textWhite,
      onSecondary: ColorManager.textWhite,
      onSurface: ColorManager.textPrimary,
      onError: ColorManager.textWhite,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: ColorManager.textPrimary),
      bodyMedium: TextStyle(color: ColorManager.textSecondary),
      labelLarge: TextStyle(color: ColorManager.textPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryBlue,
        foregroundColor: ColorManager.textWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.surfaceGrey,
      labelStyle: TextStyle(color: ColorManager.textSecondary),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryBlue,
          width: 2,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorManager.backgroundDark,
    primaryColor: ColorManager.primaryBlueDeep,
    colorScheme: ColorScheme.dark(
      primary: ColorManager.primaryBlueDeep,
      secondary: ColorManager.secondaryTealDeep,
      surface: ColorManager.surfaceDark,
      error: ColorManager.errorRed,
      onPrimary: ColorManager.textWhite,
      onSecondary: ColorManager.textWhite,
      onSurface: ColorManager.textOffWhite,
      onError: ColorManager.textWhite,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: ColorManager.textOffWhite),
      bodyMedium: TextStyle(color: ColorManager.textSecondary),
      labelLarge: TextStyle(color: ColorManager.textOffWhite),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryBlueDeep,
        foregroundColor: ColorManager.textWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.surfaceDark,
      labelStyle: TextStyle(color: ColorManager.textSecondary),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryBlueDeep,
          width: 2,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );
}