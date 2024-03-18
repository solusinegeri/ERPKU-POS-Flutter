import 'package:erpku_pos/feature/home/data/entities/order_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/theme/color_values.dart';
import '../../../core/utils/CurrencyInputFormatter.dart';
import '../../../core/widgets/components/buttons.dart';
import '../../../core/widgets/components/spaces.dart';
import '../../home/widgets/column_button.dart';
import '../../home/widgets/empty_product.dart';
import '../../home/widgets/order_menu.dart';
import '../widgets/discount_dialog.dart';
import '../widgets/service_dialog.dart';
import '../widgets/success_payment_dialog.dart';
import '../widgets/tax_dialog.dart';

class ConfirmPaymentPage extends StatefulWidget {
  final List<OrderItem> selectedProducts;
  const ConfirmPaymentPage({super.key, required this.selectedProducts});

  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {

  TextEditingController totalPriceController = TextEditingController();

  bool isCashFilled = true;
  bool isQRISFilled = false;

  final CurrencyInputFormatter _currencyFormatter = CurrencyInputFormatter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // LEFT CONTENT
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Konfirmasi',
                              style: TextStyle(
                                color: ColorValues.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Orders #1',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 60.0,
                            width: 60.0,
                            decoration: const BoxDecoration(
                              color: ColorValues.primary,
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: ColorValues.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SpaceHeight(8.0),
                    const Divider(),
                    const SpaceHeight(24.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Item',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 160,
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            'Qty',
                            style: TextStyle(
                              color: ColorValues.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            'Price',
                            style: TextStyle(
                              color: ColorValues.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SpaceHeight(8),
                    const Divider(),
                    const SpaceHeight(8),
                    if(widget.selectedProducts.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: IsEmpty(),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return OrderMenu(
                            data: widget.selectedProducts[index],
                            delete: () {
                              widget.selectedProducts.removeAt(index);
                              setState(() {});
                            },
                            onDecrement: () {
                              if(widget.selectedProducts[index].quantity <= 1){
                                widget.selectedProducts.removeAt(index);
                              }else{
                                widget.selectedProducts[index].quantity--;
                              }
                              setState(() {});
                            },
                            onIncrement: () {
                              widget.selectedProducts[index].quantity++;
                              setState(() {});
                            }
                          );
                        },
                        separatorBuilder: (context, index) =>
                        const SpaceHeight(16.0),
                        itemCount: widget.selectedProducts.length,
                      ),
                    const SpaceHeight(16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ColumnButton(
                          label: 'Diskon',
                          svgGenImage: Assets.icons.diskon,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => const DiscountDialog(),
                          ),
                        ),
                        ColumnButton(
                          label: 'Pajak',
                          svgGenImage: Assets.icons.pajak,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => const TaxDialog(),
                          ),
                        ),
                        ColumnButton(
                          label: 'Layanan',
                          svgGenImage: Assets.icons.layanan,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => const ServiceDialog(),
                          ),
                        ),
                      ],
                    ),
                    const SpaceHeight(8.0),
                    const Divider(),
                    const SpaceHeight(8.0),

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
                    const SpaceHeight(16.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Diskon',
                          style: TextStyle(color: ColorValues.grey),
                        ),
                        Text(
                          'Rp. 0',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SpaceHeight(16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sub total',
                          style: TextStyle(color: ColorValues.grey),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp').format(widget.selectedProducts.fold(0, (previousValue, element) => previousValue + (element.product.price * element.quantity))),
                          style: const TextStyle(
                            color: ColorValues.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SpaceHeight(16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                              color: ColorValues.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp').format(widget.selectedProducts.fold(0, (previousValue, element) => previousValue + (element.product.price * element.quantity)) * 1.11),
                          style: const TextStyle(
                            color: ColorValues.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // RIGHT CONTENT
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pembayaran',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          '2 opsi pembayaran tersedia',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SpaceHeight(8.0),
                        const Divider(),
                        const SpaceHeight(8.0),
                        const Text(
                          'Metode Bayar',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SpaceHeight(12.0),
                        Row(
                          children: [
                            Button.outlined(
                              width: 120.0,
                              height: 50.0,
                              onPressed: () {
                                setState(() {
                                  isCashFilled = true;
                                  isQRISFilled = false;
                                });
                              },
                              label: 'Cash',
                              textColor: isCashFilled ? ColorValues.white : ColorValues.primary,
                              color: isCashFilled ? ColorValues.primary : Colors.transparent, // Adjust color dynamically
                            ),
                            const SizedBox(width: 8.0),
                            Button.outlined(
                              width: 120.0,
                              height: 50.0,
                              onPressed: () {
                                setState(() {
                                  isCashFilled = false;
                                  isQRISFilled = true;
                                });
                              },
                              label: 'QRIS',
                              textColor: isQRISFilled ? ColorValues.white : ColorValues.primary,
                              color: isQRISFilled ? ColorValues.primary : Colors.transparent, // Adjust color dynamically
                            ),
                          ],
                        ),
                        const SpaceHeight(8.0),
                        const Divider(),
                        const SpaceHeight(8.0),
                        const Text(
                          'Total Bayar',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SpaceHeight(12.0),
                        TextFormField(
                          controller: totalPriceController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [_currencyFormatter],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            hintText: 'Total harga',
                          ),
                        ),
                        const SpaceHeight(45.0),
                        Row(
                          children: [
                            Button.filled(
                              width: 150.0,
                              onPressed: () {
                                totalPriceController.text = 'Rp 50.000';
                              },
                              label: 'Rp 50.000',
                            ),
                            const SpaceWidth(20.0),
                            Button.filled(
                              width: 150.0,
                              onPressed: () {
                                totalPriceController.text = 'Rp 100.000';
                              },
                              label: 'Rp 100.000',
                            ),
                            const SpaceWidth(20.0),
                            Button.filled(
                              width: 150.0,
                              onPressed: () {
                                totalPriceController.text = 'Rp 200.000';
                              },
                              label: 'Rp 200.000',
                            ),
                            const SpaceWidth(20.0),
                            Button.filled(
                              width: 150.0,
                              onPressed: () {
                                totalPriceController.text = 'Rp 250.000';
                              },
                              label: 'Rp 250.000',
                            ),
                          ],
                        ),
                        const SpaceHeight(100.0),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ColoredBox(
                      color: ColorValues.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Button.outlined(
                                onPressed: () => Navigator.pop(context),
                                label: 'Batalkan',
                              ),
                            ),
                            const SpaceWidth(8.0),
                            Flexible(
                              child: Button.filled(
                                onPressed: () async {
                                  if (totalPriceController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Total harga tidak boleh kosong'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => SuccessPaymentDialog(
                                        nominalPayment: totalPriceController.text,
                                        totalPayment: NumberFormat.currency(locale: 'id', symbol: 'Rp').format(widget.selectedProducts.fold(0, (previousValue, element) => previousValue + (element.product.price * element.quantity)) * 1.11),
                                        chargePaymennt: NumberFormat.currency(locale: 'id', symbol: 'Rp').format(int.parse(totalPriceController.text.replaceAll('Rp', '').replaceAll('.', '')) - (widget.selectedProducts.fold(0, (previousValue, element) => previousValue + (element.product.price * element.quantity)) * 1.11)),
                                        methodPayment: 'Tunai',
                                      ),
                                    );
                                  }
                                },
                                label: 'Bayar',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
