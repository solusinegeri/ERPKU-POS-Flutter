import 'package:erpku_pos/core/extensions/int_ext.dart';
import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/widgets/components/spaces.dart';
import '../data/entities/order_item.dart';

class OrderMenu extends StatelessWidget {
  final OrderItem data;
  VoidCallback? onIncrement;
  VoidCallback? onDecrement;
  VoidCallback? delete;
  OrderMenu({super.key, required this.data, this.onIncrement , this.onDecrement, this.delete});

  @override
  Widget build(BuildContext context) {

    final noteController = TextEditingController();

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: Image.asset(
                    data.product.image,
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(data.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
                subtitle: Text(data.product.priceFormat),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: onDecrement,
                  child: Container(
                    width: 30,
                    height: 30,
                    color: ColorValues.white,
                    child: const Icon(
                      Icons.remove_circle,
                      color: ColorValues.primary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                  child: Center(
                      child: Text(
                    data.quantity.toString(),
                  )),
                ),
                GestureDetector(
                  onTap: onIncrement,
                  child: Container(
                    width: 30,
                    height: 30,
                    color: ColorValues.white,
                    child: const Icon(
                      Icons.add_circle,
                      color: ColorValues.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SpaceWidth(8),
            SizedBox(
              width: 80.0,
              child: Text(
                (data.product.price * data.quantity).currencyFormatRp,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: ColorValues.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SpaceHeight(16),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Catatan pesanan',
                ),
              ),
            ),
            const SpaceWidth(12),
            GestureDetector(
              onTap: delete,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height: 60.0,
                width: 60.0,
                decoration: const BoxDecoration(
                  color: ColorValues.primary,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Assets.icons.delete.svg(
                  colorFilter:
                      const ColorFilter.mode(ColorValues.white, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
