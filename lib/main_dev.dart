import 'dart:io';

import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/core/widgets/bottom_navigation/navigation_rail.dart';
import 'package:erpku_pos/feature/home/presentation/home_page.dart';
import 'package:erpku_pos/feature/order/presentation/order_page.dart';
import 'package:erpku_pos/feature/payment/presentation/confirm_payment_page.dart';
import 'package:erpku_pos/feature/product/presentation/product_page.dart';
import 'package:erpku_pos/feature/report/presentation/report_page.dart';
import 'package:erpku_pos/feature/settings/presentation/settings_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'feature/login/login_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // Initialize sqflite_common_ffi for web
    databaseFactory = databaseFactoryFfiWeb;
  }

  // Set horizontal mode for tablet
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  print('App Name: ${packageInfo.appName}');

  runApp(const MyApp());
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
      initialRoute: '/login',
      routes: {
        '/login': (context) =>  screenWidth < 1000
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
        '/main': (context) => const NavigationRailDesktop(),
      },
    );
  }
}
