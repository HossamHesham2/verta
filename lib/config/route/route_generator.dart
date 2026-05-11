import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/features/auth/presentation/pages/login_screen.dart';
import 'package:verta/features/auth/presentation/pages/register_screen.dart';
import 'package:verta/features/home/presentation/pages/home_screen.dart';
import 'package:verta/features/profile/presentation/pages/profile_screen.dart';
import 'package:verta/features/settings/presentation/pages/settings_screen.dart';
import 'package:verta/features/task/presentation/pages/add_task_screen.dart';
import 'package:verta/main_layout.dart';
import 'package:verta/splash_screen.dart';

class RouteGenerator {
  static Route? goRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return CupertinoPageRoute(builder: (context) => SplashScreen());
      case RouteName.mainLayout:
        return CupertinoPageRoute(builder: (context) => MainLayout());
      case RouteName.loginScreen:
        return CupertinoPageRoute(builder: (context) => LoginScreen());
      case RouteName.registerScreen:
        return CupertinoPageRoute(builder: (context) => RegisterScreen());
      case RouteName.homeScreen:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
      case RouteName.addTaskScreen:
        return CupertinoPageRoute(builder: (context) => AddTaskScreen());
      case RouteName.profileScreen:
        return CupertinoPageRoute(builder: (context) => ProfileScreen());
      case RouteName.settingScreen:
        return CupertinoPageRoute(builder: (context) => SettingsScreen());
      default:
        return CupertinoPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
