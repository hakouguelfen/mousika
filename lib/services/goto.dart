import 'package:flutter/material.dart';

void goto(BuildContext context, Widget screen) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, _) => screen,
    ),
  );
}
