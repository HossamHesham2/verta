import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verta/core/models/task_model.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/core/widgets/custom_box_button.dart';
import 'package:verta/core/widgets/custom_button.dart';
import 'package:verta/core/widgets/custom_field_bar.dart';
import 'package:verta/core/widgets/custom_glass_dialog.dart';
import 'package:verta/features/home/presentation/manager/home_bloc.dart';
import 'package:verta/features/task/presentation/widgets/custom_card_category.dart';
import 'package:verta/features/task/presentation/widgets/date_time_selector_widget.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> categories = ["Work", "Personal", "Shopping", "Health"];
  final List<String> priorities = ["Low", "Medium", "High"];

  final taskTitleController = TextEditingController();
  final descriptionController = TextEditingController();
  late TaskModel task;

  late String selectDate;
  late DateTime selectedDateTime;
  late String selectedCategory;
  late String selectedPriority;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInitialized) return;

    task = ModalRoute
        .of(context)!
        .settings
        .arguments as TaskModel;

    taskTitleController.text = task.taskTitle;
    descriptionController.text = task.description;

    selectedDateTime = task.date;
    selectDate = DateFormat('dd MMM yyyy HH:mm').format(task.date);

    selectedCategory = task.category;
    selectedPriority = task.priority;

    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    void editTask() {
      if (!_formKey.currentState!.validate()) return;

      final updatedTask = TaskModel(
        taskId: task.taskId,
        taskTitle: taskTitleController.text.trim(),
        description: descriptionController.text.trim(),
        date: selectedDateTime,
        category: selectedCategory,
        priority: selectedPriority,
        isCompleted: task.isCompleted,
      );

      context.read<HomeBloc>().add(UpdateTaskEvent(updatedTask));
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {

          if (state is UpdateTaskState) {
            CustomGlassDialog.showVariant(
              context: context,
              variant: DialogVariant.success,
              title: "Success",
              description: "Task updated successfully",
              buttonText: "OK",
              onTap: () => Navigator.pop(context),
            );
            context.read<HomeBloc>().add(GetAllTaskHomeEvent());
          }

          if (state is HomeFailure) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            CustomGlassDialog.showVariant(
              context: context,
              variant: DialogVariant.error,
              title: "Error",
              description: "Task updated Failed",
              buttonText: "OK",
            );
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// 🔹 Title
                      Row(
                        children: [
                          CustomBoxButton(
                            child: Icons.arrow_back_ios_new,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),

                          SizedBox(width: 20.w),
                          Text(
                            "Edit Task",
                            style: Theme
                                .of(
                              context,
                            )
                                .textTheme
                                .headlineSmall,
                          )
                              .animate()
                              .fadeIn(duration: 400.ms)
                              .slideY(begin: -0.2, end: 0),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      /// 🔹 First Card
                      _buildCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFieldBar(
                              title: "Task Title",
                              hintText: "Enter task title",
                              obscureText: false,
                              controller: taskTitleController,
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return "Task title is required";
                                }
                                if (value
                                    .trim()
                                    .length < 3) {
                                  return "Title must be at least 3 characters";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),

                            CustomFieldBar(
                              title: "Description",
                              hintText: "Enter task description",
                              obscureText: false,
                              controller: descriptionController,
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return "Description is required";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),

                            _buildSectionHeader(Icons.date_range, "Due Date"),
                            SizedBox(height: 12.h),

                            DateTimeSelectorWidget(
                              text: selectDate,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (_) =>
                                      SizedBox(
                                        height: 220.h,
                                        child: DateTimePickerWidget(
                                          initDateTime: DateTime.now(),
                                          minDateTime: DateTime.now(),
                                          maxDateTime: DateTime(2030, 12, 30),
                                          dateFormat: "yyyy/MM/dd HH:mm",
                                          onChange: (_, __) {},
                                          onConfirm: (dateTime, _) {
                                            setState(() {
                                              selectedDateTime = dateTime;
                                              selectDate =
                                              "${dateTime.year}/${dateTime.month
                                                  .toString().padLeft(
                                                  2, '0')}/${dateTime.day
                                                  .toString().padLeft(2, '0')} "
                                                  "${dateTime.hour
                                                  .toString()
                                                  .padLeft(2, '0')}:${dateTime
                                                  .minute.toString().padLeft(
                                                  2, '0')}";
                                            });
                                          },
                                        ),
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideX(
                          begin: -0.2, end: 0),

                      SizedBox(height: 24.h),

                      /// 🔹 Second Card
                      _buildCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader(
                              Icons.sell_outlined,
                              "Category",
                            ),
                            SizedBox(height: 12.h),

                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: categories.map((cat) {
                                return CustomCardCategory(
                                  text: cat,
                                  isSelected: selectedCategory == cat,
                                  onTap: () =>
                                      setState(
                                            () => selectedCategory = cat,
                                      ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: 20.h),

                            _buildSectionHeader(
                              Icons.flag_outlined,
                              "Priority",
                            ),
                            SizedBox(height: 12.h),

                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: priorities.map((p) {
                                return CustomCardCategory(
                                  text: p,
                                  isSelected: selectedPriority == p,
                                  onTap: () =>
                                      setState(() => selectedPriority = p),
                                  selectedGradient: _priorityGradient(p),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 500.ms)
                          .slideX(begin: 0.2, end: 0),

                      SizedBox(height: 24.h),

                      /// 🔹 Button
                      CustomButton(text: "Edit Task", onTap: editTask)
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 400.ms)
                          .scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.whiteFF,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.dark0F.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(5, 20),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: ColorsManager.dark0F),
        SizedBox(width: 5.w),
        Text(
          title,
          style: Theme
              .of(
            context,
          )
              .textTheme
              .titleMedium
              ?.copyWith(color: ColorsManager.dark0F),
        ),
      ],
    );
  }

  LinearGradient _priorityGradient(String priority) {
    switch (priority) {
      case "Low":
        return LinearGradient(
          colors: [ColorsManager.indigo_500, ColorsManager.cyan_500],
        );
      case "Medium":
        return LinearGradient(
          colors: [ColorsManager.yellow_500, ColorsManager.yellow_600],
        );
      case "High":
        return LinearGradient(
          colors: [ColorsManager.red_500, ColorsManager.red_600],
        );
      default:
        return LinearGradient(
          colors: [ColorsManager.indigo_500, ColorsManager.cyan_500],
        );
    }
  }
}
