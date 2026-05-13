import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/colors_manager.dart';

class ProgressCard extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;

  const ProgressCard({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    double progress = totalTasks == 0
        ? 0.0
        : completedTasks / totalTasks;
    final safeProgress = progress.clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.whiteFF,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [ColorsManager.indigo_500, ColorsManager.cyan_500],
                  ),
                ),
                child: const Icon(Icons.trending_up, color: Colors.white),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Progress",
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: ColorsManager.dark0F,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Text(
                      '$completedTasks of $totalTasks completed',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorsManager.grey_500,
                      ),
                    ),
                  ],
                ),
              ),

              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: safeProgress),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Text(
                    '${(value * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w900,
                      color: ColorsManager.indigo_600,
                    ),
                  );
                },
              ),
            ],
          ),

          SizedBox(height: 18.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              height: 10.h,
              width: double.infinity,
              color: Colors.grey.shade200,

              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: safeProgress),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorsManager.indigo_500,
                              ColorsManager.cyan_500,
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
