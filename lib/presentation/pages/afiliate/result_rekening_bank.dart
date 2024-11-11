import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_bank_account.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../theme/color_utils.dart';

class ResultRekeningBank extends StatefulWidget {
  final Function? onUpdate;
  final ResBankAccount? bankName;

  const ResultRekeningBank({super.key, this.bankName, this.onUpdate});

  @override
  State<ResultRekeningBank> createState() => _ResultRekeningBankState();
}

class _ResultRekeningBankState extends State<ResultRekeningBank> {
  final keyForm = GlobalKey<FormState>();
  TextEditingController nameBankC = TextEditingController();
  TextEditingController noRekC = TextEditingController();
  TextEditingController namaC = TextEditingController();

  // BankAccount? bankAccount;
  @override
  void initState() {
    // bankAccount = widget.bankName?.data;
    // context.read<ProviderAffiliate>().nameBank =
    //     TextEditingController(text: widget.bankName?.data?.bankName ?? "-");
    // context.read<ProviderAffiliate>().noRek =
    //     TextEditingController(text: bankAccount?.accountNo);
    // context.read<ProviderAffiliate>().nama =
    //     TextEditingController(text: bankAccount?.accountName ?? "-");
    nameBankC =
        TextEditingController(text: widget.bankName?.data?.bankName ?? "-");
    noRekC =
        TextEditingController(text: widget.bankName?.data?.accountNo ?? "-");
    namaC =
        TextEditingController(text: widget.bankName?.data?.accountName ?? "-");
    super.initState();
  }

  @override
  void dispose() {
    nameBankC.dispose();
    noRekC.dispose();
    namaC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAffiliate>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).bank_account,
            style: TextStyle(color: whiteColor),
          ),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    S.of(context).bank_name,
                    style: TextStyle(
                        fontSize: 12, color: greyColor.withOpacity(0.3)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: nameBankC,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (validator) {
                      if (validator!.isEmpty) {
                        return S.of(context).cannot_be_empty;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    S.of(context).account_number,
                    style: TextStyle(
                        fontSize: 12, color: greyColor.withOpacity(0.3)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: noRekC,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (validator) {
                      if (validator!.isEmpty) {
                        return S.of(context).cannot_be_empty;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    S.of(context).name,
                    style: TextStyle(
                        fontSize: 12, color: greyColor.withOpacity(0.3)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: namaC,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (validator) {
                      if (validator!.isEmpty) {
                        return S.of(context).cannot_be_empty;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    S.of(context).save_agreement,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  value.isSaveRek == true
                      ? CircularProgressWidget(
                          color: primaryColor,
                        )
                      : MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: primaryColor,
                          textColor: whiteColor,
                          height: 54,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            if (keyForm.currentState?.validate() == true) {
                              await value.saveRek(context, nameBankC.text,
                                  noRekC.text, namaC.text, onUpdate: () {
                                widget.onUpdate!();
                              });
                            }
                          },
                          child: Text(S.of(context).save),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
