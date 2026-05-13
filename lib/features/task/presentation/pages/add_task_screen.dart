import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/core/models/task_model.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/core/widgets/custom_button.dart';
import 'package:verta/core/widgets/custom_field_bar.dart';
import 'package:verta/core/widgets/custom_glass_dialog.dart';
import 'package:verta/features/task/presentation/manager/task_bloc.dart';
import 'package:verta/features/task/presentation/manager/task_event.dart';
import 'package:verta/features/task/presentation/manager/task_state.dart';
import 'package:verta/features/task/presentation/widgets/custom_card_category.dart';
import 'package:verta/features/task/presentation/widgets/date_time_selector_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String selectDate = "Select Date";
  DateTime selectedDateTime = DateTime.now();
  String selectedCategory = "Work";
  String selectedPriority = "Medium";

  final _formKey = GlobalKey<FormState>();

  final List<String> categories = ["Work", "Personal", "Shopping", "Health"];
  final List<String> priorities = ["Low", "Medium", "High"];

  final taskTitleController = TextEditingController();
  final descriptionController = TextEditingController();

  void _saveTask() {
    if (!_formKey.currentState!.validate()) return;

    if (selectDate == "Select Date") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a due date")));
      return;
    }

    final task = TaskModel.create(
      taskTitle: taskTitleController.text.trim(),
      description: descriptionController.text.trim(),
      date: selectedDateTime,
      category: selectedCategory,
      priority: selectedPriority,
    );

    context.read<TaskBloc>().add(AddTaskEvent(task));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            }
            if (state is TaskSuccess) {
              Navigator.pop(context); // close loading

              CustomGlassDialog.showVariant(
                context: context,
                variant: DialogVariant.success,
                title: "Success",
                description: "Task added successfully",
                buttonText: "OK",
                onTap: () {
                  taskTitleController.clear();
                  descriptionController.clear();

                  setState(() {
                    selectDate = "Select Date";
                    selectedDateTime = DateTime.now();
                  });

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteName.mainLayout,
                    (route) => false,
                  );
                },
              );
            }

            if (state is TaskFailure) {
              Navigator.pop(context); // close loading

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔹 Title
                      Text(
                            "Add New Task",
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .slideY(begin: -0.2, end: 0),

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
                                if (value == null || value.trim().isEmpty) {
                                  return "Task title is required";
                                }
                                if (value.trim().length < 3) {
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
                                if (value == null || value.trim().isEmpty) {
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
                                showBottomSheet(
                                  context: context,
                                  builder: (_) => SizedBox(
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
                                              "${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')} "
                                              "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0),

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
                                      onTap: () => setState(
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
                                      onTap: () => setState(
                                        () => selectedPriority = p,
                                      ),
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
                      CustomButton(text: "Create Task", onTap: _saveTask)
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 400.ms)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1, 1),
                          ),

                      SizedBox(height: 100.h),
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
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: ColorsManager.dark0F),
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
