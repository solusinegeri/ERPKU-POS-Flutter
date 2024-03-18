import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/components/spaces.dart';


class AddData extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AddData({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: ColorValues.card),
            borderRadius: BorderRadius.circular(19),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              color: ColorValues.primary,
            ),
            const SpaceHeight(8.0),
            Text(
              title,
              style: const TextStyle(
                color: ColorValues.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
