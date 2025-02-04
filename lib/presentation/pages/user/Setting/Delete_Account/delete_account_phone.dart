// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Delete_Account/OTP_Delete.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Delete_Account/delete_account_email.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class DeletedPhone extends StatefulWidget {
  const DeletedPhone({super.key});

  @override
  State<DeletedPhone> createState() => _DeletedPhoneState();
}

class _DeletedPhoneState extends State<DeletedPhone> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderUser>(builder: (context, providerUser, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            S.of(context).Delete_Account,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('images/Account_Delete.png')),
              const SizedBox(
                height: 30,
              ),
              Text(
                S.of(context).Confirm_Your_Identity,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).Please_Provide_Email_Phone,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(children: [
                Expanded(
                  child: IntlPhoneField(
                    readOnly: false,
                    enabled: true,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(fontFamily: "Poppins"),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    initialCountryCode: providerUser.initialCodeCountry,
                    style: const TextStyle(fontFamily: "Poppins"),
                    dropdownTextStyle: const TextStyle(fontFamily: "Poppins"),
                    disableLengthCheck: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: providerUser.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Nav.to(DeletedEmail());
                  },
                  child: Text(S.of(context).Use_Email)),
              Spacer(),
              GlobalButton(
                onPressed: () {
                  Nav.toAll(OtpDelete());
                },
                color: Colors.red,
                text: S.of(context).Send_Verification_Code,
              )
            ],
          ),
        ),
      );
    });
  }
}
