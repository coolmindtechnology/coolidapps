import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding/on_boarding_isi_ktp.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingEmailPage extends StatelessWidget {
  final String phoneNumber;
  final String coderef;
  OnBoardingEmailPage({super.key, required this.phoneNumber, required this.coderef});

  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, Colors.white], // Gradasi biru ke putih
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'images/email_image.png', // Ganti dengan path gambar kamu
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                     Text(
                      S.of(context).isiIdentitas,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                     Text(
                      S.of(context).email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: S.of(context).Email_Input,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return S.of(context).cannot_be_empty;
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Format email tidak valid'; // bisa disesuaikan pesan errornya
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 60),
                    Consumer<ProviderAuth>(
                      builder: (context, authProvider, child) {
                        return authProvider.isLoadingCredential ? Center(child: CircularProgressIndicator(color: primaryColor,)) :GlobalButton(
                          color: primaryColor,
                          text: S.of(context).next,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authProvider.cekCredential(
                                context: context,
                                phoneNumber: phoneNumber,
                                email: emailController.text,
                                navigasi: 'email',
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
