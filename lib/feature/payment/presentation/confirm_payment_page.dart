import 'package:erpku_pos/core/service/database_helper_history_payment_product.dart';
import 'package:erpku_pos/feature/home/data/entities/history_order_data_model.dart';
import 'package:erpku_pos/feature/home/data/entities/order_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/service/database_helper_save_product.dart';
import '../../../core/theme/color_values.dart';
import '../../../core/utils/CurrencyInputFormatter.dart';
import '../../../core/widgets/components/buttons.dart';
import '../../../core/widgets/components/spaces.dart';
import '../../home/data/entities/product_model.dart';
import '../../home/data/entities/save_order_data_model.dart';
import '../../home/widgets/column_button.dart';
import '../../home/widgets/empty_product.dart';
import '../../home/widgets/order_menu.dart';
import '../widgets/discount_dialog.dart';
import '../widgets/service_dialog.dart';
import '../widgets/success_payment_dialog.dart';
import '../widgets/tax_dialog.dart';

class ConfirmPaymentPage extends StatefulWidget {
  final List<OrderItem> selectedProducts;
  final int? orderNumber;
  final OrderSaveData? orderSaveData;
  final String? selectedDiscountCode;
  const ConfirmPaymentPage({super.key, required this.selectedProducts, this.orderNumber, this.orderSaveData, this.selectedDiscountCode});

  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {

  TextEditingController totalPriceController = TextEditingController();

  late SharedPreferences _prefs;
  late bool bukaPuasaDiscount = false;
  late bool welcomeCWBDiscount = false;
  bool isCashFilled = true;
  bool isQRISFilled = false;

  final CurrencyInputFormatter _currencyFormatter = CurrencyInputFormatter();

  @override
  void initState() {
    super.initState();
    _loadDiscountStatus();
  }

  _loadDiscountStatus() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      bukaPuasaDiscount = _prefs.getBool('bukaPuasaDiscount') ?? false;
      welcomeCWBDiscount = _prefs.getBool('welcomeCWBDiscount') ?? false;
    });
  }

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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Konfirmasi',
                              style: TextStyle(
                                color: ColorValues.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Orders #${widget.orderNumber}',
                              style: const TextStyle(
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
                          onPressed: () async {
                            bool previousBukaPuasaDiscount = bukaPuasaDiscount;
                            bool previousWelcomeCWBDiscount = welcomeCWBDiscount;

                            final selectedDiscount = await showDialog<String>(
                              context: context,
                              builder: (context) => const DiscountDialog(),
                            );

                            if (selectedDiscount != null) {
                              if (selectedDiscount == 'BUKAPUASA') {
                                bukaPuasaDiscount = true;
                                welcomeCWBDiscount = false;
                              } else if (selectedDiscount == 'WELCOMECWB') {
                                welcomeCWBDiscount = true;
                                bukaPuasaDiscount = false;
                              }else if (selectedDiscount == 'BACK') {
                                welcomeCWBDiscount = false;
                                bukaPuasaDiscount = false;
                              }
                            } else {
                              bukaPuasaDiscount = previousBukaPuasaDiscount;
                              welcomeCWBDiscount = previousWelcomeCWBDiscount;
                            }

                            setState(() {});
                          },
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
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Diskon',
                          style: TextStyle(color: ColorValues.grey),
                        ),
                        Text(
                          bukaPuasaDiscount ? '20%' : (welcomeCWBDiscount ? '30%' : 'Rp. 0'),
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
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp').format(
                            _calculateTotalPayment()
                          ),
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
                                    _saveHistoryOrderData('Order #${widget.orderNumber}',
                                        totalPriceController.text,
                                        widget.selectedProducts);
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

  List<OrderItem> _convertToOrderItems(Map<ProductModel, int> selectedProducts) {
    return selectedProducts.entries.map((entry) {
      return OrderItem(product: entry.key, quantity: entry.value);
    }).toList();
  }

  void _saveHistoryOrderData(String name, String nominal, List<OrderItem> orderItems) async {
    if (name.isNotEmpty && orderItems.isNotEmpty) {
      final HistoryOrderSaveData historyOrderSaveData = HistoryOrderSaveData(
        orderName: name,
        orderNominal: nominal,
        orderItems: orderItems,
      );

      int result = await DatabaseHelperHistoryPaymentProduct.insertHistoryOrder(historyOrderSaveData);

      if (result != 0) {
        print('Data berhasil dimasukkan ke dalam database!');
        List<HistoryOrderSaveData> allOrders = await DatabaseHelperHistoryPaymentProduct.getHistoryOrder();
        print('Semua pesanan dalam database:');
        print(widget.orderSaveData);
        print(widget.orderNumber);
        int i = 1;
        if (name == "Order #${widget.orderNumber}" && widget.orderSaveData != null) {
          await DatabaseHelperSaveProduct.deleteOrder(widget.orderSaveData!);
          setState(() {});
        }
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
        for (HistoryOrderSaveData order in allOrders) {
          print(order.toJson());
        }
      } else {
        print('Gagal memasukkan data ke dalam database.');
      }

      Navigator.pop(context);
    } else {
      if (name.isEmpty) {
        print('Nama is null');
      }
      if (orderItems.isEmpty) {
        print('Anda belum memilih produk.');
      }
      Navigator.pop(context);
    }
  }

  double _calculateTotalPayment() {
    double totalHarga = widget.selectedProducts.fold(0, (previousValue, element) => previousValue + (element.product.price * element.quantity));

    // Menghitung diskon berdasarkan status diskon yang dipilih
    double diskon = 0.0;
    if (bukaPuasaDiscount) {
      diskon = totalHarga * 0.2; // Diskon 20%
    } else if (welcomeCWBDiscount) {
      diskon = totalHarga * 0.3; // Diskon 30%
    }

    // Menghitung total pembayaran setelah diskon dan pajak
    double totalPembayaran = totalHarga - diskon;
    totalPembayaran *= 1.11; // Total dengan pajak 11%
    return totalPembayaran;
  }
}
