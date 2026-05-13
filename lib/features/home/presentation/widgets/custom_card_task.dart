import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:verta/core/models/task_model.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:intl/intl.dart';

class CustomCardTask extends StatefulWidget {
  final TaskModel task;
  Function(int?)? countedTaskComplete;

  CustomCardTask({super.key, required this.task, this.countedTaskComplete});

  @override
  State<CustomCardTask> createState() => _CustomCardTaskState();
}

class _CustomCardTaskState extends State<CustomCardTask> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10.h),
      height: 113.h,
      decoration: BoxDecoration(
        color: ColorsManager.whiteFF,

        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.dark0F.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              RoundCheckBox(
                isChecked: widget.task.isCompleted,
                checkedColor: ColorsManager.transparent,
                uncheckedColor: ColorsManager.whiteFF,
                isRound: true,
                uncheckedWidget: Icon(
                  Icons.remove,
                  color: widget.task.isCompleted ? null : ColorsManager.dark0F,
                  fontWeight: FontWeight.w600,
                  size: 12.sp,
                ),
                border: widget.task.isCompleted
                    ? Border.all(color: ColorsManager.success, width: 1.5.w)
                    : Border.all(color: ColorsManager.dark0F, width: 1.5.w),
                size: 22.sp,
                animationDuration: const Duration(milliseconds: 200),
                checkedWidget: Icon(
                  Icons.check,
                  color: widget.task.isCompleted ? ColorsManager.success : null,
                  fontWeight: FontWeight.w600,
                  size: 12.sp,
                ),
                  onTap: (bool? selected) async {
                    setState(() {
                      widget.task.isCompleted = selected ?? false;
                    });

                    await widget.task.save();

                    widget.countedTaskComplete?.call(null);
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
                  widget.task.taskTitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
                    color: widget.task.isCompleted ? Colors.grey : ColorsManager.dark0F,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.task.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
                    color: widget.task.isCompleted ? Colors.grey : ColorsManager.grey_500,
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
                          formatDate(widget.task.date),
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
                            color: getColorPriority(),
                            borderRadius: BorderRadius.circular(200.r),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          widget.task.priority,
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

  Color getColorPriority() {
    if (widget.task.priority == "High") {
      return ColorsManager.red_600;
    } else if (widget.task.priority == "Medium") {
      return ColorsManager.yellow_600;
    } else if (widget.task.priority == "Low") {
      return ColorsManager.indigo_600;
    } else {
      return ColorsManager.whiteFF;
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy HH:mm  ').format(date);
  }
}
