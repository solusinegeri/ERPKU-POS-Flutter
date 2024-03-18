import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/widgets/components/buttons.dart';
import '../../../core/widgets/components/spaces.dart';

class SuccessPaymentDialog extends StatefulWidget {
  final String methodPayment;
  final String totalPayment;
  final String nominalPayment;
  final String chargePaymennt;
  const SuccessPaymentDialog({super.key, required this.methodPayment, required this.totalPayment, required this.nominalPayment, required this.chargePaymennt});

  @override
  State<SuccessPaymentDialog> createState() => _SuccessPaymentDialogState();
}

class _SuccessPaymentDialogState extends State<SuccessPaymentDialog> {

  String getCurrentDateAndTime() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Assets.icons.success.svg()),
            const SpaceHeight(16.0),
            const Center(
              child: Text(
                'Pembayaran telah sukses dilakukan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SpaceHeight(20.0),
            const Text('METODE BAYAR'),
            const SpaceHeight(5.0),
            Text(
              widget.methodPayment,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('TOTAL TAGIHAN'),
            const SpaceHeight(5.0),
            Text(
              widget.totalPayment,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('NOMINAL BAYAR'),
            const SpaceHeight(5.0),
            Text(
              widget.nominalPayment,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('WAKTU PEMBAYARAN'),
            const SpaceHeight(5.0),
            Text(
              getCurrentDateAndTime(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(20.0),
            Row(
              children: [
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: 'Kembali',
                  ),
                ),
                const SpaceWidth(8.0),
                Flexible(
                  child: Button.filled(
                    onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                          content: Text('Print'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    label: 'Print',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
