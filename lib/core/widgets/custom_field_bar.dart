import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/colors_manager.dart';

class CustomFieldBar extends StatelessWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controller ;
  final String? Function(String?)? validator ;

  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomFieldBar({
    super.key,
    required this.title,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme
            .of(context)
            .textTheme
            .titleMedium),
        SizedBox(height: 10.h,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.dark0F.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            validator:validator ,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              hintText: hintText,

            ),
          ),
        ),
      ],
    );
  }
}
