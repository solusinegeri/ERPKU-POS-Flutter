import 'dart:io';

import 'package:erpku_pos/core/extensions/int_ext.dart';
import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/feature/home/data/entities/save_order_data_model.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/widgets/components/spaces.dart';
import '../../home/data/entities/order_item.dart';

class OrderMenuHistory extends StatelessWidget {
  final OrderItem data;
  final String orderPayment;
  final String qty;
  OrderMenuHistory({super.key, required this.data,required this.qty, required this.orderPayment,});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: Image.file(
                    File(data.product.image),
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
                SizedBox(
                  width: 30.0,
                  child: Center(
                      child: Text(
                   qty,
                  )),
                ),
              ],
            ),
            const SpaceWidth(8),
            SizedBox(
              width: 80.0,
              child: Text(
                orderPayment,
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
      ],
    );
  }
}
