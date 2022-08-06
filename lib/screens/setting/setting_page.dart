import 'package:flutter/material.dart';
import 'package:mousika/services/notification.dart';
import 'package:mousika/services/service_locator.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificatioService = getIt<NotificatioService>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Setting page'),
              Container(
                color: Colors.red,
                child: ElevatedButton(
                  onPressed: () {
                    notificatioService.displayNotification();

                    print('holaA;');
                  },
                  child: Text('show'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
