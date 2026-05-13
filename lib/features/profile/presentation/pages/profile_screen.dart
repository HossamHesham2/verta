import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/core/helpers/shared_pref_helper.dart';
import 'package:verta/core/utils/assets_manager.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/core/utils/const_variables.dart';
import 'package:verta/core/widgets/custom_glass_dialog.dart';
import 'package:verta/features/home/presentation/manager/home_bloc.dart';
import 'package:verta/features/profile/presentation/widgets/custom_card_profile_details.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String formatDate(DateTime? date) {
    if (date == null) return "";
    return DateFormat('dd MMM yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final tasks = context.read<HomeBloc>().hiveDataStore.getTasks();
        int completed = 0;
        int inProgress = 0;
        for (var task in tasks) {
          if (task.isCompleted) {
            completed++;
          }
          if (!task.isCompleted) {
            inProgress++;
          }
        }
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                          "Profile",
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: -0.2, end: 0),
                    SizedBox(height: 24.h),
                    _buildCard(
                      child: Column(
                        children: [
                          Image.asset(ImagesManager.profileImage)
                              .animate()
                              .fadeIn(duration: 600.ms)
                              .slideY(begin: 0.2, end: 0),
                          SizedBox(height: 16.h),
                          Text(
                                user?.displayName ?? "",
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: ColorsManager.dark0F,
                                      fontWeight: FontWeight.w900,
                                    ),
                              )
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .slideY(begin: -0.2, end: 0),
                          SizedBox(height: 12.h),
                          Row(
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    color: ColorsManager.grey_500,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      user?.email ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: ColorsManager.dark0F,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              )
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .slideY(begin: -0.2, end: 0),
                          SizedBox(height: 10.h),
                          Row(
                                children: [
                                  Icon(
                                    Icons.date_range_outlined,
                                    color: ColorsManager.grey_500,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    formatDate(user?.metadata.creationTime),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: ColorsManager.dark0F,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              )
                              .animate()
                              .fadeIn(duration: 1000.ms)
                              .slideY(begin: -0.2, end: 0),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                          "Statistics",
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.2, end: 0),
                    CustomCardProfileDetails(
                      mainText: "Total Tasks",
                      subText: "${tasks.length}",
                      colors: [ColorsManager.blue_500, ColorsManager.blue_600],
                      iconColor: ColorsManager.whiteFF,
                      icon: Icons.check_circle_outline,
                    ),
                    CustomCardProfileDetails(
                      mainText: "Completed",
                      subText: "$completed",
                      colors: [
                        ColorsManager.green_500,
                        ColorsManager.green_600,
                      ],
                      iconColor: ColorsManager.whiteFF,
                      icon: Icons.star_border_sharp,
                    ),
                    CustomCardProfileDetails(
                      mainText: "In progress",
                      subText: "$inProgress",
                      colors: [
                        ColorsManager.yellow_500,
                        ColorsManager.yellow_600,
                      ],
                      iconColor: ColorsManager.whiteFF,
                      icon: Icons.date_range_outlined,
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          await SharedPrefHelper.setData(ConstVariables.rememberMe, false);
                          CustomGlassDialog.showVariant(
                            context: context,
                            variant: DialogVariant.success,
                            title: "SignOut",
                            description: "SignOut Successfully",
                            onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteName.loginScreen,
                              (route) => false,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.red_500.withAlpha(60),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: ColorsManager.red_500,
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(
                            color: ColorsManager.red_500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),

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
}
