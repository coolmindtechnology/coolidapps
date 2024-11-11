import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OutcomeCardWidget extends StatelessWidget {
  final String? nominal;
  final String? status;
  final DateTime? date;
  const OutcomeCardWidget({
    super.key,
    this.nominal,
    this.status,
    this.date,
  });

  Color _getStatusColor() {
    if (status?.toLowerCase() == 'prosess') {
      return Colors.orange;
    } else if (status?.toLowerCase() == 'success') {
      return greenColor;
    } else {
      return Colors.black; // default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(MoneyFormatter.formatMoney(nominal, true) ?? ""),
            Text(
              status ?? "",
              style: TextStyle(color: _getStatusColor()),
            ),
          ],
        ),
        Text(
          DateFormat("dd/MM/yyyy").format(date ?? DateTime.now()),
          style: TextStyle(color: greyColor),
        )
      ],
    );
  }
}
