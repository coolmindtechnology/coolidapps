import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
import 'package:coolappflutter/data/provider/provider_payment.dart';
import 'package:coolappflutter/data/response/payments/res_get_data_top_up.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  int defaultKelipatan = 0;
  bool isCustomInput = false;


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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var provider = Provider.of<ProviderPayment>(context, listen: false);
      if (provider.listDataListTopUp != null && provider.listDataListTopUp!.length >= 3) {
        try {
          double parsedPrice = double.parse(provider.listDataListTopUp![2].price ?? "0");
          if (mounted) {
            setState(() {
              defaultKelipatan = parsedPrice.toInt(); // Konversi ke int
            });
          }
        } catch (e) {
          print("Error parsing price: $e");
        }
      }
    });
  }



  String removeLastDigit(String value) {
    if (value.isNotEmpty) {
      // Hapus karakter terakhir
      value = value.substring(0, value.length - 1);

      // Jika karakter terakhir setelah pemotongan adalah titik, hapus juga
      if (value.endsWith(".")) {
        value = value.substring(0, value.length - 1);
      }
    }
    return value; // Kembalikan string hasil perubahan
  }

  int count = 1; // Mulai dari 1 paket


  void _increment() {
    setState(() {
      count++;
    });
  }

  void _decrement() {
    if (count > 1) {
      setState(() {
        count--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderPayment>(builder: (context, value, child) {
      String getPrice(DataListTopUp? data, bool isIndonesia) {
        if (data == null) return 'N/A';

        // Pastikan harga dalam format angka, lalu format dengan pemisah ribuan
        double? priceValue = double.tryParse(
            (isIndonesia ? data.price : data.intlPrice).toString()
        );
        if (priceValue == null) return 'N/A';

        return NumberFormat("#,###", "id_ID").format(priceValue);
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset("images/buku/arrowleft.png")),
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          backgroundColor: primaryColor,
          centerTitle: false,
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
                        if (value.listDataListTopUp == null || value.listDataListTopUp!.isEmpty) {
                          return Center(child: Text("Data tidak tersedia"));
                        }

                        // Filter data: Hapus item dengan id == 3
                        List<DataListTopUp> filteredList = value.listDataListTopUp!
                            .where((item) => item.id != 1)
                            .toList()
                            .reversed
                            .toList();

                        if (index >= filteredList.length) return SizedBox();

                        DataListTopUp dataListTopUp = filteredList[index];

                        return GestureDetector(
                          onTap: dataListTopUp.status == "AKTIF"
                              ? () {
                            setState(() {
                              islainnya = dataListTopUp.id == 1;
                              amountController.clear();
                              if (!islainnya) {
                                amountController.text = dataListTopUp.price.toString();
                              }
                              selected = index;
                              dataListTopUpCheckout = dataListTopUp;
                            });

                            // **Jalankan fungsi onPress**
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                dataCheckoutTransaction = DataCheckoutTransaction(
                                  price: Decimal.parse(amountController.text),
                                  idItemPayments: dataListTopUpCheckout?.idItemPayments.toString(),
                                  qty: int.parse(dataListTopUpCheckout?.qty.toString() ?? "0"),
                                  transactionType: "Topup Deposit",
                                  discount: dataListTopUpCheckout?.discount.toString(),
                                  gateway: dataGlobal.isIndonesia ? 'midrans' : "paypal",
                                );
                              });

                              // **Proses transaksi**
                              value.createTopupTransaction(context, dataCheckoutTransaction);
                            }
                          }
                              : null,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(22, 15, 22, 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: index == 0
                                  ? LinearGradient(
                                colors: [Color(0xFF44BBFE), Color(0xFF1E78FE)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                                  : LinearGradient(
                                colors: [Color(0xFFFFCF53), Color(0xFFFF9900)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'images/head-w.png',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dataListTopUp.name ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      getPrice(dataListTopUp, dataGlobal.isIndonesia),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemCount: value.listDataListTopUp == null
                          ? 0
                          : value.listDataListTopUp!.where((item) => item.id != 3).length,
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
                    gapH24,
                    Container(
                      width: 360,
                      height: 138,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFDBFEFD),
                        borderRadius: BorderRadius.circular(
                            8), // Tambahkan radius untuk tampilan lebih halus
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Judul Paket
                          Text(
                            "Paket Custom",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          // Deskripsi Harga
                          Text(
                            '*Kelipatan ${MoneyFormatter.formatMoney(defaultKelipatan.toString(), true)} ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),

                          SizedBox(height: 12),

                          // Box Counter
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Tombol Minus
                                IconButton(
                                  icon: Icon(Icons.remove, color: Colors.red),
                                  onPressed: _decrement,
                                ),

                                // Harga di tengah
                                Text(
                                  "${MoneyFormatter.formatMoney("${count * defaultKelipatan}", false)} ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                                // Tombol Plus
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.green),
                                  onPressed: _increment,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    gapH24,
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
                          int totalPrice = count * defaultKelipatan;
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              // Ambil teks dari controller
                              String amountText = totalPrice.toString();

                              // Pastikan input hanya angka
                              if (amountText.isEmpty || int.tryParse(amountText) == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Masukkan jumlah yang valid")),
                                );
                                return;
                              }

                              // Tentukan apakah input manual
                              isCustomInput = dataListTopUpCheckout == null;

                              // Gunakan harga sesuai kelipatan dari defaultKelipatan
                              Decimal priceToSend = Decimal.parse(amountText);

                              // Jika input manual, kalikan dengan defaultKelipatan
                              if (isCustomInput) {
                                priceToSend = Decimal.parse((totalPrice.toString()).toString());
                              }

                              dataCheckoutTransaction = DataCheckoutTransaction(
                                price: priceToSend,
                                idItemPayments: dataListTopUpCheckout?.idItemPayments.toString(),
                                qty: int.parse(dataListTopUpCheckout?.qty.toString() ?? "1"),
                                transactionType: "Topup Deposit",
                                discount: dataListTopUpCheckout?.discount.toString(),
                                gateway: dataGlobal.isIndonesia ? 'midrans' : "paypal",
                              );
                            });

                            value.createTopupTransaction(context, dataCheckoutTransaction);
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
