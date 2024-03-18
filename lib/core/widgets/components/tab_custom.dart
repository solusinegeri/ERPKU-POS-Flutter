import 'package:erpku_pos/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

import '../../theme/color_values.dart';



class TabCustom extends StatelessWidget {
  final List<TabMenu> children;
  final EdgeInsetsGeometry? padding;

  const TabCustom({
    super.key,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        border: Border.all(color: ColorValues.primary, width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(9.0)),
      ),
      child: Row(
        children: children,
      ),
    );
  }
}

class TabMenu extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const TabMenu({
    super.key,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: context.deviceWidth,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            color: isActive ? ColorValues.primary : ColorValues.white,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? ColorValues.white : ColorValues.primary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
