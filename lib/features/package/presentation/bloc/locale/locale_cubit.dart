import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ru'));

  void toggleLocale() {
    if (state.languageCode == 'ru') {
      emit(const Locale('en'));
    } else {
      emit(const Locale('ru'));
    }
  }
}
