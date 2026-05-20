import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/core/models/task_model.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/features/home/presentation/manager/home_bloc.dart';
import 'package:verta/features/home/presentation/widgets/custom_card_task.dart';
import 'package:verta/features/home/presentation/widgets/custom_tab_bar.dart';

class CustomDefaultTabController extends StatefulWidget {
  final List<TaskModel> tasks;

  const CustomDefaultTabController({super.key, required this.tasks});

  @override
  State<CustomDefaultTabController> createState() =>
      _CustomDefaultTabControllerState();
}

class _CustomDefaultTabControllerState
    extends State<CustomDefaultTabController> {
  int currentIndex = 0;

  final List<String> categories = [
    "All",
    "Work",
    "Personal",
    "Shopping",
    "Health",
  ];

  List<TaskModel> _filterTasks(String category) {
    if (category == "All") return widget.tasks;

    return widget.tasks.where((task) => task.category == category).toList();
  }

  int get completedTasks =>
      widget.tasks.where((task) => task.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    final filtered = _filterTasks(categories[currentIndex]);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Tasks",
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(height: 10.h),

              SizedBox(
                height: 55.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: CustomTabBar(
                          text: categories[index],
                          isSelected: currentIndex == index,
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 10.h),
            ],
          ),
        ),

        filtered.isEmpty
            ? const SliverToBoxAdapter(
                child: Center(child: Text("No tasks here")),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final task = filtered[index];

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.taskDetailsScreen,
                          arguments: task,
                        );
                      },
                      child: Slidable(
                        key: ValueKey(task.taskId),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                context.read<HomeBloc>().add(
                                  DeleteTaskEvent(task.taskId),
                                );
                              },

                              backgroundColor: ColorsManager.red_600.withAlpha(
                                300,
                              ),
                              foregroundColor: ColorsManager.red_500,
                              icon: Icons.delete_outline,
                              borderRadius: BorderRadius.circular(16.r),
                              label: 'Delete',
                            ),
                            SizedBox(width: 5.w,),
                            SlidableAction(
                              onPressed: (_) {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.editTaskScreen,
                                  arguments: task,
                                );
                              },

                              backgroundColor: ColorsManager.green_600.withAlpha(
                                300,
                              ),
                              foregroundColor: ColorsManager.green_600,
                              icon: Icons.edit_note_outlined,
                              borderRadius: BorderRadius.circular(16.r),
                              label: 'Edit',
                            ),
                          ],
                        ),

                        child: CustomCardTask(
                          task: task,
                          countedTaskComplete: (_) {
                            context.read<HomeBloc>().add(GetAllTaskHomeEvent());
                          },
                        ),
                      ),
                    ),
                  );
                }, childCount: filtered.length),
              ),
      ],
    );
  }
}
