import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:verta/core/widgets/custom_box_button.dart';
import 'package:verta/features/home/presentation/manager/home_bloc.dart';
import 'package:verta/features/home/presentation/widgets/custom_default_tab_controller.dart';
import 'package:verta/features/home/presentation/widgets/progress_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String fullName =
      FirebaseAuth.instance.currentUser?.displayName ?? 'User';

  String get firstName =>
      fullName.trim().isNotEmpty ? fullName.trim().split(' ').first : 'User';

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetAllTaskHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, $firstName',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              int tasksCount = 0;
                              if (state is TaskLoadedHomeState) {
                                tasksCount = state.tasks.length;
                              }
                              return Text(
                                'You Have $tasksCount tasks today',
                                style: Theme.of(context).textTheme.titleSmall,
                              );
                            },
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                    CustomBoxButton(child: Icons.notifications_none),
                  ],
                ),
                SizedBox(height: 25.h),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is TaskLoadedHomeState) {
                      final completedTasks = state.tasks
                          .where((task) => task.isCompleted)
                          .length;

                      return ProgressCard(
                        completedTasks: completedTasks,
                        totalTasks: state.tasks.length,
                      );
                    }

                    return const SizedBox();
                  },
                ),
                SizedBox(height: 25.h),

                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is HomeFailure) {
                        return Center(child: Text(state.error));
                      }
                      if (state is TaskLoadedHomeState) {
                        final tasks = state.tasks;
                        if (tasks.isEmpty) {
                          return const Center(child: Text("No tasks yet"));
                        }
                        return CustomDefaultTabController(tasks: tasks);
                      }
                      return const SizedBox();
                    },
                  ),
                ),

                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
