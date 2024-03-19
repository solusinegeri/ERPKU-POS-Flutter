import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/core/widgets/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../core/widgets/components/search_input.dart';

class HomeTitle extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;

  const HomeTitle({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting('id_ID', null);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resto with Bahri POS',
              style: TextStyle(
                color: ColorValues.primary,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now()),
              style: const TextStyle(
                color: ColorValues.subtitle,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Flexible(
          child: SizedBox(
            width: 250.0,
            child: SearchInput(
              controller: controller,
              onChanged: onChanged,
              hintText: 'Search for food, coffe, etc..',
            ),
          ),
        ),
      ],
    );
  }
}
