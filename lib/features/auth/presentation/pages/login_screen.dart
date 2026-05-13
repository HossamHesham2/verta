import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/core/helpers/shared_pref_helper.dart';
import 'package:verta/core/utils/assets_manager.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/core/utils/const_variables.dart';
import 'package:verta/core/utils/validations.dart';
import 'package:verta/core/widgets/custom_button.dart';
import 'package:verta/core/widgets/custom_field_bar.dart';
import 'package:verta/core/widgets/custom_glass_dialog.dart';
import 'package:verta/features/auth/presentation/manager/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  bool rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          CustomGlassDialog.showVariant(
            context: context,
            variant: DialogVariant.success,
            title: "Welcome Back!",
            description: "You have signed in successfully.",
            buttonText: "Continue",
            onTap: () {
              emailController.clear();
              passwordController.clear();
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.mainLayout,
                (route) => false,
              );
            },
          );
        }

        if (state is AuthError) {
          CustomGlassDialog.showVariant(
            context: context,
            variant: DialogVariant.error,
            title: "Login Failed",
            description: state.message,
            buttonText: "Try Again",
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: ColorsManager.whiteFF,
                              borderRadius: BorderRadius.circular(24.r),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorsManager.dark0F.withValues(
                                    alpha: 0.1,
                                  ),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              IconsManager.mainIcon,
                              width: 60.w,
                            ),
                          )
                          .animate()
                          .scale(duration: 700.ms, curve: Curves.easeOutBack)
                          .fadeIn(),
                      SizedBox(height: 20.h),
                      Text(
                        "Welcome Back",
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.4),
                      SizedBox(height: 10.h),
                      Text(
                        "Sign in to continue to TaskFlow",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ).animate().fadeIn(delay: 500.ms),
                      SizedBox(height: 20.h),
                      Form(
                        key: _formKey,
                        autovalidateMode: _autoValidateMode,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: ColorsManager.whiteFF,
                                borderRadius: BorderRadius.circular(24.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorsManager.dark0F.withValues(
                                      alpha: 0.25,
                                    ),
                                    blurRadius: 24,
                                    offset: const Offset(5, 20),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomFieldBar(
                                        hintText: "Enter Your email",
                                        title: "Email",
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                        ),
                                        obscureText: false,
                                        controller: emailController,
                                        validator: (email) {
                                          return Validations.email(email);
                                        },
                                      )
                                      .animate()
                                      .fadeIn(delay: 200.ms)
                                      .slideX(begin: -0.2),

                                  SizedBox(height: 15.h),
                                  CustomFieldBar(
                                        hintText: "Enter Your password",
                                        title: "Password",
                                        obscureText: obscureText,
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                        ),
                                        controller: passwordController,
                                        validator: (password) {
                                          return Validations.password(password);
                                        },
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            obscureText = !obscureText;
                                            setState(() {});
                                          },

                                          icon: obscureText
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off,
                                                ),
                                        ),
                                      )
                                      .animate()
                                      .fadeIn(delay: 400.ms)
                                      .slideX(begin: 0.2),

                                  SizedBox(height: 15.h),
                                  Row(
                                        children: [
                                          RoundCheckBox(
                                            isChecked: rememberMe,
                                            checkedColor:
                                                ColorsManager.indigo_500,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.5.w,
                                            ),
                                            size: 22.sp,
                                            animationDuration: const Duration(
                                              milliseconds: 400,
                                            ),
                                            checkedWidget: Icon(
                                              Icons.check,
                                              color: ColorsManager.whiteFF,
                                              size: 16.sp,
                                            ),
                                            onTap: (bool? selected) async {
                                              rememberMe = selected ?? false;

                                              await SharedPrefHelper.setData(
                                                ConstVariables.rememberMe,
                                                rememberMe,
                                              );

                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            "Remember me",
                                            softWrap: true,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                          ),
                                        ],
                                      )
                                      .animate()
                                      .fadeIn(delay: 600.ms)
                                      .slideX(begin: -0.2),
                                  SizedBox(height: 5.h),
                                  Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Forget Password ?",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: ColorsManager
                                                        .indigo_500,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      )
                                      .animate()
                                      .fadeIn(delay: 800.ms)
                                      .slideX(begin: 0.2),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            if (state is AuthLoading)
                              CircularProgressIndicator()
                            else
                              CustomButton(
                                    text: "Sign In",
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthBloc>(context).add(
                                          LoginEvent(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          _autoValidateMode = AutovalidateMode
                                              .onUserInteraction;
                                        });
                                      }
                                    },
                                  )
                                  .animate()
                                  .animate()
                                  .fadeIn(delay: 1000.ms)
                                  .scale(
                                    begin: const Offset(0.8, 0.8),
                                    duration: 500.ms,
                                    curve: Curves.easeOutBack,
                                  ),
                          ],
                        ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.4),
                      ),

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
                      ).animate().fadeIn(delay: 1000.ms),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
