import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/components/spaces.dart';
import '../data/entities/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel data;
  final VoidCallback onCartButton;
  final int qty;

  const ProductCard({
    super.key,
    required this.data,
    required this.onCartButton,
    required this.qty,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCartButton,
      child: Container(
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
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorValues.disabled.withOpacity(0.4),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    child: Image.asset(
                      data.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Spacer(),
                FittedBox(
                  child: Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SpaceHeight(8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          data.category.value,
                          style: const TextStyle(
                            color: ColorValues.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          data.priceFormat,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (qty > 0)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(9.0)),
                    color: ColorValues.primary,
                  ),
                  child: Center(
                    child: Text(
                      qty.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            else
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(9.0)),
                    color: ColorValues.primary,
                  ),
                  child: const Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}


