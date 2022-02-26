import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: orange1,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: darkThemeBackgroundColor),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: darkThemeBackgroundColor),
    colorScheme: const ColorScheme.light(
      primary: blue1,
      secondary: blue2,
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
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      indicatorColor: blue1,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: darkThemeBackgroundColor,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: blue1),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: cardColorDarkTheme,
      secondary: blue1,
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
      backgroundColor: cardColorDarkTheme,
      foregroundColor: blue1,
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
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      // iconTheme: MaterialStateProperty.all(
      //   const IconThemeData(
      //     color: orange1,
      //   ),
      // ),
      indicatorColor: blue3,
      backgroundColor: black1,
    ),
  );
}

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
