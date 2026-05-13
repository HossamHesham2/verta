import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/colors_manager.dart';

class CustomCardDetail extends StatelessWidget {
  final String mainText;

  final String subText;
  final Color? iconColor;
  final Color? bgIconColor;
  final IconData? icon;

  const CustomCardDetail({
    super.key,
    required this.mainText,
    required this.subText,
    this.iconColor,
    this.bgIconColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(color: ColorsManager.whiteFF),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(15),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [BoxShadow(color: ColorsManager.dark0F.withAlpha(20))],
              color: bgIconColor,
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
