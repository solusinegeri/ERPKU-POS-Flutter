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

    // Ubah nilai menjadi double
    final doubleValue = double.tryParse(newText) ?? 0.0;

    // Format ke mata uang tanpa desimal
    final formattedText = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(doubleValue);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
