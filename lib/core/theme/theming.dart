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
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    displayMedium: TextStyle(
      fontSize: 45.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    displaySmall: TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    headlineLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headlineMedium: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    titleLarge: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.textPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryLight,
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
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    displayMedium: TextStyle(
      fontSize: 45.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    displaySmall: TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    headlineLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headlineMedium: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    titleLarge: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),

    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    labelSmall: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.textPrimaryDark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  );

  // ─── THEMES ───────────────────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.whiteFF,
    textTheme: _lightTextTheme,
    fontFamily: GoogleFonts.poppins().fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.whiteFF,

      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      prefixIconColor: ColorsManager.textSecondaryLight,
      suffixIconColor: ColorsManager.textSecondaryLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.dark0F,
    textTheme: _darkTextTheme,
    fontFamily: GoogleFonts.poppins().fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.whiteFF,
      prefixIconColor: ColorsManager.textSecondaryDark,
      suffixIconColor: ColorsManager.textSecondaryDark,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(
          color: ColorsManager.whiteFF.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
    ),
  );
}
