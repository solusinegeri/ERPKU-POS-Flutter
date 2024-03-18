import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../data/entities/discount_model.dart';


class ManageDiscountCard extends StatelessWidget {
  final DiscountModel data;
  final VoidCallback onEditTap;

  const ManageDiscountCard({
    super.key,
    required this.data,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: ColorValues.card),
          borderRadius: BorderRadius.circular(19),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorValues.disabled.withOpacity(0.4),
                ),
                child: Text(
                  '${data.discount}%',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Nama Promo : ',
                    children: [
                      TextSpan(
                        text: data.code,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: ColorValues.black,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: ColorValues.primary,
                ),
                child: Assets.icons.edit.svg(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
