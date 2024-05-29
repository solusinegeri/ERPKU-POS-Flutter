import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItem extends StatelessWidget {
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;
  final Color color;
  final double iconSize;

  const NavItem({
    Key? key,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
    this.color = Colors.white,
    this.iconSize = 22.0, // Tambahkan parameter iconSize dengan nilai default 25.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: ColoredBox(
            color: isActive ? Colors.grey.withOpacity(0.25) : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: iconSize, // Gunakan nilai iconSize untuk lebar dan tinggi ikon
                height: iconSize,
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    color,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
