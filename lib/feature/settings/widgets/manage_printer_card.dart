import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/components/spaces.dart';
import '../data/entities/printer_model.dart';


class ManagePrinterCard extends StatelessWidget {
  final PrinterModel data;
  final VoidCallback onEditTap;

  const ManagePrinterCard({
    super.key,
    required this.data,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: ColorValues.card),
          borderRadius: BorderRadius.circular(19),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nama Printer'),
          Text(
            data.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SpaceHeight(16.0),
          const Text('Alamat IP'),
          Text(
            data.ipAddress,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SpaceHeight(16.0),
          const Text('Ukuran Struk'),
          Text(
            data.size,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
