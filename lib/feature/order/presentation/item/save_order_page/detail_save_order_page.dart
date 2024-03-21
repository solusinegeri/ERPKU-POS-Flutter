import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/core/widgets/components/components.dart';
import 'package:erpku_pos/feature/home/presentation/home_page.dart';
import 'package:erpku_pos/feature/payment/presentation/confirm_payment_page.dart';
import 'package:erpku_pos/feature/product/presentation/update_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../../core/service/database_helper_save_product.dart';
import '../../../../home/data/entities/save_order_data_model.dart';
import '../../../../home/widgets/empty_product.dart';
import '../../../../home/widgets/order_menu.dart';

class DetailSaveOrderPage extends StatefulWidget {
  const DetailSaveOrderPage({super.key, required this.orderNumber, required this.orderSaveData});

  final int orderNumber;
  final OrderSaveData orderSaveData;

  @override
  State<DetailSaveOrderPage> createState() => _DetailSaveOrderPageState();
}

class _DetailSaveOrderPageState extends State<DetailSaveOrderPage> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 1000 ?
    Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // Force landscape mode
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          }
          return const Center(
            child: Text(
              'App Khusus Screen (Tablet Version dan mode landscape) ganti resolusi anda.',
              style: TextStyle(fontSize: 32),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    ) :SafeArea(
      child:  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Detail Pesanan',
            style: TextStyle(
              color: ColorValues.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorValues.primary,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Item',
                  style: TextStyle(
                    color: ColorValues.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SpaceHeight(16.0),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: ColorValues.primary,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "#${widget.orderNumber}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Nama Pemesan',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          widget.orderSaveData.orderName.toString(),
                          style: const TextStyle(
                            color: ColorValues.subtitle,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: ColorValues.primary,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateProductPage(
                                    orderName: widget.orderSaveData.orderName.toString(),
                                    orderNumber: widget.orderNumber,
                                    orderSaveData: widget.orderSaveData,
                                    selectedProducts: widget.orderSaveData.orderItems,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SpaceWidth(16.0),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () async {
                              await DatabaseHelperSaveProduct.deleteOrder(widget.orderSaveData);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Order Berhasil Dihapus', style: TextStyle(color: Colors.white),),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SpaceHeight(16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.orderSaveData.orderItems.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: IsEmpty(),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OrderMenu(
                            data: widget.orderSaveData.orderItems[index],
                            onIncrement: () {
                              widget.orderSaveData.orderItems[index].quantity++;
                              setState(() {});
                            },
                            onDecrement: () {
                              if (widget.orderSaveData.orderItems[index].quantity > 1) {
                                widget.orderSaveData.orderItems[index].quantity--;
                              }else{
                                widget.orderSaveData.orderItems.removeAt(index);
                              }
                              setState(() {});
                            },
                            delete: () {
                              widget.orderSaveData.orderItems.removeAt(index);
                              setState(() {});
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                        const SpaceHeight(1.0),
                        itemCount: widget.orderSaveData.orderItems.length,
                      ),
                  ],
                ),
                const SpaceHeight(16.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pajak',
                      style: TextStyle(color: ColorValues.grey),
                    ),
                    Text(
                      '11 %',
                      style: TextStyle(
                        color: ColorValues.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sub total',
                      style: TextStyle(color: ColorValues.grey),
                    ),
                    Text(
                      NumberFormat.currency(
                          locale: 'id_ID', symbol: 'Rp')
                          .format(widget.orderSaveData.orderItems.fold(0, (previousValue, element) => previousValue + (element.product.price * element.quantity)).toInt()),
                      style: const TextStyle(
                        color: ColorValues.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(24.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SpaceWidth(8.0),
                      Flexible(
                        child: Button.filled(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmPaymentPage(
                                  selectedProducts: widget.orderSaveData.orderItems,
                                  orderNumber: widget.orderNumber,
                                ),
                              ),
                            );
                          },
                          label: 'Pembayaran',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
