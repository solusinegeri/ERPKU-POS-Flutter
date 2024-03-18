import 'package:flutter/material.dart';

import '../../../core/theme/color_values.dart';
import '../../../core/widgets/components/search_input.dart';


class SettingsTitle extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Function(String value)? onChanged;

  const SettingsTitle(
    this.title, {
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ColorValues.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (controller != null)
          SizedBox(
            width: 300.0,
            child: SearchInput(
              controller: controller!,
              onChanged: onChanged,
              hintText: 'Search for food, coffe, etc..',
            ),
          ),
      ],
    );
  }
}
