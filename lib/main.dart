import 'package:flutter/material.dart';
import 'package:music_play/error.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:music_play/loading.dart';
import 'manager/page_manager.dart';
import 'screens/Home/home_page.dart';
import 'screens/musicPlayer/services/favourite_music_service.dart';
import 'screens/setting/setting_page.dart';
import 'services/service_locator.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }

  if (await Permission.storage.isGranted) {
    await setupServiceLocator();
    runApp(const MyApp());
    return;
  }

  runApp(const Error());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  late Future _isLoading;

  List screens = const [HomePage(), SettingPage()];

  @override
  void initState() {
    _isLoading = getIt<PageManager>().init();
    getIt<FavouriteSongs>().init();

    super.initState();
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: FutureBuilder(
        future: _isLoading,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: screens[selectedIndex],
              bottomNavigationBar: navBar(context),
            );
          }
          return const Loading();
        },
      ),
    );
  }

  NavigationBar navBar(context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: Icon(
            Icons.home_filled,
            color: Theme.of(context).iconTheme.color,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: const Icon(
            Icons.settings,
          ),
          selectedIcon: Icon(
            Icons.settings,
            color: Theme.of(context).iconTheme.color,
          ),
          label: 'Settings',
        ),
      ],
      onDestinationSelected: (index) => setState(() => selectedIndex = index),
      selectedIndex: selectedIndex,
      animationDuration: const Duration(milliseconds: 900),
    );
  }
}
