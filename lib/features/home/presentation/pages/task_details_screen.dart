import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/core/models/task_model.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/core/widgets/custom_box_button.dart';
import 'package:verta/core/widgets/custom_button.dart';
import 'package:verta/core/widgets/custom_glass_dialog.dart';
import 'package:verta/features/home/presentation/manager/home_bloc.dart';
import 'package:verta/features/home/presentation/widgets/custom_card_detail.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)?.settings.arguments as TaskModel;
    Color getColorPriority() {
      if (task.priority == "High") {
        return ColorsManager.red_600;
      } else if (task.priority == "Medium") {
        return ColorsManager.yellow_600;
      } else if (task.priority == "Low") {
        return ColorsManager.indigo_600;
      } else {
        return ColorsManager.whiteFF;
      }
    }

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccessState) {
          CustomGlassDialog.showVariant(
            context: context,
            variant: DialogVariant.success,
            title: "Task",
            description: "Task Completed Successfully",
          );
        }
        if (state is DeleteTaskState) {
          CustomGlassDialog.show(
            context: context,
            title: "Task",
            description: "Task Deleted Successfully",
            iconColor: ColorsManager.red_500,
            icon: Icons.delete_outline,
            buttonText: "Delete",
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.mainLayout,
              (route) => false,
            ),
          );
        }

        if (state is HomeFailure) {
          CustomGlassDialog.showVariant(
            context: context,
            variant: DialogVariant.error,
            title: "Task",
            description: state.error,
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.mainLayout,
              (route) => false,
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomBoxButton(
                      child: Icons.arrow_back_ios_new,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    SizedBox(width: 20.w),
                    Expanded(
                      child:
                          Text(
                                "Task Details",
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(color: ColorsManager.dark0F),
                              )
                              .animate()
                              .fadeIn(duration: 400.ms)
                              .slideY(begin: -0.2, end: 0),
                    ),
                    CustomBoxButton(
                      child: Icons.edit_note_outlined,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.editTaskScreen,
                          arguments: task,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.taskTitle,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: ColorsManager.dark0F),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        task.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorsManager.grey_500,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomCardDetail(
                        mainText: "Due Date",
                        icon: Icons.date_range,
                        subText: formatDate(task.date),
                        bgIconColor: ColorsManager.lavenderBlue,
                        iconColor: ColorsManager.indigo_600,
                      ),
                      SizedBox(height: 10.h),
                      CustomCardDetail(
                        mainText: "Priority",
                        icon: Icons.flag_outlined,
                        subText: task.priority,
                        bgIconColor: getColorPriority(),
                        iconColor: ColorsManager.whiteFF,
                      ),
                      SizedBox(height: 10.h),
                      CustomCardDetail(
                        mainText: "Priority",
                        icon: Icons.sell_outlined,
                        subText: task.category,
                        bgIconColor: ColorsManager.lightCyan,
                        iconColor: ColorsManager.cyan_600,
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.2),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: task.isCompleted
                            ? "Completed"
                            : "Mark As Complete",
                        onTap: task.isCompleted
                            ? null
                            : () {
                                context.read<HomeBloc>().add(
                                  IsCompletedEvent(task.taskId),
                                );
                              },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        context.read<HomeBloc>().add(
                          DeleteTaskEvent(task.taskId),
                        );
                      },
                      child: Container(
                        height: 55.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: ColorsManager.red_600.withAlpha(300),
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          color: ColorsManager.red_600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
