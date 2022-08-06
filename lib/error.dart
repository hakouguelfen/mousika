import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:mousika/constants.dart';

import 'package:mousika/theme.dart';

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/storage.png",
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: defaultPadding * 2,
              left: defaultPadding * 2,
              right: defaultPadding * 2,
              child: SizedBox(
                width: 350,
                child: FloatingActionButton.extended(
                  onPressed: () => AppSettings.openAppSettings(),
                  label: const Text('enable', style: TextStyle(fontSize: 18)),
                  backgroundColor: const Color(0xFF59618B).withOpacity(0.4),
                  foregroundColor: const Color(0xFF59618B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
