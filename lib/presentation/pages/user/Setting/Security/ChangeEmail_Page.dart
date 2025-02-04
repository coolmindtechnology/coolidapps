import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Security/OTP_ChangeEmail.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  @override
  void initState() {
    super.initState();
    // Provider.of<ProviderUser>(context, listen: false).setInitialValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderUser>(builder: (context, providerUser, child) {
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, Colors.white], // Gradasi biru ke putih
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.asset(
                      'images/email_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  S.of(context).Old_Email,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  enabled: false,
                  controller: providerUser.emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (validator) {
                    if (validator!.isEmpty) {
                      return S.of(context).cannot_be_empty;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  S.of(context).New_Email_Input,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GlobalButton(
                  onPressed: () {
                    Nav.to(OtpChangeEmail());
                  },
                  color: primaryColor,
                  text: S.of(context).Change_Email,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
