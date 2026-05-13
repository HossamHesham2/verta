
import 'package:flutter/material.dart';

class ColorsManager {
  // ─── PRIMARY COLORS ─────────────────────────────
  static const Color indigo_500 = Color(0xFF6366F1);
  static const Color indigo_600 = Color(0xFF4F46E5);
  static const Color lavenderBlue = Color(0xFFEEEDFD);

  static const Color cyan_500 = Color(0xFF06B6D4);
  static const Color cyan_600 = Color(0xFF0891B2);
  static const Color lightCyan = Color(0xFFE5F5FA);

  static const Color blue_500 = Color(0xFF2B7FFF);
  static const Color blue_600 = Color(0xFF155DFC);

  static const Color green_500 = Color(0xFF00C950);
  static const Color green_600 = Color(0xFF00A63E);

  static const Color red_500 = Color(0xFFFB2C36);
  static const Color red_600 = Color(0xFFE11D48);

  static const Color yellow_500 = Color(0xFFF0B100);
  static const Color yellow_600 = Color(0xFFD08700);

  // ─── NEUTRALS (IMPORTANT FOR UI) ────────────────
  static const Color whiteFF = Color(0xFFFFFFFF);
  static const Color whiteF0 = Color(0xFFF0F0F0);

  static const Color dark0F = Color(0xFF0F172A);
  static const Color dark1E = Color(0xFF1E293B);
  static const Color dark2B = Color(0xFF334155);

  static const Color grey_100 = Color(0xFFF1F5F9);
  static const Color grey_200 = Color(0xFFE2E8F0);
  static const Color grey_300 = Color(0xFFCBD5E1);
  static const Color grey_400 = Color(0xFF94A3B8);
  static const Color grey_500 = Color(0xFF64748B);
  static const Color grey_600 = Color(0xFF475569);
  static const Color grey_700 = Color(0xFF334155);
  static const Color transparent = Colors.transparent;

  // ─── SEMANTIC COLORS ────────────────────────────
  static const Color success = green_500;
  static const Color warning = yellow_500;
  static const Color error = red_500;
  static const Color info = blue_500;

  // ─── BACKGROUND SHADES ──────────────────────────
  static const Color bgLight = grey_100;
  static const Color bgDark = dark0F;

  // ─── TEXT COLORS ────────────────────────────────
  static const Color textPrimaryLight = dark0F;
  static const Color textSecondaryLight = grey_600;

  static const Color textPrimaryDark = whiteFF;
  static const Color textSecondaryDark = grey_300;
}
