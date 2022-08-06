import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mousika/config/config.dart';

final box = Hive.box('mousika');
final themeProvider = StateProvider<ThemeData>((ref) =>
    box.get('theme') == 'light' ? ThemeProvider.light! : ThemeProvider.dark!);

class ThemeProvider {
  static ThemeData? light;
  static ThemeData? dark;
  void init(BuildContext context) {
    light = lightThemeData(context);
    dark = darkThemeData(context);
  }
}
