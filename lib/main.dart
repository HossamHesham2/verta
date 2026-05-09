import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 732),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) =>
          CupertinoApp(debugShowCheckedModeBanner: false,),
    );
  }
}
