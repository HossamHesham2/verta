import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/assets_manager.dart';
import 'package:verta/core/utils/colors_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.indigo_500,
            ColorsManager.indigo_500,
            ColorsManager.cyan_500,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.dark0F.withValues(alpha: 0.12),
                      blurRadius: 25,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Image.asset(ImagesManager.logo, width: 120.w),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1))
                  .moveY(begin: 20, end: 0),

              SizedBox(height: 20.h),

              // Title
              Text(
                "Verta",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ColorsManager.whiteFF,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 600.ms)
                  .moveY(begin: 15, end: 0),

              SizedBox(height: 10.h),

              // Subtitle
              Text(
                "Organize your life seamlessly",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorsManager.whiteFF,
                ),
              )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 700.ms)
                  .moveY(begin: 10, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}