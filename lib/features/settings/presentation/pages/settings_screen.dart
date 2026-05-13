import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/theme/theme_cubit.dart';
import 'package:verta/core/utils/colors_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    ThemeMode getTheme = BlocProvider.of<ThemeCubit>(context).getTheme();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Settings",
                style: Theme.of(context).textTheme.headlineMedium,
              )
                  .animate()
                  .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: -0.2,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 28),

              // APPEARANCE Section
              _buildSectionLabel(
                'APPEARANCE',
              ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

              const SizedBox(height: 8),

              _buildCard(children: [_buildThemeRow(getTheme)])
                  .animate()
                  .fadeIn(delay: 150.ms, duration: 400.ms)
                  .slideX(
                    begin: -0.05,
                    end: 0,
                    delay: 150.ms,
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 28),

              // NOTIFICATIONS Section
              _buildSectionLabel(
                'NOTIFICATIONS',
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

              const SizedBox(height: 8),

              _buildCard(children: [_buildNotificationsRow()])
                  .animate()
                  .fadeIn(delay: 250.ms, duration: 400.ms)
                  .slideX(
                    begin: -0.05,
                    end: 0,
                    delay: 250.ms,
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 28),

              // SECURITY Section
              _buildSectionLabel(
                'SECURITY',
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

              const SizedBox(height: 8),

              _buildCard(
                    children: [
                      _buildTappableRow(
                        icon: CupertinoIcons.lock,
                        label: 'Change Password',
                        onTap: () {},
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 350.ms, duration: 400.ms)
                  .slideX(
                    begin: -0.05,
                    end: 0,
                    delay: 350.ms,
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 28),

              // SUPPORT Section
              _buildSectionLabel(
                'SUPPORT',
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

              const SizedBox(height: 8),

              _buildCard(
                    children: [
                      _buildTappableRow(
                        icon: CupertinoIcons.question_circle,
                        label: 'Help Center',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildAboutRow(),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 450.ms, duration: 400.ms)
                  .slideX(
                    begin: -0.05,
                    end: 0,
                    delay: 450.ms,
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildThemeRow(ThemeMode getTheme) {
    bool isDarkTheme = getTheme == ThemeMode.dark;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: const Color(0xFF5856D6).withAlpha(12),
              borderRadius: BorderRadius.circular(8),
            ),
            child:  isDarkTheme ?Icon(
              CupertinoIcons.moon,
              color: Color(0xFF5856D6),
              size: 20.sp,
            ): Icon(
        CupertinoIcons.sun_min,
        color: Color(0xFF5856D6),
        size: 20.sp,
      ),
          ),
           SizedBox(width: 14.w),
           Expanded(
            child: Text(
              'Theme',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ),
          Text(
            isDarkTheme ? 'Dark' : 'Light',
            style:  TextStyle(fontSize: 15.sp, color: Color(0xFF8E8E93)),
          ),
           SizedBox(width: 8.w),
          CupertinoSwitch(
            value: isDarkTheme,
            activeTrackColor: ColorsManager.green_600,
            onChanged: (val) => setState(() {
              BlocProvider.of<ThemeCubit>(context).selectTheme(
                val ? ThemeModeState.dark : ThemeModeState.light,
              );
              setState(() {

              });
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsRow() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: const Color(0xFF5856D6).withAlpha(12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child:  Icon(
              CupertinoIcons.bell,
              color: Color(0xFF5856D6),
              size: 20.sp,
            ),
          ),
           SizedBox(width: 14.w),
           Expanded(
            child: Text(
              'Push Notifications',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ),
          Text(
            _pushNotificationsEnabled ? 'Enabled' : 'Disabled',
            style:  TextStyle(fontSize: 15.sp, color: Color(0xFF8E8E93)),
          ),
          SizedBox(width: 8.w),
          CupertinoSwitch(
            value: _pushNotificationsEnabled,
            activeTrackColor: ColorsManager.green_600,
            onChanged: (val) => setState(() => _pushNotificationsEnabled = val),
          ),
        ],
      ),
    );
  }

  Widget _buildTappableRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: ColorsManager.dark0F.withAlpha(12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF5856D6), size: 20.sp),
            ),
             SizedBox(width: 14.w),
            Expanded(
              child: Text(
                label,
                style:  TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.dark0F,
                ),
              ),
            ),
             Icon(
              CupertinoIcons.chevron_right,
              color: const Color(0xFF5856D6),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutRow() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color:  ColorsManager.dark0F.withAlpha(12),
              borderRadius: BorderRadius.circular(8),
            ),
            child:  Icon(
              CupertinoIcons.info_circle,
              color: Color(0xFF5856D6),
              size: 20.sp,
            ),
          ),
          const SizedBox(width: 14),
           Expanded(
            child: Text(
              'About TaskFlow',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ),
           Text(
            'Version 1.0.0',
            style: TextStyle(fontSize: 14.sp, color: ColorsManager.dark0F),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 66),
      child: Divider(height: 1, color: Color(0xFFF2F2F7)),
    );
  }
}
