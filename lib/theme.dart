import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    useMaterial3: true,
    primaryColor: blue2,
    scaffoldBackgroundColor: lightThemeBackgoundColor,
    appBarTheme: appBarTheme(lightThemeBackgoundColor),
    iconTheme: const IconThemeData(color: darkThemeBackgroundColor),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: darkThemeBackgroundColor),
    colorScheme: const ColorScheme.light(
      primary: cardColorLightTheme,
      primaryContainer: blue2,
      secondary: blue2,
    ),
    sliderTheme: sliderThemeData(
      blue2,
      blue1,
      cardColorLightTheme,
      blue1.withOpacity(0.2),
    ),
    cardColor: cardColorLightTheme,
    floatingActionButtonTheme: floatingActionButtonThemeData(blue1, blue2),
    navigationBarTheme: navigationBarThemeData(white1),
    tabBarTheme: tabBarTheme(
      darkThemeBackgroundColor,
      darkThemeBackgroundColor.withOpacity(0.7),
      cardColorLightTheme,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    useMaterial3: true,
    appBarTheme: appBarTheme(darkThemeBackgroundColor),
    primaryColor: blue1,
    scaffoldBackgroundColor: darkThemeBackgroundColor,
    iconTheme: const IconThemeData(color: black3),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: lightThemeBackgoundColor),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: cardColorDarkTheme,
      secondary: blue1,
      primaryContainer: blue2,
    ),
    sliderTheme: sliderThemeData(
      black3,
      black3,
      cardColorDarkTheme,
      cardColorDarkTheme.withOpacity(0.2),
    ),
    cardColor: cardColorDarkTheme,
    floatingActionButtonTheme:
        floatingActionButtonThemeData(cardColorDarkTheme, blue1),
    navigationBarTheme: navigationBarThemeData(darkThemeBackgroundColor),
    tabBarTheme: tabBarTheme(
      lightThemeBackgoundColor,
      lightThemeBackgoundColor.withOpacity(0.7),
      cardColorDarkTheme,
    ),
  );
}

FloatingActionButtonThemeData floatingActionButtonThemeData(bgColor, fgColor) {
  return FloatingActionButtonThemeData(
    backgroundColor: bgColor,
    foregroundColor: fgColor,
    elevation: 0,
    extendedSizeConstraints: const BoxConstraints.tightFor(
      width: 150,
      height: 90,
    ),
  );
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
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

AppBarTheme appBarTheme(bgColor) {
  return AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: bgColor,
  );
}

SliderThemeData sliderThemeData(
    thumbColor, activeColor, inactiveColor, overlayColor) {
  return SliderThemeData(
    trackShape: CustomTrackShape(),
    trackHeight: 12,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: 15,
    ),
    thumbColor: thumbColor,
    activeTrackColor: activeColor,
    inactiveTrackColor: inactiveColor,
    overlayColor: overlayColor,
  );
}

TabBarTheme tabBarTheme(labelColor, unselectedColor, indicatorColor) {
  return TabBarTheme(
    labelColor: labelColor,
    unselectedLabelColor: unselectedColor,
    indicator: BoxDecoration(
      color: indicatorColor,
      borderRadius: BorderRadius.circular(defaultBorderRaduis),
    ),
  );
}

NavigationBarThemeData navigationBarThemeData(bgColor) {
  return NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.all(
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    ),
    indicatorColor: blue1,
    iconTheme: MaterialStateProperty.all(
      const IconThemeData(size: 30),
    ),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    backgroundColor: bgColor,
    height: 100,
  );
}
