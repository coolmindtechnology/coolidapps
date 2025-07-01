import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding/on_boarding_isi_foto.dart';
import 'package:coolappflutter/presentation/on_boarding/onboarding_isi_email.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingKtp extends StatelessWidget {
  final TextEditingController KtpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderUser>(builder: (context, providerUser, child) {
    return Scaffold(
      body: SingleChildScrollView(
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
          child: Form(
            key: _formKey,
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
                        'images/ktpimage.png', // Ganti dengan path gambar kamu
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
                  const SizedBox(height: 8),
                   Text(
                    S.of(context).isi_ktp,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: providerUser.idCardController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor KTP tidak boleh kosong';
                      }
                      // Bisa tambahkan validasi panjang/format KTP di sini jika perlu
                      return null;
                    },
                  ),
                  const SizedBox(height: 60),
                  providerUser.isLoadingUpdateUser ? Center(child: CircularProgressIndicator(color: primaryColor,)) : GlobalButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // validasi berhasil, lanjut eksekusi
                        await providerUser.updateUser(context,'identitas');
                      } else {
                        // validasi gagal, form menampilkan error
                      }
                    },
                    color: primaryColor,
                    text: S.of(context).next,
                  ),
                  gapH10,
                  providerUser.isLoadingUpdateUser ? Center(child: CircularProgressIndicator(color: primaryColor,)) : GlobalButton(
                    onPressed: () {
                      Nav.to(FotoPage());
                    },
                    color: Colors.white,
                    text: S.of(context).nantiSaja,
                    textStyle: TextStyle(color: primaryColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
  }
}
