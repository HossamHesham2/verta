import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/colors_manager.dart';

class CustomBoxButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData child;

  const CustomBoxButton({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ColorsManager.whiteFF,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.dark0F.withValues(alpha: 0.2),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(child,fontWeight: FontWeight.w900,size: 20.sp,),
      ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.2),
    );
  }
}
