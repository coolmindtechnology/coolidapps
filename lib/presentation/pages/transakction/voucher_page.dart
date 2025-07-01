// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/provider_transaksi_affiliate.dart';
import 'package:coolappflutter/data/response/payments/res_update_transaction_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/payments/midtrans_screen.dart';
import 'package:coolappflutter/presentation/pages/user/reusable_invoice_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../payments/paypal_screen.dart';

class VoucherPage extends StatefulWidget {
  final String? snapToken;
  final dynamic orderId;
  final String? name;
  final DateTime? date;
  final dynamic paymentType;
  final dynamic quantity;
  final String? discount;
  final String? amount;
  final Function? onUpdate;
  final bool isWithSaldo;
  final String? id;
  final List<ItemDetailProfiling> itemDetails;
  final bool isMultiple;
  final String? fromPage;
  final bool isIndonesia;
  final bool isWithdraw;
  final String? source;
  final String? resultCenvertCurrency;

  const VoucherPage(
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
      this.isWithdraw = true,
      this.source,
      this.resultCenvertCurrency});

  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  // bool isIndonesia = true;
  @override
  void initState() {
    cekSession();
    if (kDebugMode) {
      print(widget.isIndonesia);
    }
    // getIsIndonesia();

    super.initState();
  }

  cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
    if (ceklanguage == null) {
      Prefs().setLocale('en_US', () {
        setState(() {
          S.load(Locale('en_US'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    } else {
      Prefs().setLocale('$ceklanguage', () {
        setState(() {
          S.load(Locale('$ceklanguage'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    }
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
        centerTitle: true,
        title: Text(
          widget.isWithdraw ? "Voucher" : "Pre-Invoice",
          style: TextStyle(color: whiteColor),
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Center(
                child: Image.asset(
                  "assets/icons/logo_cool_vertical.png",
                  height: 60.0,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              widget.orderId != null
                  ? itemPayment("ID", widget.orderId)
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
                      itemPaymentDetail(
                          S.of(context).payment, widget.paymentType ?? "-"),
                      Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                    ],
                    widget.amount != null
                        ? itemPaymentTotal(
                            S.of(context).amount,
                            MoneyFormatter.formatMoney(
                                    widget.amount, widget.isIndonesia)
                                .toString())
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
            widget.isWithdraw ? S.of(context).close : S.of(context).pay_now,
            onPress: () async {
              if (widget.source == "real_money") {
                context
                    .read<ProviderTransaksiAffiliate>()
                    .updateTransactionSaldoWithRealMoney(
                      context,
                      widget.id.toString(),
                    );
              } else if (widget.isWithdraw || widget.snapToken == null) {
                Nav.back();
                Nav.back(data: "withdraw");
              } else {
                if (!dataGlobal.isIndonesia) {
                  debugPrint(
                      "cek paypal ${widget.resultCenvertCurrency.toString()}");
                  Nav.to(PaypalScreen(
                    orderId: widget.orderId.toString(),
                    fromPage: "topup_affiliate",
                    currencyPaypal: "USD",
                    amountPaypal: widget.resultCenvertCurrency.toString(),
                  ));
                } else {
                  Nav.to(MidtransScreen(
                    snapToken: widget.snapToken,
                    fromPage: "topup_affiliate",
                  ));
                }
              }
            },
            radius: 10,
            elevation: 0.0,
          )),
    );
  }

  String formatDouble(double value) {
    // Format angka dengan pengaturan untuk menghilangkan nol di belakang koma
    final formatted =
        value.toStringAsFixed(10).replaceAll(RegExp(r'(?<=\d)0*$'), '');

    // Hapus titik jika tidak ada angka setelahnya
    return formatted.replaceAll(RegExp(r'\.$'), '');
  }

  double? safeStringToDouble(String input) {
    try {
      // Normalisasi string untuk memastikan format desimal yang benar
      String cleanedInput = input.replaceAll(RegExp(r'[^\d,.]'), '');
      cleanedInput = cleanedInput.replaceAll(',', '.');

      // Konversi ke double
      final double result = double.parse(cleanedInput);
      return result;
    } catch (e) {
      // Log atau tangani kesalahan jika diperlukan
      print("Failed to parse '$input' to double: $e");
      return null;
    }
  }
}
