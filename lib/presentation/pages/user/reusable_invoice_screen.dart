import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ReusableInvoiceScreen extends StatefulWidget {
  const ReusableInvoiceScreen(
      {super.key,
      this.isHistory = false,
      this.id,
      this.name,
      this.date,
      this.paymentType,
      this.quantity,
      this.discount,
      this.amount,
      this.source});
  final bool isHistory;
  final String? id;
  final String? name;
  final DateTime? date;
  final String? paymentType;
  final String? quantity;
  final String? discount;
  final String? amount;
  final String? source;

  @override
  State<ReusableInvoiceScreen> createState() => _ReusableInvoiceScreenState();
}

class _ReusableInvoiceScreenState extends State<ReusableInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.paymentType != "income"
            ? S.of(context).Receipt
            : S.of(context).withdrawal,
        style: TextStyle(color: whiteColor),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            Image.asset(
              "assets/icons/logo_cool_vertical.png",
              height: 60.0,
            ),
            const SizedBox(
              height: 48,
            ),
            itemPayment(S.of(context).order_id, widget.id ?? "-"),
            itemPayment(S.of(context).customer, widget.name ?? "-"),
            itemPayment(
                S.of(context).date,
                DateFormat("dd MMM yyyy")
                    .format(widget.date ?? DateTime.now())),
            if (widget.isHistory == false) ...[
              itemPayment(S.of(context).due_date, "12 Des 2025"),
            ],
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: greyColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  itemPaymentDetail(
                      S.of(context).payment, widget.paymentType ?? "-"),
                  Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                  if (widget.quantity != null) ...[
                    itemPaymentDetail(
                        S.of(context).items, widget.quantity ?? "-"),
                    Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                  ],
                  if (widget.discount != null) ...[
                    itemPaymentDetail(S.of(context).discount,
                        "${Decimal.parse(widget.discount ?? "0")}%"),
                    Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                  ],
                  if (widget.source != null) ...[
                    itemPaymentDetail(
                        S.of(context).source,
                        widget.source == "other_pay"
                            ? "Other Pay"
                            : "Real Money"),
                    Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                  ],
                  itemPaymentTotal(
                      S.of(context).amount,
                      MoneyFormatter.formatMoney(
                        Decimal.parse(widget.amount ?? "0"),
                        true,
                      ).toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Padding itemPayment(String? title, String? subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            "$title :",
            style: const TextStyle(),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            "$subtitle",
            style: TextStyle(color: greyColor),
          ),
        )
      ],
    ),
  );
}

Padding itemPaymentDetail(String? title, String? subtitle) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "$title",
            style: TextStyle(color: greyColor),
          ),
        ),
        Expanded(
          child: Text(
            "$subtitle",
            style: TextStyle(color: greyColor),
          ),
        )
      ],
    ),
  );
}

Padding itemPaymentTotal(String? title, String? subtitle) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "$title",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: Text(
            "$subtitle",
            style: const TextStyle(fontSize: 16),
          ),
        )
      ],
    ),
  );
}
