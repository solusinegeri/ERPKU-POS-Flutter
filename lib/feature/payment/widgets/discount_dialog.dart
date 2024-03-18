import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';

class DiscountDialog extends StatelessWidget {
  const DiscountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'DISKON',
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
            title: const Text('Nama Diskon: BUKAPUASA'),
            subtitle: const Text('Potongan harga (20%)'),
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
          ListTile(
            title: const Text('Nama Diskon: WELCOMECWB'),
            subtitle: const Text('Potongan harga (30%)'),
            contentPadding: EdgeInsets.zero,
            textColor: ColorValues.primary,
            trailing: Checkbox(
              value: false,
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
