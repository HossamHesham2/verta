import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/features/home/presentation/widgets/custom_default_tab_controller.dart';

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                            Text(
                              'You Have 3 tasks today',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),

                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: ColorsManager.whiteFF,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: ColorsManager.dark0F.withValues(
                                alpha: 0.2,
                              ),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.notifications_none),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.2),
                    ],
                  ),

                  SizedBox(height: 25.h),

                  Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.whiteFF,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorsManager.dark0F.withValues(alpha: 0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search your tasks...',
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.h,
                          horizontal: 20.w,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                  SizedBox(height: 25.h),

                  CustomDefaultTabController(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
