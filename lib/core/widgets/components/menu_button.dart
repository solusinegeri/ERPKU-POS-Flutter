import 'package:erpku_pos/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/color_values.dart';
import 'components.dart';

class MenuButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;
  final bool isImage;
  final double size;

  const MenuButton({
    super.key,
    required this.iconPath,
    required this.label,
    this.isActive = false,
    required this.onPressed,
    this.isImage = false,
    this.size = 90,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onPressed,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        child: Container(
          width: context.deviceWidth,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: isActive ? ColorValues.primary : ColorValues.white,
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 20.0,
                blurStyle: BlurStyle.outer,
                spreadRadius: 0,
                color: ColorValues.black.withOpacity(0.1),
              ),
            ],
          ),
          child: Column(
            children: [
              isImage
                  ? Image.asset(iconPath,
                      width: size, height: size, fit: BoxFit.contain)
                  : SvgPicture.asset(
                      iconPath,
                      colorFilter: ColorFilter.mode(
                        isActive ? ColorValues.white : ColorValues.primary,
                        BlendMode.srcIn,
                      ),
                    ),
              const SpaceHeight(10.0),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? ColorValues.white : ColorValues.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
