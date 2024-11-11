import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool isHide = true, isHide2 = true, isHide3 = true;

  onHide3() {
    isHide3 = !isHide3;
    setState(() {});
  }

  onHide() {
    isHide = !isHide;
    setState(() {});
  }

  onHide2() {
    isHide2 = !isHide2;
    setState(() {});
  }

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.of(context).change_password,
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                textEditingController: oldPassword,
                title: S.of(context).current_password,
                obscureText: isHide3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                obsecureTextHint: "*",
                hintText: "********",
                suffixIcon: GestureDetector(
                  onTap: onHide3,
                  child: Icon(
                    isHide3 ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return S.of(context).min_8_characters;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              CustomInputField(
                textEditingController: newpassword,
                title: S.of(context).password,
                obscureText: isHide,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                obsecureTextHint: "*",
                hintText: "********",
                suffixIcon: GestureDetector(
                  onTap: onHide,
                  child: Icon(
                    isHide ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return S.of(context).min_8_characters;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              CustomInputField(
                textEditingController: confirmPassword,
                title: S.of(context).password_confirmation,
                obscureText: isHide2,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obsecureTextHint: "*",
                hintText: "********",
                suffixIcon: GestureDetector(
                  onTap: onHide2,
                  child: Icon(
                    isHide2 ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return S.of(context).cannot_be_empty;
                  } else if (value != newpassword.text) {
                    return S.of(context).not_match;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                  height: 54,
                  child: Provider.of<ProviderAuth>(
                    context,
                  ).isLoading
                      ? const CircularProgressWidget()
                      : ButtonPrimary(
                          S.of(context).save,
                          expand: true,
                          onPress: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Provider.of<ProviderAuth>(context, listen: false)
                                  .updatePassword(context, oldPassword.text,
                                      newpassword.text, confirmPassword.text);
                            }
                          },
                          radius: 10,
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
