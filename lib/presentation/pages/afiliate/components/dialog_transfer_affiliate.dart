import 'package:coolappflutter/data/provider/provider_transaksi_affiliate.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';

import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogTransferAffiliate extends StatefulWidget {
  const DialogTransferAffiliate({
    super.key,
    this.calculateSaldo,
    this.bankName,
  });
  final String? calculateSaldo;
  final String? bankName;

  @override
  State<DialogTransferAffiliate> createState() =>
      _DialogTransferAffiliateState();
}

class _DialogTransferAffiliateState extends State<DialogTransferAffiliate> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Text(S.of(context).process),
        content: SingleChildScrollView(
          child: Column(
            children: [
              CustomInputField(
                  title: S.of(context).total,
                  isReadOnly: true,
                  hintText:
                      MoneyFormatter.formatMoney(widget.calculateSaldo, true)),
              const SizedBox(
                height: 16,
              ),
              // CustomInputField(
              //   title: S.of(context).bank_name,
              //   isReadOnly: true,
              //   hintText: widget.bankName,
              // )
            ],
          ),
        ),
        actions: [
          SizedBox(
            height: 48,
            child: ButtonPrimary(
              S.of(context).pindahkan_saldo,
              onPress: () {
                context
                    .read<ProviderTransaksiAffiliate>()
                    .createTransactionLastWithdraw(context);
              },
              elevation: 0.0,
              expand: true,
              radius: 10.0,
            ),
          )
        ],
      ),
    );
  }
}
