import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:verta/core/helpers/shared_pref_helper.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/core/utils/const_variables.dart';

class CustomCardTask extends StatefulWidget {
  const CustomCardTask({super.key});

  @override
  State<CustomCardTask> createState() => _CustomCardTaskState();
}

class _CustomCardTaskState extends State<CustomCardTask> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 113.h,
      decoration: BoxDecoration(
        color: ColorsManager.whiteFF,

        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [BoxShadow(color: ColorsManager.dark1E.withAlpha(20))],
      ),
      child: Row(
        children: [
          Column(
            children: [
              RoundCheckBox(
                isChecked: isDone,
                checkedColor: Colors.transparent,
                border: isDone
                    ? Border.all(color: ColorsManager.success, width: 1.5.w)
                    : Border.all(color: Colors.black, width: 1.5.w),
                size: 22.sp,
                animationDuration: const Duration(milliseconds: 200),
                checkedWidget: Icon(
                  Icons.check,
                  color: isDone ? ColorsManager.success : null,
                  fontWeight: FontWeight.w600,
                  size: 12.sp,
                ),
                onTap: (bool? selected) async {
                  isDone = selected ?? false;
                  await SharedPrefHelper.setData(ConstVariables.isDone, isDone);

                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Title',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    color: isDone ? Colors.grey : ColorsManager.dark0F,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Task Description',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    color: isDone ? Colors.grey : ColorsManager.grey_500,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.date_range_outlined,
                          color: ColorsManager.grey_600,
                          fontWeight: FontWeight.w600,
                          size: 12.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '09:00 AM',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: ColorsManager.grey_600),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          width: 10.w,
                          height: 10,
                          decoration: BoxDecoration(
                            color: ColorsManager.red_500,
                            borderRadius: BorderRadius.circular(200.r),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'High',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: ColorsManager.grey_600),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
