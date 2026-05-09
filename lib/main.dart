import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/core/theme/theming.dart';

import 'config/route/route_generator.dart';

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
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.goRoute,
        initialRoute: RouteName.splashScreen,
        theme: Theming.lightTheme,
        darkTheme: Theming.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
