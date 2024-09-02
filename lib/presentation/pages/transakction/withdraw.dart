import 'package:cool_app/data/provider/provider_transaksi_affiliate.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/transakction/component/currency_input_formatter.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:cool_app/presentation/utils/money_formatter.dart';
import 'package:cool_app/presentation/widgets/button_primary.dart';
import 'package:cool_app/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  TextEditingController controllerAmount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<ProviderTransaksiAffiliate>()
        .getAffiliateManagement(context));
  }

  @override
  void dispose() {
    controllerAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).withdrawal,
          style: TextStyle(color: whiteColor),
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
      ),
      body: Consumer<ProviderTransaksiAffiliate>(builder: (context, state, _) {
        if (state.isGetAffiliateManagement) {
          return const CircularProgressWidget();
        } else {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                    title: S.of(context).withdrawal_amount,
                    textEditingController: controllerAmount,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S.of(context).cannot_be_empty;
                      }
                      if (val.isNotEmpty) {
                        int amaount = int.parse(
                            controllerAmount.text.replaceAll(".", ""));

                        if (amaount < state.minWithdraw) {
                          return "${S.of(context).min_withdrawal} ${MoneyFormatter.formatMoney(state.minWithdraw, true)}";
                        }
                        if (amaount > state.maxWithdraw) {
                          return "${S.of(context).max_withdrawal} ${MoneyFormatter.formatMoney(state.maxWithdraw, true)}";
                        }
                      }

                      return null;
                    },
                    inputFormatter: [CurrencyInputFormatter()],
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\u2022 ${S.of(context).min_withdrawal} ${MoneyFormatter.formatMoney(state.minWithdraw, true)}",
                        style: TextStyle(color: greyColor),
                      ),
                      Text(
                        "\u2022 ${S.of(context).max_withdrawal} ${MoneyFormatter.formatMoney(state.maxWithdraw, true)}",
                        style: TextStyle(color: greyColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 60,
                    child: state.isCreateWithdraw
                        ? const CircularProgressWidget()
                        : ButtonPrimary(
                            S.of(context).confirmation,
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                state.createWithdraw(
                                  context,
                                  controllerAmount.text.replaceAll(".", ""),
                                );
                              }
                            },
                            expand: true,
                            elevation: 0.0,
                            radius: 10,
                          ),
                  )
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
