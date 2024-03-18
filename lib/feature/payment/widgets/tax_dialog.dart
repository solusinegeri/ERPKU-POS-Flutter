import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';


class TaxDialog extends StatelessWidget {
  const TaxDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'PAJAK',
            style: TextStyle(
              color: ColorValues.primary,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.cancel,
                color: ColorValues.primary,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Pajak Pertambahan Nilai'),
            subtitle: const Text('tarif pajak (11%)'),
            contentPadding: EdgeInsets.zero,
            textColor: ColorValues.primary,
            trailing: Checkbox(
              value: true,
              onChanged: (value) {},
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
