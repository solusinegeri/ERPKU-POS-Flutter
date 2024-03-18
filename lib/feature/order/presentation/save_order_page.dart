import 'package:flutter/material.dart';

class SaveOrderPage extends StatefulWidget {
  const SaveOrderPage({super.key});

  @override
  State<SaveOrderPage> createState() => _SaveOrderPageState();
}

class _SaveOrderPageState extends State<SaveOrderPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('Save Order Page'),
        ));
  }
}
