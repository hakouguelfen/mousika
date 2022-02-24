import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: kContentColorLightTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorLightTheme),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: orange1,
      error: kErrorColor,
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 12,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 15,
      ),
      thumbColor: orange1,
      activeTrackColor: orange1,
      inactiveTrackColor: cardColorLightTheme,
      overlayColor: orange1.withOpacity(0.2),
    ),
    cardColor: cardColorLightTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: blue1,
      foregroundColor: blue2,
      elevation: 0,
      extendedSizeConstraints: BoxConstraints.tightFor(
        width: 200,
        height: 90,
      ),
      largeSizeConstraints: BoxConstraints.tightFor(
        width: 90,
        height: 90,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      indicatorColor: blue1,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: kContentColorDarkTheme, size: 30),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: orange1,
      error: kErrorColor,
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 12,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 15,
      ),
      thumbColor: orange1,
      activeTrackColor: orange1,
      inactiveTrackColor: cardColorDarkTheme,
      overlayColor: orange1.withOpacity(0.2),
    ),
    cardColor: cardColorDarkTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: blue1,
      foregroundColor: blue2,
      elevation: 0,
      extendedSizeConstraints: BoxConstraints.tightFor(
        width: 200,
        height: 90,
      ),
      largeSizeConstraints: BoxConstraints.tightFor(
        width: 90,
        height: 90,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      indicatorColor: blue2,
      backgroundColor: kContentColorLightTheme,
    ),
  );
}

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
