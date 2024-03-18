import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';

class IsEmpty extends StatelessWidget {
  const IsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.noProduct.svg(),
          const SizedBox(height: 80.0),
          const Text(
            'Belum Ada Produk',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}