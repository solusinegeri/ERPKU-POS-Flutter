import 'package:flutter/material.dart';

import '../../home/widgets/custom_tab_bar.dart';
import '../data/entities/printer_model.dart';
import 'add_data.dart';
import 'form_printer_dialog.dart';
import 'manage_printer_card.dart';
import 'settings_title.dart';

class ManagePrinter extends StatefulWidget {
  const ManagePrinter({super.key});

  @override
  State<ManagePrinter> createState() => _ManagePrinterState();
}

class _ManagePrinterState extends State<ManagePrinter> {
  final List<PrinterModel> items = [
    PrinterModel(
      name: 'Printer A',
      ipAddress: 'localhost',
      size: '58mm',
      type: PrinterType.bluetooth,
    ),
  ];

  void onEditTap(PrinterModel item) {
    showDialog(
      context: context,
      builder: (context) => FormPrinterDialog(data: item),
    );
  }

  void onAddDataTap() {
    showDialog(
      context: context,
      builder: (context) => const FormPrinterDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SettingsTitle('Kelola Printer'),
          const SizedBox(height: 24),
          CustomTabBar(
            tabTitles: const [
              'Bluetooth',
              'Wifi / LAN',
            ],
            initialTabIndex: 0,
            tabViews: [
              // WIFI / LAN TAB
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: items
                          .where((element) => element.type.isWifi)
                          .toList()
                          .length +
                      1,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.85,
                    crossAxisCount: 3,
                    crossAxisSpacing: 30.0,
                    mainAxisSpacing: 30.0,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return AddData(
                        title: 'Tambah Printer',
                        onPressed: onAddDataTap,
                      );
                    }
                    final item = items
                        .where((element) => element.type.isWifi)
                        .toList()[index - 1];
                    return ManagePrinterCard(
                      data: item,
                      onEditTap: () => onEditTap(item),
                    );
                  },
                ),
              ),

              // BLUETOOTH TAB
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: items
                          .where((element) => element.type.isBluetooth)
                          .toList()
                          .length +
                      1,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.85,
                    crossAxisCount: 3,
                    crossAxisSpacing: 30.0,
                    mainAxisSpacing: 30.0,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return AddData(
                        title: 'Tambah Printer',
                        onPressed: onAddDataTap,
                      );
                    }
                    final item = items
                        .where((element) => element.type.isBluetooth)
                        .toList()[index - 1];
                    return ManagePrinterCard(
                      data: item,
                      onEditTap: () => onEditTap(item),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
