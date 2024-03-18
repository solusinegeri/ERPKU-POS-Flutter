import 'package:erpku_pos/core/extensions/date_time_ext.dart';
import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/components/spaces.dart';


class ReportTitle extends StatelessWidget {
  const ReportTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Report',
          style: TextStyle(
            color: ColorValues.primary,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SpaceHeight(4.0),
        Text(
          DateTime.now().toFormattedDate(),
          style: const TextStyle(
            color: ColorValues.subtitle,
            fontSize: 16,
          ),
        ),
        const SpaceHeight(20.0),
        const Divider(),
      ],
    );
  }
}
