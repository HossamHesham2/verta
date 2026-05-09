import 'package:flutter/cupertino.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/splash_screen.dart';

class RouteGenerator {
  static Route? goRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.splashScreen:
        return CupertinoPageRoute(builder: (context) => SplashScreen(),);
        break;
    }
    return null;
  }
}