import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    useMaterial3: true,
    primaryColor: Palette.primaryColor,
    scaffoldBackgroundColor: Palette.white1,
    appBarTheme: appBarTheme(Palette.white1),
    iconTheme: const IconThemeData(color: Palette.black2),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: Palette.black2),
    colorScheme: const ColorScheme.light(
      primary: Palette.primaryColor,
      primaryContainer: Palette.primaryLightColor,
      secondary: Palette.secondaryColor,
    ),
    sliderTheme: sliderThemeData(
      Palette.primaryColor,
      Palette.primaryLightColor,
      Palette.white2,
      Palette.primaryColor.withOpacity(0.2),
    ),
    cardColor: Palette.white2,
    floatingActionButtonTheme: floatingActionButtonThemeData(
        Palette.primaryColor, Palette.primaryLightColor),
    navigationBarTheme: navigationBarThemeData(Palette.white1),
    tabBarTheme: tabBarTheme(
      Palette.black2,
      Palette.black2.withOpacity(0.7),
      Palette.white2,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    useMaterial3: true,
    appBarTheme: appBarTheme(Palette.black1),
    primaryColor: Palette.primaryColor,
    scaffoldBackgroundColor: Palette.black1,
    iconTheme: const IconThemeData(color: Palette.black3),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: Palette.white1),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Palette.primaryColor,
      secondary: Palette.secondaryColor,
      primaryContainer: Palette.primaryLightColor,
    ),
    sliderTheme: sliderThemeData(
      Palette.black3,
      Palette.black3,
      Palette.black2,
      Palette.black2.withOpacity(0.2),
    ),
    cardColor: Palette.black2,
    floatingActionButtonTheme:
        floatingActionButtonThemeData(Palette.black2, Palette.secondaryColor),
    navigationBarTheme: navigationBarThemeData(Palette.black1),
    tabBarTheme: tabBarTheme(
      Palette.white1,
      Palette.white1.withOpacity(0.7),
      Palette.black2,
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
      borderRadius: BorderRadius.circular(Sizes.defaultBorderRaduis),
    ),
  );
}

NavigationBarThemeData navigationBarThemeData(bgColor) {
  return NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.all(
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    ),
    indicatorColor: Palette.primaryLightColor,
    iconTheme: MaterialStateProperty.all(
      const IconThemeData(size: 30),
    ),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    backgroundColor: bgColor,
  );
}
