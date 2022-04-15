import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: blue2,
    scaffoldBackgroundColor: lightThemeBackgoundColor,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: darkThemeBackgroundColor),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: darkThemeBackgroundColor),
    colorScheme: const ColorScheme.light(
      primary: cardColorLightTheme,
      secondary: blue2,
    ),
    sliderTheme: SliderThemeData(
      trackShape: CustomTrackShape(),
      trackHeight: 12,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 15,
      ),
      thumbColor: blue2,
      activeTrackColor: blue1,
      inactiveTrackColor: cardColorLightTheme,
      overlayColor: blue1.withOpacity(0.2),
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
      iconTheme: MaterialStateProperty.all(
        const IconThemeData(size: 30),
      ),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: white1,
    ),
  );
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    appBarTheme: appBarTheme,
    primaryColor: blue1,
    scaffoldBackgroundColor: darkThemeBackgroundColor,
    iconTheme: const IconThemeData(color: black3),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: lightThemeBackgoundColor),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: cardColorDarkTheme,
      secondary: blue1,
      secondaryContainer: black3,
      primaryContainer: blue2,
    ),
    sliderTheme: SliderThemeData(
      trackShape: CustomTrackShape(),
      trackHeight: 12,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 15,
      ),
      thumbColor: black3,
      activeTrackColor: black3,
      inactiveTrackColor: cardColorDarkTheme,
      overlayColor: cardColorDarkTheme.withOpacity(0.2),
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
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      iconTheme: MaterialStateProperty.all(
        const IconThemeData(size: 30),
      ),
      indicatorColor: blue1,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: darkThemeBackgroundColor,
    ),
  );
}

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
