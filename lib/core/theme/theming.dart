import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verta/core/utils/colors_manager.dart';

class Theming {
  // ─── LIGHT TEXT THEME ─────────────────────────────────────────────
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    displayMedium: TextStyle(
      fontSize: 45.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    displaySmall: TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    headlineLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headlineMedium: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    titleLarge: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.grey_200,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.dark0F,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    labelSmall: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.grey_200,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  );

  // ─── DARK TEXT THEME ──────────────────────────────────────────────
  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    displayMedium: TextStyle(
      fontSize: 45.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    displaySmall: TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    headlineLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headlineMedium: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    titleLarge: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.grey_100,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.whiteFF,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    labelSmall: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.grey_100,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  );

  // ─── THEMES ───────────────────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.whiteFF,
    textTheme: _lightTextTheme,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.dark0F,
    textTheme: _darkTextTheme,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}