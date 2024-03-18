import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/widgets/components/spaces.dart';

class ColumnButton extends StatelessWidget {
  final String label;
  final SvgGenImage svgGenImage;
  final VoidCallback onPressed;

  const ColumnButton({
    super.key,
    required this.label,
    required this.svgGenImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: ColorValues.white,
              border: Border.all(color: ColorValues.primary),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: svgGenImage.svg(),
          ),
          const SpaceHeight(8.0),
          Text(
            label,
            style: const TextStyle(
              color: ColorValues.primary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
