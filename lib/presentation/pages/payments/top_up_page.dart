import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/models/data_checkout_transaction.dart';
import 'package:cool_app/data/provider/provider_payment.dart';
import 'package:cool_app/data/response/payments/res_get_data_top_up.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:cool_app/presentation/utils/money_formatter.dart';
import 'package:cool_app/presentation/widgets/button_primary.dart';
import 'package:cool_app/presentation/widgets/shimmer_loading.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController();

  int? selected;
  bool islainnya = false;
  final formKey = GlobalKey<FormState>();
  Color buttonColor = Colors.white;

  DataListTopUp? dataListTopUpCheckout;

  double lowestPrice = 0.0, highestPrice = 0.0;
  bool hasId2 = false, hasId3 = false;

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.cannot_be_empty;
    }

    double enteredValue = double.tryParse(value) ?? 0.0;

    if (enteredValue < lowestPrice) {
      return 'Nilai kurang dari jumlah minimal yang diizinkan';
    } else if (enteredValue > highestPrice) {
      return 'Nilai melebihi jumlah maksimal yang diizinkan';
    } else if (enteredValue % lowestPrice != 0) {
      return "${S.current.required_multiple} $lowestPrice";
    }

    // Validasi berhasil
    return null;
  }

  DataCheckoutTransaction dataCheckoutTransaction = DataCheckoutTransaction();

  int cleanCurrency(String value) {
    String result = "";
    result = value.replaceAll(".", "");
    result = result.replaceAll("Rp ", "");
    result = result.replaceAll("IDR ", "");
    return int.tryParse(result) ?? 0;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderPayment>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            S.of(context).top_up,
            style: TextStyle(color: whiteColor),
          ),
        ),
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).choose_topup),
                  const SizedBox(
                    height: 8,
                  ),
                  if (value.isLoading) ...[
                    ShimmerLoadingWidget(
                        height: 54, width: MediaQuery.of(context).size.width),
                    const SizedBox(
                      height: 8,
                    ),
                    ShimmerLoadingWidget(
                        height: 54, width: MediaQuery.of(context).size.width),
                    const SizedBox(
                      height: 8,
                    ),
                    ShimmerLoadingWidget(
                        height: 54, width: MediaQuery.of(context).size.width)
                  ] else ...[
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          DataListTopUp dataListTopUp =
                              value.listDataListTopUp![index];

                          for (final item in value.listDataListTopUp!) {
                            final int id = item.id ?? 0;

                            final double price =
                                double.parse(item.price ?? "0");

                            if (id == 3) {
                              lowestPrice = price;
                            } else if (id == 2) {
                              highestPrice = price;
                            }
                          }

                          // Mengecek apakah ada item dengan id 2 atau 3
                          hasId2 = value.listDataListTopUp!
                              .any((item) => item.id == 2);
                          hasId3 = value.listDataListTopUp!
                              .any((item) => item.id == 3);

                          if (dataListTopUp.id == 2 ||
                              dataListTopUp.id == 3 ||
                              (dataListTopUp.id == 1 && (hasId2 && hasId3))) {
                            return MaterialButton(
                              elevation: 0,
                              height: 54,
                              minWidth: MediaQuery.of(context).size.width,
                              textColor: greyColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      width: 1,
                                      color: selected == index
                                          ? primaryColor
                                          : greyColor)),
                              onPressed: dataListTopUp.status == "AKTIF"
                                  ? () {
                                      if (dataListTopUp.id == 1) {
                                        setState(() {
                                          islainnya = true;
                                        });

                                        amountController.clear();
                                      } else {
                                        setState(() {
                                          islainnya = false;
                                        });
                                        amountController.clear();
                                        amountController.text = (double.parse(
                                                dataListTopUp.price ?? "0"))
                                            .toString();
                                      }
                                      selected = index;

                                      setState(() {
                                        dataListTopUpCheckout = dataListTopUp;
                                      });
                                    }
                                  : null,
                              color: dataListTopUp.status != "AKTIF"
                                  ? greyColor
                                  : selected == index
                                      ? primaryColor.withOpacity(0.2)
                                      : whiteColor,
                              child: Text(
                                value.listDataListTopUp?[index].name ?? "",
                                style: TextStyle(color: greyColor),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: value.listDataListTopUp?.length ?? 0),
                    const SizedBox(
                      height: 8,
                    ),
                    islainnya == true
                        ? TextFormField(
                            validator: (val) {
                              return validateInput(val);
                            },
                            controller: amountController,
                            onChanged: (val) {
                              setState(() {
                                double enteredValue =
                                    double.tryParse(val) ?? 0.0;

                                int moduloResult = enteredValue ~/ lowestPrice;

                                if (moduloResult != 0) {
                                  dataListTopUpCheckout?.qty =
                                      moduloResult.toString();
                                }
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: S.of(context).manual_input,
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w300),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: greyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: greyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (amountController.text.isNotEmpty) ...[
                      if (hasId2 && hasId3) ...[
                        if (double.tryParse(amountController.text)! %
                                lowestPrice ==
                            0) ...[
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "${S.of(context).the_amount_of_money_that_will_be_paid} ${S.of(context).is_adalah} ",
                                    style: TextStyle(
                                        color: greyColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                  text: '${MoneyFormatter.formatMoney(
                                    amountController.text,
                                    true,
                                  )} ',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          )
                        ] else ...[
                          Text(
                            "${S.of(context).the_minimum_amount_that_must_be(
                                  MoneyFormatter.formatMoney(
                                    lowestPrice,
                                    true,
                                  ).toString(),
                                )} ${S.of(context).paid_and_the_maximum_amount(MoneyFormatter.formatMoney(
                                  highestPrice,
                                  true,
                                ).toString())} ${S.of(context).if_it_is_less_than_maximum_amount_and_more_than_minimum_amount}",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ]
                      ],
                      if (hasId2 && !hasId3) ...[
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "${S.of(context).the_amount_of_money_that_will_be_paid} ${S.of(context).is_adalah} ",
                                  style: TextStyle(
                                      color: greyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                text: '${MoneyFormatter.formatMoney(
                                  amountController.text,
                                  true,
                                )} ',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                      if (!hasId2 && hasId3) ...[
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "${S.of(context).the_amount_of_money_that_will_be_paid} ${S.of(context).is_adalah} ",
                                  style: TextStyle(
                                      color: greyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                text: '${MoneyFormatter.formatMoney(
                                  amountController.text,
                                  true,
                                )} ',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ]
                    ],
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 54,
                      child: value.isCreatePayment
                          ? CircularProgressWidget(
                              color: primaryColor,
                            )
                          : ButtonPrimary(
                              S.of(context).next,
                              expand: true,
                              radius: 10,
                              onPress: () {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    dataCheckoutTransaction =
                                        DataCheckoutTransaction(
                                            price: Decimal.parse(
                                              amountController.text,
                                            ),
                                            idItemPayments:
                                                dataListTopUpCheckout
                                                    ?.idItemPayments,
                                            qty: int.parse(
                                                dataListTopUpCheckout?.qty ??
                                                    "0"),
                                            transactionType: "Topup Deposit",
                                            discount:
                                                dataListTopUpCheckout?.discount,
                                            gateway: dataGlobal.isIndonesia
                                                ? 'midrans'
                                                : "paypal");
                                  });
                                  value.createTopupTransaction(
                                      context, dataCheckoutTransaction);
                                }
                              },
                            ),
                    )
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
