import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/core/utils/assets_manager.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/core/widgets/custom_button.dart';
import 'package:verta/core/widgets/custom_field_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorsManager.whiteFF,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorsManager.dark0F.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(IconsManager.mainIcon, width: 60.w),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Sign in to continue to TaskFlow",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: ColorsManager.whiteFF,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorsManager.dark0F.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFieldBar(
                          hintText: "Enter Your email",
                          title: "Email",
                          prefixIcon: Icon(Icons.person_2_outlined),
                          obscureText: false,
                        ),

                        SizedBox(height: 15.h),
                        CustomFieldBar(
                          hintText: "Enter Your password",
                          title: "Password",
                          obscureText: obscureText,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              obscureText = !obscureText;
                              setState(() {});
                            },
                            icon: obscureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),

                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Row(
                              spacing: 5.w,
                              children: [
                                RoundCheckBox(
                                  onTap: (bool? selected) {},
                                  checkedColor: ColorsManager.indigo_500,
                                  border: Border.all(width: 1.5.w),
                                  size: 20.sp,
                                  animationDuration: Duration(
                                    milliseconds: 500,
                                  ),

                                  checkedWidget: Icon(
                                    Icons.check,
                                    color: ColorsManager.whiteFF,
                                    size: 15.sp,
                                  ),
                                ),
                                Text(
                                  "Remember me",
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forget Password ?",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: ColorsManager.indigo_500,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(text: "Sign In", onPressed: () {}),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteName.registerScreen,
                            (route) => false,
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: ColorsManager.indigo_500,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
