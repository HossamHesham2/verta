import 'package:flutter/material.dart';
import 'package:verta/core/widgets/custom_bottom_nav_bar.dart';
import 'package:verta/features/home/presentation/pages/home_screen.dart';
import 'package:verta/features/profile/presentation/pages/profile_screen.dart';
import 'package:verta/features/settings/presentation/pages/settings_screen.dart';
import 'package:verta/features/task/presentation/pages/add_task_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> tabs = [
    HomeScreen(),
    AddTaskScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: tabs,
          ),

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
