import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mousika/error.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main/app.dart';
import 'services/service_locator.dart';

Future initializeHive() async {
  await Hive.initFlutter();
  Box box = await Hive.openBox('mousika');
  box.put('theme', 'dark');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();

  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }

  if (await Permission.storage.isGranted) {
    await setupServiceLocator();
    runApp(const ProviderScope(child: MyApp()));
    return;
  }

  runApp(const Error());
}
