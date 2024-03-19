import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/widgets/components/search_input.dart';
import '../../../../../core/widgets/components/spaces.dart';
import '../../../widgets/card_save_order.dart';
import 'detail_save_order_page.dart';

class SaveOrderPage extends StatefulWidget {
  const SaveOrderPage({super.key});

  @override
  State<SaveOrderPage> createState() => _SaveOrderPageState();
}

class _SaveOrderPageState extends State<SaveOrderPage> {

  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Flexible(
                child: SizedBox(
                  child: SearchInput(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        // do something
                      });
                    },
                    hintText: 'Cari Nama Pemesan',
                  ),
                ),
              ),
            ),
            const SpaceHeight(16.0),
            Flexible(
              flex: 12,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CardSaveOrder(
                    orderName: 'jhone doe',
                    orderNumber: index + 1,
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailSaveOrderPage(
                            orderNumber: index + 1,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )
    );
  }
}
