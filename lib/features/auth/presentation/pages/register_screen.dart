import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/core/helpers/shared_pref_helper.dart';
import 'package:verta/core/utils/colors_manager.dart';
import 'package:verta/core/utils/const_variables.dart';
import 'package:verta/core/utils/validations.dart';
import 'package:verta/core/widgets/custom_button.dart';
import 'package:verta/core/widgets/custom_field_bar.dart';
import 'package:verta/core/widgets/custom_glass_dialog.dart';
import 'package:verta/features/auth/presentation/manager/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          CustomGlassDialog.showVariant(
            context: context,
            variant: DialogVariant.success,
            title: "Welcome Back!",
            description: "You have signed up successfully.",
            buttonText: "Continue",
            onTap: () {
              emailController.clear();
              passwordController.clear();
              passwordConfirmController.clear();
              usernameController.clear();
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.loginScreen,
                (route) => false,
              );
            },
          );
        }

        if (state is AuthError) {
          CustomGlassDialog.showVariant(
            context: context,
            variant: DialogVariant.error,
            title: "Register Failed",
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
                      SizedBox(height: 20.h),

                      /// TITLE
                      Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.5),

                      SizedBox(height: 12.h),

                      Text(
                        "Sign up to continue to TaskFlow",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ).animate().fadeIn(delay: 300.ms),
                      SizedBox(height: 20.h),
                      Form(
                        key: _formKey,
                        autovalidateMode:_autoValidateMode,
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
                                        hintText: "Your username",
                                        title: "Username",
                                        prefixIcon: Icon(Icons.text_fields),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validations.username(value);
                                        },
                                        controller: usernameController,
                                      )
                                      .animate()
                                      .fadeIn(delay: 200.ms)
                                      .slideX(begin: -0.2),

                                  SizedBox(height: 15.h),
                                  CustomFieldBar(
                                        hintText: "Your email",
                                        title: "Email",
                                        prefixIcon: Icon(
                                          Icons.person_2_outlined,
                                        ),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validations.email(value);
                                        },
                                        controller: emailController,
                                      )
                                      .animate()
                                      .fadeIn(delay: 400.ms)
                                      .slideX(begin: 0.2),

                                  SizedBox(height: 15.h),
                                  CustomFieldBar(
                                        hintText: "Your password",
                                        title: "Password",
                                        obscureText: obscureText1,
                                        prefixIcon: Icon(Icons.lock),
                                        validator: (value) {
                                          return Validations.password(value);
                                        },
                                        controller: passwordController,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            obscureText1 = !obscureText1;
                                            setState(() {});
                                          },

                                          icon: obscureText1
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                        ),
                                      )
                                      .animate()
                                      .fadeIn(delay: 600.ms)
                                      .slideX(begin: -0.2),
                                  SizedBox(height: 15.h),
                                  CustomFieldBar(
                                        hintText: "Confirm password",
                                        title: "Confirm password",
                                        obscureText: obscureText2,
                                        prefixIcon: Icon(Icons.lock),
                                        validator: (value) {
                                          return Validations.confirmPassword(
                                            value,
                                            passwordController.text,
                                          );
                                        },
                                        controller: passwordConfirmController,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            obscureText2 = !obscureText2;
                                            setState(() {});
                                          },
                                          icon: obscureText2
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                        ),
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
                                    text: "Sign Up",
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await SharedPrefHelper.setData(
                                          ConstVariables.userName,
                                          usernameController.text.trim(),
                                        );
                                        BlocProvider.of<AuthBloc>(context).add(
                                          RegisterEvent(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                            username: usernameController.text
                                                .trim(),
                                          ),
                                        );
                                      }else {
                                        setState(() {
                                          _autoValidateMode = AutovalidateMode.always;
                                        });
                                      }
                                    },
                                  )
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
                            "You have an account?",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteName.loginScreen,
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Sign in",
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
