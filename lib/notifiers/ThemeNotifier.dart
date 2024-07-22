import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../themes/themes.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier(ThemeData state) : super(state);

  void setTheme(ThemeData theme) {
    state = theme;
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeData>(
      (ref) => ThemeNotifier(theme1), // default theme
);