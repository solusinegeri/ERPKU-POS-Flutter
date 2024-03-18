import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/feature/printer/presentation/printer_page.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/widgets/components/spaces.dart';
import '../widgets/manage_discount.dart';
import '../widgets/manage_tax.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  int currentIndex = 0;

  void indexValue(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // LEFT CONTENT
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(16.0),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.kelolaDiskon.svg(),
                    title: const Text('Kelola Diskon'),
                    subtitle: const Text('Kelola Diskon Pelanggan'),
                    textColor: ColorValues.primary,
                    tileColor: currentIndex == 0
                        ? ColorValues.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(0),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.kelolaPrinter.svg(),
                    title: const Text('Kelola Printer'),
                    subtitle: const Text('Tambah atau hapus printer'),
                    textColor: ColorValues.primary,
                    tileColor: currentIndex == 1
                        ? ColorValues.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(1),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.kelolaPajak.svg(),
                    title: const Text('Perhitungan Biaya'),
                    subtitle: const Text('Kelola biaya diluar biaya modal'),
                    textColor: ColorValues.primary,
                    tileColor: currentIndex == 2
                        ? ColorValues.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(2),
                  ),
                ],
              ),
            ),
          ),

          // RIGHT CONTENT
          Expanded(
            flex: 4,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IndexedStack(
                  index: currentIndex,
                  children: const [
                    ManageDiscount(),
                    PrinterPage(),
                    ManageTax(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
