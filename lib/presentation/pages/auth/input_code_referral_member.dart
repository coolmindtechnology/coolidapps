import 'package:cool_app/data/provider/provider_auth_affiliate.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:cool_app/presentation/widgets/button_primary.dart';
import 'package:cool_app/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputCodeReferralMember extends StatefulWidget {
  const InputCodeReferralMember({super.key});

  @override
  State<InputCodeReferralMember> createState() =>
      _InputCodeReferralMemberState();
}

class _InputCodeReferralMemberState extends State<InputCodeReferralMember> {
  TextEditingController controllerCodeReferral = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void dispose() {
    controllerCodeReferral.dispose();
    super.dispose();
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
