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
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isDark
                ? Colors.white.withAlpha(5)
                : Colors.white.withAlpha(12),
            border: Border.all(color: colorScheme.outline.withAlpha(1)),
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
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: currentIndex == index
                        ? LinearGradient(
                            colors: [
                              ColorsManager.indigo_500,
                              ColorsManager.cyan_500,
                            ],
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icons[index],
                        color: currentIndex == index
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface,
                        size: 28,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        titles[index],
                        style: TextStyle(
                          color: currentIndex == index
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
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
