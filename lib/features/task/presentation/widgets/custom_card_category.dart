import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/colors_manager.dart';

class CustomCardCategory extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;
  final LinearGradient? selectedGradient;

  const CustomCardCategory({
    super.key,
    required this.text,
    required this.isSelected,
    this.onTap,
    this.selectedGradient,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = selectedGradient ??
        LinearGradient(colors: [ColorsManager.indigo_500, ColorsManager.cyan_500]);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          gradient: isSelected ? gradient : null,
          border: isSelected
              ? null
              : Border.all(color: ColorsManager.dark0F.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isSelected ? Colors.white : ColorsManager.dark0F,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}