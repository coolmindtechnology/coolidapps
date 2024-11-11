// ignore_for_file: library_private_types_in_public_api

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/response/payments/res_update_transaction_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/payments/loading_payment_saldo.dart';
import 'package:coolappflutter/presentation/pages/payments/midtrans_screen.dart';
import 'package:coolappflutter/presentation/pages/payments/paypal_screen.dart';
import 'package:coolappflutter/presentation/pages/user/reusable_invoice_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PreInvoiceScreen extends StatefulWidget {
  final String? snapToken;
  final dynamic orderId;
  final String? name;
  final DateTime? date;
  final dynamic paymentType;
  final dynamic quantity;
  final dynamic discount;
  final dynamic amount;
  final Function? onUpdate;
  final bool isWithSaldo;
  final dynamic id;
  final List<ItemDetailProfiling> itemDetails;
  final bool isMultiple;
  final dynamic fromPage;
  final bool isIndonesia;
  final dynamic currencyPaypal;

  const PreInvoiceScreen(
      {super.key,
      this.snapToken,
      this.orderId,
      this.name,
      this.date,
      this.paymentType,
      this.quantity,
      this.discount,
      this.amount,
      this.onUpdate,
      this.isWithSaldo = false,
      this.id,
      this.itemDetails = const [],
      this.isMultiple = false,
      this.fromPage,
      this.isIndonesia = true,
      this.currencyPaypal});

  @override
  _PreInvoiceScreenState createState() => _PreInvoiceScreenState();
}

class _PreInvoiceScreenState extends State<PreInvoiceScreen> {
  // bool isIndonesia = true;
  @override
  void initState() {
    // getIsIndonesia();
    debugPrint("cek amount ${widget.amount}");
    super.initState();
  }

// buat nanti untuk semua udah convert
  // getIsIndonesia() async {
  //   Future.microtask(() {
  //     setState(() {
  //       isIndonesia = context.read<ProviderUser>().isIndonesia();
  //     });
  //   });
  //   print(isIndonesia);
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).payment,
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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
              widget.orderId != null
                  ? itemPayment(S.of(context).order_id.toString(),
                      widget.orderId.toString())
                  : const SizedBox(),
              widget.name != null
                  ? itemPayment(S.of(context).customer, widget.name ?? "-")
                  : const SizedBox(),
              widget.date != null
                  ? itemPayment(
                      S.of(context).date,
                      DateFormat("dd MMM yyyy")
                          .format(widget.date ?? DateTime.now()))
                  : const SizedBox(),
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
                    if (widget.paymentType != null) ...[
                      itemPaymentDetail(S.of(context).payment.toString(),
                          widget.paymentType ?? "-"),
                      Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                    ],
                    widget.quantity != null
                        ? itemPaymentDetail(
                            S.of(context).items, widget.quantity ?? "-")
                        : const SizedBox(),
                    Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                    if (widget.itemDetails.isNotEmpty) ...[
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return itemPaymentDetail(
                              S.of(context).items,
                              widget.itemDetails[index].profilingName
                                  .toString());
                        },
                        itemCount: widget.itemDetails.length,
                        separatorBuilder: (context, index) => Divider(
                            height: 0.0, color: greyColor.withOpacity(0.5)),
                      ),
                      Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                    ],
                    widget.discount != null
                        ? itemPaymentDetail(S.of(context).discount.toString(),
                            "${Decimal.parse(widget.discount ?? "0")}%")
                        : const SizedBox(),
                    Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                    widget.amount != null
                        ? itemPaymentTotal(
                            S.of(context).amount.toString(),
                            dataGlobal.isIndonesia
                                ? MoneyFormatter.formatMoney(
                                        widget.amount.toString(),
                                        widget.isIndonesia)
                                    .toString()
                                : "${widget.currencyPaypal.toString()} ${widget.amount.toString()}")
                        : const SizedBox(),
                  ],
                ),
              )
            ],
          )),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.all(20),
          height: 54,
          child: ButtonPrimary(
            S.of(context).pay_now,
            onPress: () async {
              if (dataGlobal.isIndonesia) {
                if (widget.isWithSaldo) {
                  // bayar dengan saldo
                  Nav.replace(LoadingPaymentSaldo(
                      id: widget.id ?? '',
                      isMultiple: widget.isMultiple,
                      onUpdate: () {
                        widget.onUpdate!();
                        Nav.back();
                      }));
                } else {
                  Nav.replace(MidtransScreen(
                    snapToken: widget.snapToken,
                    codeOrder: widget.orderId.toString(),
                    onUpdate: () {
                      widget.onUpdate!();
                      // Nav.back();
                    },
                    fromPage: widget.fromPage.toString(),
                    isMultiple: widget.isMultiple,
                  ));
                }
              } else {
                if (widget.isWithSaldo) {
                  // bayar dengan saldo
                  Nav.replace(LoadingPaymentSaldo(
                      id: widget.id ?? '',
                      isMultiple: widget.isMultiple,
                      onUpdate: () {
                        widget.onUpdate!();
                        Nav.back();
                      }));
                } else {
                  Nav.to(PaypalScreen(
                    orderId: widget.orderId ?? widget.id.toString(),
                    currencyPaypal: widget.currencyPaypal.toString(),
                    amountPaypal: widget.amount.toString(),
                    onUpdate: () {
                      widget.onUpdate!();
                      Nav.back();
                      Nav.back();
                    },
                    fromPage: widget.fromPage.toString(),
                    isMultiple: widget.isMultiple,
                  ));
                }
              }
            },
            radius: 10,
          )),
    );
  }
}
