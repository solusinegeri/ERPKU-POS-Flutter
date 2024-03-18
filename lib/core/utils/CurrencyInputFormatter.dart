import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final numericRegex = RegExp(r'[^0-9]');
    final newText = newValue.text.replaceAll(numericRegex, '');
    final formattedText = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(double.parse(newText) / 100);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
