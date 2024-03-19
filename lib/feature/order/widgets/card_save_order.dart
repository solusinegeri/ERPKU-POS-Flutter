import 'package:flutter/material.dart';

import '../../../core/theme/color_values.dart';

class CardSaveOrder extends StatefulWidget {
  const CardSaveOrder({super.key, required this.orderNumber, required this.orderName, this.onTap});
  final int orderNumber;
  final String orderName;
  final void Function()? onTap;


  @override
  State<CardSaveOrder> createState() => _CardSaveOrderState();
}

class _CardSaveOrderState extends State<CardSaveOrder> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.infinity,
        height: 100,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.fromLTRB(2,0,2,14),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(10)
          ),
          color: ColorValues.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: ColorValues.primary,
                  borderRadius: BorderRadius.all(
                      Radius.circular(5)
                  ),
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
                    widget.orderName,
                    style: const TextStyle(
                      color: ColorValues.subtitle,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: ColorValues.primary,
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
