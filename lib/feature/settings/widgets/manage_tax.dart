import 'package:flutter/material.dart';

import '../../home/widgets/custom_tab_bar.dart';
import '../data/entities/tax_model.dart';
import 'add_data.dart';
import 'form_tax_dialog.dart';
import 'manage_tax_card.dart';
import 'settings_title.dart';



class ManageTax extends StatefulWidget {
  const ManageTax({super.key});

  @override
  State<ManageTax> createState() => _ManageTaxState();
}

class _ManageTaxState extends State<ManageTax> {
  final List<TaxModel> items = [
    TaxModel(
      name: 'Pajak 11%',
      value: 11,
      type: TaxType.pajak,
    ),
    TaxModel(
      name: 'Layanan 5%',
      value: 5,
      type: TaxType.layanan,
    ),
   
  ];

  void onEditTap(TaxModel item) {
    showDialog(
      context: context,
      builder: (context) => FormTaxDialog(data: item),
    );
  }

  void onAddDataTap() {
    showDialog(
      context: context,
      builder: (context) => const FormTaxDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SettingsTitle('Perhitungan Biaya'),
          const SizedBox(height: 24),
          CustomTabBar(
            tabTitles: const ['Layanan', 'Pajak'],
            initialTabIndex: 0,
            tabViews: [
              // LAYANAN TAB
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: items
                          .where((element) => element.type.isLayanan)
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
                        title: 'Tambah Perhitungan',
                        onPressed: onAddDataTap,
                      );
                    }
                    final item = items
                        .where((element) => element.type.isLayanan)
                        .toList()[index - 1];
                    return ManageTaxCard(
                      data: item,
                      onEditTap: () => onEditTap(item),
                    );
                  },
                ),
              ),

              // PAJAK TAB
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: items
                          .where((element) => element.type.isPajak)
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
                        title: 'Tambah Perhitungan',
                        onPressed: onAddDataTap,
                      );
                    }
                    final item = items
                        .where((element) => element.type.isPajak)
                        .toList()[index - 1];
                    return ManageTaxCard(
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
