import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      // Penanganan kasus ketika pengguna menghapus semua teks
      return newValue;
    }

    int value =
        int.tryParse(newValue.text.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
    final formatter = NumberFormat("#,##0", "id_ID"); // Format angka

    String newText = formatter.format(value); // Terapkan format
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
