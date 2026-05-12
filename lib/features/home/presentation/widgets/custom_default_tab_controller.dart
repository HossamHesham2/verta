import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/features/home/presentation/widgets/custom_card_task.dart';
import 'package:verta/features/home/presentation/widgets/custom_tab_bar.dart';

class CustomDefaultTabController extends StatefulWidget {
  const CustomDefaultTabController({super.key});

  @override
  State<CustomDefaultTabController> createState() =>
      _CustomDefaultTabControllerState();
}

class _CustomDefaultTabControllerState
    extends State<CustomDefaultTabController> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      Tab(
        child: CustomTabBar(text: 'All', isSelected: currentIndex == 0),
      ),
      Tab(
        child: CustomTabBar(text: 'Work', isSelected: currentIndex == 1),
      ),
      Tab(
        child: CustomTabBar(text: 'Personal', isSelected: currentIndex == 2),
      ),
      Tab(
        child: CustomTabBar(text: 'Shopping', isSelected: currentIndex == 3),
      ),
      Tab(
        child: CustomTabBar(text: 'Health', isSelected: currentIndex == 4),
      ),
    ];
    return DefaultTabController(
      length: tabs.length,
      initialIndex: currentIndex,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.only(right: 5.w),
            tabs: tabs,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
          ),

          SizedBox(
            height: 800.h,
            child: TabBarView(
              children: [
                Center(child: CustomCardTask()),
                Center(child: CustomCardTask()),
                Center(child: CustomCardTask()),
                Center(child: CustomCardTask()),
                Center(child: CustomCardTask()),
              ],
            ),
          ),
        ],
      ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
    );
  }
}
