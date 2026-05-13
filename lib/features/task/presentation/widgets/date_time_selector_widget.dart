import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/core/utils/colors_manager.dart';

class DateTimeSelectorWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final String text;

  const DateTimeSelectorWidget({super.key, this.onTap, required this.text});

  @override
  State<DateTimeSelectorWidget> createState() => _DateTimeSelectorWidgetState();
}

class _DateTimeSelectorWidgetState extends State<DateTimeSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.dark0F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          widget.text,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: ColorsManager.dark0F),
        ),
      ),
    );
  }
}
