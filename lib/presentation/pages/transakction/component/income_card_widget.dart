import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeCardWidget extends StatelessWidget {
  final String? nominal;
  final DateTime? date;
  const IncomeCardWidget({
    super.key,
    this.nominal,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(MoneyFormatter.formatMoney(nominal, true) ?? ""),
          ),
          Text(
            DateFormat("dd/MM/yyyy").format(date ?? DateTime.now()),
            style: TextStyle(color: greyColor),
          )
        ],
      ),
    );
  }
}
