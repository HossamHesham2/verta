import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/features/auth/presentation/pages/login_screen.dart';
import 'package:verta/features/auth/presentation/pages/register_screen.dart';
import 'package:verta/features/home/presentation/pages/home_screen.dart';
import 'package:verta/splash_screen.dart';

class RouteGenerator {
  static Route? goRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return CupertinoPageRoute(builder: (context) => SplashScreen());
      case RouteName.loginScreen:
        return CupertinoPageRoute(builder: (context) => LoginScreen());
      case RouteName.registerScreen:
        return CupertinoPageRoute(builder: (context) => RegisterScreen());
      case RouteName.homeScreen:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          ),
        );
    }
  }
}
