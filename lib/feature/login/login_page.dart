import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/gen/assets/assets.gen.dart';
import '../../core/widgets/bottom_navigation/navigation_rail.dart';
import '../../core/widgets/components/buttons.dart';
import '../../core/widgets/components/custom_text_field.dart';
import '../../core/widgets/components/spaces.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? appName;

  @override
  void initState() {
    super.initState();
    initPackageInfo();
  }

  Future<void> initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      appName = info.appName;
    });
  }
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 124.0, vertical: 20.0),
        children: [
          const SpaceHeight(80.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130.0),
              child: SvgPicture.asset(
                Assets.icons.homeResto.path,
                width: 100,
                height: 100,
                colorFilter: const ColorFilter.mode(
                  ColorValues.primary,
                  BlendMode.srcIn,
                ),
              )),
          const SpaceHeight(24.0),
          const Center(
            child: Text(
              'ERPKU POS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SpaceHeight(8.0),
          Center(
            child: Text(
              //nama pacakge aplikasi
              '${appName}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: usernameController,
            label: 'Username',
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SpaceHeight(24.0),
          Button.filled(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationRailDesktop(),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Berhasil'),
                ),
              );
            },
            label: 'Masuk',
          ),
        ],
      ),
    );
  }
}
