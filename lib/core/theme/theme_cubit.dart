import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:verta/core/helpers/shared_pref_helper.dart';
import 'package:verta/core/utils/const_variables.dart';

part 'theme_state.dart';

enum ThemeModeState { light, dark, system }

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    _loadTheme();
  }
  ThemeModeState currentTheme = ThemeModeState.system;

  static ThemeCubit get(context) => BlocProvider.of(context);

  // 1. Select theme (light,dark,system)
  Future<void> selectTheme(ThemeModeState themeState) async {
    currentTheme = themeState;
    await SharedPrefHelper.setData(ConstVariables.themeMode, currentTheme.name);
    emit(ThemeChangedState());
  }

  // 2. get theme ThemeMode
  ThemeMode getTheme() {
    switch (currentTheme) {
      case ThemeModeState.light:
        return ThemeMode.light;
      case ThemeModeState.dark:
        return ThemeMode.dark;
      case ThemeModeState.system:
        return ThemeMode.system;
    }
  }

  // 3. Load theme
  Future<void> _loadTheme() async {
    String? loadedTheme = await SharedPrefHelper.getString(
      ConstVariables.themeMode,
    );
    currentTheme = ThemeModeState.values.firstWhere(
      (element) => element.name == loadedTheme,
      orElse: () => ThemeModeState.system,
    );
      emit(ThemeChangedState());
  }
}
