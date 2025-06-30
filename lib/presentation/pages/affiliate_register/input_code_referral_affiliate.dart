import 'dart:async';

import 'package:coolappflutter/data/provider/provider_auth_affiliate.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/locals/preference_handler.dart';

class InputCodeReferralAffiliate extends StatefulWidget {
  const InputCodeReferralAffiliate({super.key});

  @override
  State<InputCodeReferralAffiliate> createState() =>
      _InputCodeReferralAffiliateState();
}

class _InputCodeReferralAffiliateState
    extends State<InputCodeReferralAffiliate> {
  TextEditingController controllerCodeReferral = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void initState() {
    // initAutofill();
    // Timer(const Duration(seconds: 3), () {
    //   debugPrint("Masuk Timer");

    //   initAutofill();
    // });
    super.initState();
  }

  initAutofill() async {
    dynamic iduser = await PreferenceHandler.retrieveIdUser();

    await context
        .read<ProviderAuthAffiliate>()
        .autofill(iduser.toString(), context);
    Timer(const Duration(seconds: 1), () async {
      context.read<ProviderAuthAffiliate>().dataCodeReferal.toString();
      if (context.read<ProviderAuthAffiliate>().dataCodeReferal.toString() !=
          "null") {
        controllerCodeReferral.text =
            context.read<ProviderAuthAffiliate>().dataCodeReferal.toString();

      } else {
        controllerCodeReferral.text = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).register_affiliate,
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: Consumer<ProviderAuthAffiliate>(builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Form(
            key: _form,
            child: Column(
              children: [
                CustomInputField(
                  isReadOnly: false, // selalu bisa diisi
                  title: S.of(context).enter_referral_code,
                  textEditingController: controllerCodeReferral,
                  textInputAction: TextInputAction.done,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return S.of(context).cannot_be_empty;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 54,
                  child: value.isRegisterAffiliate
                      ? const CircularProgressWidget()
                      : ButtonPrimary(
                          S.of(context).register,
                          onPress: value.isRegisterAffiliate
                              ? () {}
                              : () {
                                  debugPrint("testing");
                                  if (_form.currentState?.validate() ?? false) {
                                    context
                                        .read<ProviderAuthAffiliate>()
                                        .registerAffiliate(context,
                                            controllerCodeReferral.text);
                                  }
                                },
                          expand: true,
                          elevation: 0,
                          radius: 10,
                        ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
