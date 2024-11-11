import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/user/reusable_invoice_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoiceDetailPage extends StatefulWidget {
  const InvoiceDetailPage({super.key, required this.id});
  final String id;

  @override
  State<InvoiceDetailPage> createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  @override
  void initState() {
    setState(() {});
    debugPrint("okk...");
    Provider.of<ProviderUser>(context, listen: false)
        .fetchInvoiceDetail(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Receipt",
        style: TextStyle(color: whiteColor),
      )),
      body: Consumer<ProviderUser>(
        builder: (context, provider, child) {
          if (provider.isLoadings) {
            return const Center(child: CircularProgressWidget());
          }

          final invoice = provider.invoiceData;

          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
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
                    Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: greyColor.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              itemPayment(S.of(context).customer,
                                  "${invoice['customer']}"),
                              const SizedBox(height: 8),
                              Divider(
                                  height: 0.0,
                                  color: greyColor.withOpacity(0.5)),
                              itemPayment(
                                  S.of(context).items, "${invoice['items']}"),
                              const SizedBox(height: 8),
                              Divider(
                                  height: 0.0,
                                  color: greyColor.withOpacity(0.5)),
                              itemPayment(S.of(context).order_id.toString(),
                                  "${invoice['order_id']}"),
                              const SizedBox(height: 8),
                              Divider(
                                  height: 0.0,
                                  color: greyColor.withOpacity(0.5)),
                              itemPayment(
                                  S.of(context).date, "${invoice['date']}"),
                              const SizedBox(height: 8),
                              Divider(
                                  height: 0.0,
                                  color: greyColor.withOpacity(0.5)),
                              itemPayment(
                                  "Payment Type",
                                  invoice['payment_type'].toString() != "null"
                                      ? "${invoice['payment_type']}"
                                      : "-"),
                              const SizedBox(height: 8),
                              Divider(
                                  height: 0.0,
                                  color: greyColor.withOpacity(0.5)),
                              itemPayment(S.of(context).discount,
                                  "${invoice['discount']} %"),
                              const SizedBox(height: 8),
                              Divider(
                                  height: 0.0,
                                  color: greyColor.withOpacity(0.5)),
                              itemPaymentTotal(
                                  S.of(context).amount,
                                  MoneyFormatter.formatMoney(
                                    Decimal.parse(invoice['amount'] ?? "0"),
                                    true,
                                  ).toString()),
                              const SizedBox(height: 8),
                              Divider(
                                  height: 0.0,
                                  color: greyColor.withOpacity(0.5)),
                            ],
                          ),
                        )),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
