import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Variant types for pre-configured dialogs

enum DialogVariant { success, error, info, warning }

class CustomGlassDialog {
  static Color _variantColor(DialogVariant v) => switch (v) {
    DialogVariant.success => Colors.green,
    DialogVariant.error => Colors.redAccent,
    DialogVariant.info => Colors.blueAccent,
    DialogVariant.warning => Colors.amber,
  };

  static IconData _variantIcon(DialogVariant v) => switch (v) {
    DialogVariant.success => Icons.check_circle_outline_rounded,
    DialogVariant.error => Icons.error_outline_rounded,
    DialogVariant.info => Icons.info_outline_rounded,
    DialogVariant.warning => Icons.warning_amber_rounded,
  };

  // ─── Main entry point ────────────────────────────────────────────────────────

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    String buttonText = 'Continue',
    VoidCallback? onTap,
    Color iconColor = Colors.green,
  }) {
    return _present(
      context: context,
      title: title,
      description: description,
      icon: icon,
      buttonText: buttonText,
      onTap: onTap,
      iconColor: iconColor,
    );
  }

  // ─── Convenience factory ──────────────────────────────────────────────────────

  static Future<void> showVariant({
    required BuildContext context,
    required DialogVariant variant,
    required String title,
    required String description,
    String buttonText = 'Continue',
    VoidCallback? onTap,
  }) {
    return _present(
      context: context,
      title: title,
      description: description,
      icon: _variantIcon(variant),
      iconColor: _variantColor(variant),
      buttonText: buttonText,
      onTap: onTap,
    );
  }

  // ─── Core builder ─────────────────────────────────────────────────────────────

  static Future<void> _present({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required String buttonText,
    VoidCallback? onTap,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.35),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (ctx, _, __) => _GlassDialogContent(
        title: title,
        description: description,
        icon: icon,
        iconColor: iconColor,
        buttonText: buttonText,
        onTap: onTap,
      ),
    );
  }
}

// ─── Stateless widget for the dialog content ─────────────────────────────────

class _GlassDialogContent extends StatelessWidget {
  const _GlassDialogContent({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.buttonText,
    this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final String buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: _DialogCard(
                  title: title,
                  description: description,
                  icon: icon,
                  iconColor: iconColor,
                  buttonText: buttonText,
                  onTap: onTap,
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(
          begin: const Offset(0.7, 0.7),
          curve: Curves.easeOutBack,
          duration: 500.ms,
        );
  }
}

// ─── The glass card itself ────────────────────────────────────────────────────

class _DialogCard extends StatelessWidget {
  const _DialogCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.buttonText,
    this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final String buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.22),
            Colors.white.withOpacity(0.08),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AnimatedIconRing(icon: icon, iconColor: iconColor),
          SizedBox(height: 24.h),
          _DialogTitle(title: title),
          SizedBox(height: 12.h),
          _DialogDescription(description: description),
          SizedBox(height: 28.h),
          _DialogButton(
            text: buttonText,
            onPressed: () {
              Navigator.pop(context);
              onTap?.call();
            },
          ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _AnimatedIconRing extends StatelessWidget {
  const _AnimatedIconRing({required this.icon, required this.iconColor});

  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withOpacity(0.15),
            border: Border.all(color: iconColor.withOpacity(0.4), width: 1.5.w),
          ),
          child: Icon(icon, color: iconColor, size: 40.sp),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.05, 1.05),
          duration: 1500.ms,
        );
  }
}

class _DialogTitle extends StatelessWidget {
  const _DialogTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        decoration: TextDecoration.none,
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3);
  }
}

class _DialogDescription extends StatelessWidget {
  const _DialogDescription({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 15.sp,
        height: 1.5,
        decoration: TextDecoration.none,
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 600.ms)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);
  }
}
