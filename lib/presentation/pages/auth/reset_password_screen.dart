import 'package:cool_app/data/provider/provider_auth.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isHide = true, isHide2 = true;

  onHide() {
    isHide = !isHide;
    setState(() {});
  }

  onHide2() {
    isHide2 = !isHide2;
    setState(() {});
  }

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  // TextEditingController phoneNumber = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    // phoneNumber.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAuth>(
      builder: (context, state, child) {
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                S.of(context).create_password,
                style: const TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: primaryColor,
            ),
            backgroundColor: primaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      S.of(context).create_new_password,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: isHide,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return S.of(context).min_8_characters;
                      }
                      return null;
                    },
                    style: TextStyle(color: whiteColor),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: S.of(context).password,
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: GestureDetector(
                        onTap: onHide,
                        child: Icon(
                          isHide ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(
                              10) // Set the border color here
                          ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    style: TextStyle(color: whiteColor),
                    controller: confirmPassword,
                    obscureText: isHide2,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return S.of(context).cannot_be_empty;
                      } else if (value != password.text) {
                        return S.of(context).not_match;
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: onHide2,
                        child: Icon(
                          isHide2 ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                      hintText: S.of(context).repeat_password,
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(
                              10) // Set the border color here
                          ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        state.resetPassword(
                          context,
                          password.text,
                          confirmPassword.text,
                        );
                      }
                    },
                    color: Colors.white,
                    textColor: primaryColor,
                    height: 54,
                    elevation: 0,
                    child: Text(S.of(context).save),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
