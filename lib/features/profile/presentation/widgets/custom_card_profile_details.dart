import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/colors_manager.dart';

class CustomCardProfileDetails extends StatelessWidget {
  final String mainText;

  final String subText;
  final Color? iconColor;
  final List<Color> colors;
  final IconData? icon;

  const CustomCardProfileDetails({
    super.key,
    required this.mainText,
    required this.subText,
    this.iconColor,
    required this.colors,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorsManager.whiteFF,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.dark0F.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(5, 20),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(15),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [BoxShadow(color: ColorsManager.dark0F.withAlpha(20))],
              gradient: LinearGradient(colors: colors),
            ),
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainText,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: ColorsManager.grey_600),
              ),
              Text(
                subText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorsManager.dark0F,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
