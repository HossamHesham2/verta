import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/colors_manager.dart';

class CustomTabBar extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CustomTabBar({super.key, required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: isSelected ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        gradient: isSelected
            ? LinearGradient(
                colors: [ColorsManager.indigo_500, ColorsManager.cyan_500],
              )
            : null,
      ),
      child: Text(
        text,
        style: isSelected
            ? Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: ColorsManager.whiteFF)
            : Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
