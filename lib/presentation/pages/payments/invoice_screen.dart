import 'package:coolappflutter/data/provider/provider_payment.dart';
import 'package:coolappflutter/data/response/payments/res_history_topup.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatefulWidget {
  final DataHistoryTopup data;
  const InvoiceScreen({super.key, this.isHistory = false, required this.data});
  final bool isHistory;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProviderPayment>().getInvoice(context, widget.data.orderId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderPayment>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
          "Receipt",
          style: TextStyle(color: whiteColor),
        )),
        body: value.isLoadingInvoice
            ? const CircularProgressWidget()
            : SingleChildScrollView(
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
                    itemPayment(S.of(context).order_id.toString(),
                        value.dataInvoice?.orderId.toString()),
                    itemPayment(S.of(context).customer.toString(),
                        value.dataInvoice?.customer.toString()),
                    itemPayment(
                        S.of(context).date,
                        DateFormat("dd MMM yyyy").format(
                            value.dataInvoice?.transactionDate ??
                                DateTime.now())),
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
                          itemPaymentDetail(S.of(context).payment,
                              value.dataInvoice?.paymentType ?? "-"),
                          Divider(
                              height: 0.0, color: greyColor.withOpacity(0.5)),
                          itemPaymentDetail(S.of(context).items,
                              "${value.dataInvoice?.itemDetails?[0].quantity}"),
                          Divider(
                              height: 0.0, color: greyColor.withOpacity(0.5)),
                          itemPaymentDetail(S.of(context).discount,
                              "${Decimal.parse(value.dataInvoice?.discount ?? "0")}%"),
                          Divider(
                              height: 0.0, color: greyColor.withOpacity(0.5)),
                          itemPaymentTotal(
                              S.of(context).amount,
                              MoneyFormatter.formatMoney(
                                Decimal.parse(
                                    value.dataInvoice?.totalAmount ?? "0"),
                                true,
                              ).toString()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }

  Padding itemPayment(String? title, String? subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$title :",
            style: const TextStyle(),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            "$subtitle",
            style: TextStyle(color: greyColor),
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
          Text(
            "$title",
            style: TextStyle(color: greyColor),
          ),
          Text(
            "$subtitle",
            style: TextStyle(color: greyColor),
          )
        ],
      ),
    );
  }

  Padding itemPaymentTotal(String? title, String? subtitle) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "$subtitle",
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
