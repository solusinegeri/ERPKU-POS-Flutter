import 'package:erpku_pos/core/extensions/build_context_ext.dart';
import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/core/widgets/bottom_navigation/widgets/nav_item.dart';
import 'package:erpku_pos/feature/order/presentation/item/history_order_page/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../feature/login/login_page.dart';
import '../../gen/assets/assets.gen.dart';
import '../../../feature/home/presentation/home_page.dart';
import '../../../feature/printer/presentation/printer_page.dart';
import '../../../feature/report/presentation/report_page.dart';
import '../../../feature/settings/presentation/settings_page.dart';

class NavigationRailDesktop extends StatefulWidget {
  const NavigationRailDesktop({super.key});

  @override
  State<NavigationRailDesktop> createState() => _NavigationRailDekstopState();
}

class _NavigationRailDekstopState extends State<NavigationRailDesktop> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const OrderPage(),
    const ReportPage(),
    const PrinterPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 1000 ?
    Scaffold(
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
    ) :SafeArea(
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait){
              return const Center(
                child: Text(
                  'App Khusus Screen (Tablet Version dan mode landscape) ganti resolusi anda.',
                  style: TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              );
            }else{
              return Row(
                children: [
                  SingleChildScrollView(
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(16.0)),
                      child: SizedBox(
                        height: context.deviceHeight - 20.0,
                        child: ColoredBox(
                          color: ColorValues.primary,
                          child: Column(
                            children: [
                              NavItem(
                                iconPath: Assets.icons.homeResto.path,
                                isActive: _selectedIndex == 0,
                                onTap: () => _onItemTapped(0),
                              ),
                              NavItem(
                                iconPath: Assets.icons.order.path,
                                isActive: _selectedIndex == 1,
                                onTap: () => _onItemTapped(1),
                              ),
                              NavItem(
                                iconPath: Assets.icons.discount.path,
                                isActive: _selectedIndex == 2,
                                onTap: () => _onItemTapped(2),
                              ),
                              NavItem(
                                iconPath: Assets.icons.dashboard.path,
                                isActive: _selectedIndex == 3,
                                onTap: () => _onItemTapped(3),
                              ),
                              NavItem(
                                iconPath: Assets.icons.setting.path,
                                isActive: _selectedIndex == 4,
                                onTap: () => _onItemTapped(4),
                              ),
                              NavItem(
                                iconPath: Assets.icons.logout.path,
                                isActive: false,
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _pages[_selectedIndex],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
