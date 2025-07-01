import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/provider/provider_transaksi_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/transakction/component/currency_input_formatter.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TopupSaldoPage extends StatefulWidget {
  const TopupSaldoPage({super.key});

  @override
  State<TopupSaldoPage> createState() => _TopupSaldoPageState();
}

class _TopupSaldoPageState extends State<TopupSaldoPage> {
  TextEditingController controllerAmount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, String> source = {
    "Real Money": "real_money",
    S.current.other_pay: "other_pay"
  };
  static const _locale = 'ID';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  bool isIndonesia = true;

  @override
  void initState() {
    isIndonesia = context.read<ProviderUser>().isIndonesia();
    super.initState();
    Future.microtask(() {
      Provider.of<ProviderTransaksiAffiliate>(context, listen: false)
          .getAffiliateManagement(context);
    });
  }


  Future<void> setCurrency(double amount) async {
    context
        .read<ProviderTransaksiAffiliate>()
        .getConvertCurrency(context, amount);
  }

  @override
  void dispose() {
    controllerAmount.dispose();
    super.dispose();
  }

// Selected value (initially null)
  String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).top_up,
          style: TextStyle(color: whiteColor),
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
      ),
      body: Consumer<ProviderTransaksiAffiliate>(builder: (context, state, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomInputField(
                  title: S.of(context).topup_amount,
                  textEditingController: controllerAmount,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return S.of(context).cannot_be_empty;
                    }
                    if (val.isNotEmpty) {
                      int amaount =
                          int.parse(controllerAmount.text.replaceAll(".", ""));

                      if (isIndonesia) {
                        if (amaount < state.minTopup) {
                          return "${S.of(context).min_deposit} ${MoneyFormatter.cconvertCurrency(state.minTopup, true)}";
                        }
                        if (amaount > state.maxTopup) {
                          return "${S.of(context).max_deposit} ${MoneyFormatter.cconvertCurrency(state.maxTopup, true)}";
                        }
                      } else {
                        if (amaount < state.minTopupInt) {
                          return "${S.of(context).min_deposit} ${MoneyFormatter.cconvertCurrency(state.minTopupInt, true)}";
                        }
                        if (amaount > state.maxTopupInt) {
                          return "${S.of(context).max_deposit} ${MoneyFormatter.cconvertCurrency(state.maxTopupInt, true)}";
                        }
                      }
                    }

                    return null;
                  },
                  inputFormatter: [CurrencyInputFormatter()],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(S.of(context).source)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField<String>(
                      value: _selectedValue,
                      validator: (value) =>
                          value == null ? S.of(context).cannot_be_empty : null,
                      onChanged: (String? newValue) {
                        debugPrint(
                            "cek set currentcy ${controllerAmount.text}");
                        final double? numericAmount = safeStringToDouble(
                            controllerAmount.text.toString());
                        setCurrency(numericAmount!);
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items: source.entries.map<DropdownMenuItem<String>>(
                          (MapEntry<String, String> option) {
                        return DropdownMenuItem<String>(
                          value: option.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(option.key),
                            ],
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: S.of(context).select_source,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: whiteColor),
                            borderRadius: BorderRadius.circular(
                                10) // Set the border color here
                            ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                          ),
                        ),
                        fillColor: Colors.grey.withOpacity(0.2),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 54,
                      child: state.isTransactionTopupDeposit
                          ? const CircularProgressWidget()
                          : ButtonPrimary(
                              S.of(context).confirmation,
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  debugPrint("cek apa ini? $_selectedValue");
                                  state.transactionTopupDeposit(
                                      context,
                                      dataGlobal.dataUser?.id.toString() ?? "",
                                      controllerAmount.text.replaceAll(".", ""),
                                      _selectedValue ?? "other_pay",
                                      "topup","false");
                                }
                              },
                              expand: true,
                              elevation: 0.0,
                              radius: 10.0,
                            )),
                ],
              ),
            ]),
          ),
        );
      }),
    );
  }

  double? safeStringToDouble(String input) {
    try {
      // Hapus pemisah ribuan (misalnya titik untuk ribuan)
      String cleanedInput = input.replaceAll(RegExp(r'[,.]'), '');

      // Konversi ke double
      final double result = double.parse(cleanedInput);
      return result;
    } catch (e) {
      // Log atau tangani kesalahan jika diperlukan
      print("Failed to parse '$input' to double: $e");
      return null; // Kembalikan null atau nilai default jika parsing gagal
    }
  }
}
