import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'feature/login/login_page.dart';

void main() async {
  runApp(const MyApp());
  // set horizontal mode for tablet
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  print('App Name: ${packageInfo.appName}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorValues.primary),
        useMaterial3: true,
      ),
      home: screenWidth < 1000
          ? Scaffold(
              body: OrientationBuilder(
                builder: (context, orientation) {
                  if (orientation == Orientation.portrait) {
                    // Force landscape mode
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ]);
                  }
                  return const Center(
                    child: Text(
                      'App Khusus Screen (Tablet Version dan mode landscape) ganti resolusi anda.',
                      style: TextStyle(fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            )
          : const LoginPage(),
    );
  }
}
