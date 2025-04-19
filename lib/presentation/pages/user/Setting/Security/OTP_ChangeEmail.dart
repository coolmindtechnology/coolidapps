import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Security/Security_Page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class OtpChangeEmail extends StatefulWidget {
  const OtpChangeEmail({super.key});

  @override
  State<OtpChangeEmail> createState() => _OtpChangeEmailState();
}

class _OtpChangeEmailState extends State<OtpChangeEmail> {
  final List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  final String dummyOtp = "1234"; // Dummy OTP
  bool isVerified = false; // Status verifikasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              Colors.white,
            ],
            stops: [0.1, 0.35],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text(
                "Enter OTP Code",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
              ),
              const SizedBox(height: 10),
              Text(
                "Verification Code has been sent to your email.",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Not You?",
                    style: const TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      // Tambahkan logika untuk mengganti email
                    },
                    child: const Text(
                      "Change Email",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                      (index) => SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _otpControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                      decoration: const InputDecoration(
                          filled: true, // Aktifkan warna latar belakang
                          fillColor: Color(0xff68CDF1), // Warna latar belakang biru
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          )
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              isVerified
                  ? const Center(
                child: Text(
                  "Sukses!!!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff68CDF1),
                  ),
                ),
              )
                  :
              Padding(
                padding: const EdgeInsets.only(top: 400),
                child: GlobalButton(
                  onPressed: () {
                    for (int i = 0; i < _otpControllers.length; i++) {
                      _otpControllers[i].text = dummyOtp[i];
                    }

                    setState(() {
                      isVerified = true; // Ubah status menjadi terverifikasi
                    });

                    // Tunda navigasi ke halaman berikutnya
                    Future.delayed(const Duration(seconds: 3), () {
                      Nav.toAll(NavMenuScreen());
                    });
                  },
                  color: primaryColor,
                  text:  S.of(context).Verification_Code,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
