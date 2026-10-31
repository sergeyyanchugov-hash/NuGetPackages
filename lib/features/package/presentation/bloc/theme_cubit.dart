import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
    } else {
      // If it's system, just pick dark or light based on a default. 
      // A more robust app would check PlatformDispatcher.instance.platformBrightness
      emit(ThemeMode.dark);
    }
  }
}
