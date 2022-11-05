import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mousika/screens/Home/home_page.dart';

import '../manager/page_manager.dart';
import '../providers/providers.dart';
import '../services/notification.dart';
import '../services/service_locator.dart';
import 'loading.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  int selectedIndex = 0;
  late Future _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = getIt<PageManager>().init();
    getIt<NotificatioService>().init();
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider().init(context);

    return MaterialApp(
      title: 'Mousika',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider),
      home: FutureBuilder(
        future: _isLoading,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Scaffold(body: HomePage());
          }
          return const Loading();
        },
      ),
    );
  }
}
