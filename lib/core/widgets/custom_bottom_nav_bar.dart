import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:verta/core/utils/colors_manager.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.home_outlined,
      Icons.add_outlined,
      Icons.person_2_outlined,
      Icons.settings_outlined,
    ];

    final List<String> titles = ["Home", "Add", "Profile", "Settings"];

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorsManager.whiteFF.withOpacity(0.12),
            border: Border.all(color: Colors.black.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              icons.length,
              (index) => GestureDetector(
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: currentIndex == index
                        ? ColorsManager.indigo_500
                        : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icons[index],
                        color: currentIndex == index
                            ? ColorsManager.whiteF0
                            : ColorsManager.dark1E,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        titles[index],
                        style: TextStyle(
                          color: currentIndex == index
                              ? ColorsManager.whiteF0
                              : ColorsManager.dark1E,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
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
}
