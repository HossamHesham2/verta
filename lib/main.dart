import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verta/config/route/route_name.dart';
import 'package:verta/core/theme/theme_cubit.dart';
import 'package:verta/core/theme/theming.dart';
import 'package:verta/features/auth/presentation/manager/auth_bloc.dart';
import 'package:verta/firebase_options.dart';

import 'config/route/route_generator.dart';
import 'core/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
          BlocProvider<ThemeCubit>(create: (_) => getIt<ThemeCubit>()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.goRoute,
              initialRoute: RouteName.splashScreen,
              theme: Theming.lightTheme,
              darkTheme: Theming.darkTheme,
              themeMode: ThemeCubit.get(context).getTheme(),
            );
          },
        ),
      ),
    );
  }
}
