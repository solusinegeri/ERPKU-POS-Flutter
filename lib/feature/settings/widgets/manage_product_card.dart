import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/theme/color_values.dart';
import '../../../core/widgets/components/spaces.dart';
import '../../home/data/entities/product_model.dart';


class ManageProductCard extends StatelessWidget {
  final ProductModel data;
  final VoidCallback onCartButton;

  const ManageProductCard({
    super.key,
    required this.data,
    required this.onCartButton,
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
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorValues.disabled.withOpacity(0.4),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: Image.asset(
                    data.image,
                    width: 68,
                    height: 68,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                data.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SpaceHeight(8.0),
              const SpaceHeight(8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      data.category.value,
                      style: const TextStyle(
                        color: ColorValues.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      data.priceFormat,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onCartButton,
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
