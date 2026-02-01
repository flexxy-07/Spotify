import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode>{
  ThemeCubit() : super(ThemeMode.dark);

  void updateTheme(ThemeMode themeMode) => emit(themeMode);
  @override
  ThemeMode? fromJson(Map<String, dynamic> json){
    try {
      final themeIndex = json['theme'] as int?;
      if (themeIndex != null && themeIndex < ThemeMode.values.length) {
        return ThemeMode.values[themeIndex];
      }
    } catch (e) {
      return ThemeMode.dark;
    }
    return ThemeMode.dark;
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state){
    return {'theme': state.index};
  }
}