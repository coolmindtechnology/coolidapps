// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/provider_adress.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/data/repositories/authentication.dart';
import 'package:coolappflutter/data/response/auth/res_check_credential.dart';
import 'package:coolappflutter/data/response/auth/res_get_otp.dart';
import 'package:coolappflutter/data/response/auth/res_logout.dart';
import 'package:coolappflutter/data/response/auth/res_resend_otp.dart';
import 'package:coolappflutter/data/response/auth/res_reset_password.dart';
import 'package:coolappflutter/data/response/auth/res_send_otp.dart';
import 'package:coolappflutter/data/response/auth/res_update_password.dart';
import 'package:coolappflutter/data/response/auth/res_verify_otp.dart';
import 'package:coolappflutter/data/response/auth/res_login.dart';
import 'package:coolappflutter/data/response/auth/res_register.dart';
import 'package:coolappflutter/data/response/user/res_get_location_member.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding/on_boarding_isi_ktp.dart';
import 'package:coolappflutter/presentation/on_boarding/on_boarding_location.dart';
import 'package:coolappflutter/presentation/on_boarding/onboarding_isi_email.dart';
import 'package:coolappflutter/presentation/on_boarding/onboarding_isi_identitas.dart';
import 'package:coolappflutter/presentation/pages/auth/component/alert_dialog_otp.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/pages/auth/reset_password_screen.dart';
import 'package:coolappflutter/presentation/pages/main/pre_home_screen.dart';
import 'package:coolappflutter/presentation/pages/otp/forgot_password_screen.dart';
import 'package:coolappflutter/presentation/pages/otp/otp_screen.dart';
import 'package:coolappflutter/presentation/utils/get_country.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../presentation/pages/main/components/input_code_ref_profilling.dart';

class ProviderAuth extends ChangeNotifier {
  ProviderAuth() {
    assert(() {
      // phoneNumber.text = "1122334455";
      // password.text = "Cool123?";

      //
      //   phoneNumberReg.text = "1234567890";
      //   passwordReg.text = "123123123";
      //   confirmPasswordReg.text = "123123123";
      return true;
    }());
  }

  Authentication auth = Authentication();
  bool isHide = true, isHide2 = true;

  onHide() {
    isHide = !isHide;
    notifyListeners();
  }

  onHide2() {
    isHide2 = !isHide2;
    notifyListeners();
  }

  bool isLogin = false;

  //register

  TextEditingController passwordReg = TextEditingController();
  TextEditingController confirmPasswordReg = TextEditingController();

  DataRegister? dataRegister;

  //otp
  DataOtp? dataOtp;
  // TextEditingController otpController = TextEditingController();

  //data send otp forgot password
  DataSendOtp? dataSendOtp;
  // TextEditingController numberForgot = TextEditingController();

  Timer? _timer;
  int _countdownSeconds = 0;
  final DateTime _otpTime = DateTime.now();

  int get countdownSeconds => _countdownSeconds;

  int _calculateCountdownSeconds() {
    DateTime now = DateTime.now();
    Duration difference = _otpTime.difference(now);
    return difference.inSeconds;
  }

//untuk set otp time dari response otp time
  void setOtpTime({DateTime? otpTime}) {
    // _otpTime = otpTime ?? DateTime.now();
    // _countdownSeconds = _calculateCountdownSeconds();
    _countdownSeconds = 120;
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownSeconds > 0) {
        _countdownSeconds--;
        notifyListeners();
      } else {
        _timer?.cancel(); // Hentikan timer jika sudah mencapai 0
      }
    });
  }

  // Metode untuk menghentikan timer (biasanya dipanggil saat tidak diperlukan lagi)
  void stopTimer() {
    _timer?.cancel();
  }

  // Metode untuk memulai kembali timer dari awal
  void restartTimer() {
    // _countdownSeconds = _calculateCountdownSeconds();
    // notifyListeners();

    stopTimer();
    _startTimer();
  }

  @override
  void dispose() {
    // Hentikan timer saat provider di-dispose
    _timer?.cancel();
    super.dispose();
  }

  //format minute:second
  String get formattedTime {
    int minutes = (_countdownSeconds / 60).floor();
    int seconds = _countdownSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  //navigate to otp screen
  late String _sourceToOtpScreen;

  String get sourceToOtpScreen => _sourceToOtpScreen;

  void setSourceToOtpScreen(String source) {
    _sourceToOtpScreen = source;
    notifyListeners();
  }

  bool isLoading = false;

  Future<void> login(BuildContext context,
      {required String phoneNumber,
      required String password,
      required String fcmToken,
      String? source}) async {
    isLoading = true;
    notifyListeners();

    Either<Failure, ResLogin> response = await auth.login(
        phoneNumber: phoneNumber, password: password, fcmToken: fcmToken);

    isLoading = false;
    notifyListeners();

    response.when(error: (e) {
      // debugPrint("masuk ${e.toString()}");
      // debugPrint("masuk ${jsonEncode(response)}");
      isLoading = false;
      notifyListeners();
      NotificationUtils.showDialogError(
        context,
        () {
          Nav.back();
        },
        widget: Text(
          e.message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }, success: (res) async {
      try {
        // **Coba Login dengan Firebase**
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: res.data?.email.trim() ?? "",
          password: password.trim(),
        );

        debugPrint("Login berhasil: ${credential.user?.email}");
        debugPrint("Login berhasil: ${password.trim()}");
      } on FirebaseAuthException catch (e) {
        NotificationUtils.showDialogError(
          context,
              () {
            Nav.back();
          },
          widget: Text(
            res.message ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
        // **Jika Error 'user-not-found', Buat Akun Baru**
        debugPrint("Login gagal: $e");
        debugPrint("Login gagal: ${res.data?.email.trim()}");
        debugPrint("Login gagal: ${password.trim()}");
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: res.data?.email.trim() ?? "",
          password: password.trim(),
        );

        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            firstName: res.data?.email.toString().substring(0, 3).trim(),
            id: credential.user!.uid,
            imageUrl:
                'https://i.pravatar.cc/300?u=${res.data?.email.toString().substring(0, 2).trim()}',
            lastName: res.data?.email.toString().substring(0, 2).trim(),
          ),
        );
      }

      if (res.success == true) {
        if (res.data?.idRole.toString() == "2") {
          isLoading = false;
          notifyListeners();
          // debugPrint("masukk4");
          if (res.data?.isVerified.toString() == "1") {
            isLoading = false;
            notifyListeners();
            dataGlobal.setToken(res.data?.accessToken.toString() ?? "");
            await Prefs().setToken(res.data?.accessToken.toString());
            await context.read<ProviderBook>().getPreHome(context);
            if(source == 'register'){
              // Nav.toAll(const InputCodeRefPofilling());
              Nav.toAll(IdentityPage());
            }else{
              Nav.toAll(const PreHomeScreen());
            }
          } else {
            isLoading = false;
            notifyListeners();
            // ke otp page
            NotificationUtils.showDialogError(context, () {
              // context.read<ProviderUser>().getUser(context);
              Nav.back();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialogOtp(
                    sms: () {
                      Nav.back();
                      Nav.to(ForgotPasswordScreen(
                        channel: "sms",
                        isVerif: true,
                        number: phoneNumber.toString(),
                      ));
                    },
                    wa: () {
                      Nav.back();
                      Nav.to(ForgotPasswordScreen(
                        channel: 'wa',
                        isVerif: true,
                        number: phoneNumber.toString(),
                      ));
                    },
                    email: () {
                      Nav.back();
                      Nav.to(ForgotPasswordScreen(
                        channel: 'email',
                        isVerif: true,
                        number: phoneNumber.toString(),
                      ));
                    },
                  );
                },
              );
            },
                widget: const Text(
                  "Akun belum terverifikasi, silahkan lakukan verifikasi terlebih dahulu",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                textButton: "Verifikasi Sekarang");
          }
        } else {
          isLoading = false;
          notifyListeners();
          debugPrint("masukk");
          NotificationUtils.showDialogError(
            context,
            () {
              Nav.back();
            },
            widget: Text(
              S.of(context).use_your_user_account,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }
      } else {
        isLoading = false;
        notifyListeners();
        debugPrint("masukkk");
        NotificationUtils.showDialogError(
          context,
          () {
            Nav.back();
          },
          widget: Text(
            res.message ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }
    });

    notifyListeners();
  }

  String removeBrackets(String input) {
    // Menggunakan metode replaceAll untuk mengganti simbol [ dan ] dengan string kosong
    return input.replaceAll('[', '').replaceAll(']', '').replaceAll('null', '');
  }

  // register
  Future<void> register(
      BuildContext context,
      String channel,
      String emailReg,
      String codeReferal,
      String countryId,
      String stateId,
      String cityId,
      String districtId,
      String longitude,
      String latitude,
      String phoneNumberReg
      ) async {
    isLoading = true;
    notifyListeners();

    // Menambahkan timeout pada Future API
    try {
      // Menggunakan timeout secara langsung pada API request
      Either<FailedModel, ResRegister> response = await auth.register(
        phoneNumber: phoneNumberReg.toString(),
        password: passwordReg.text,
        confirmPassword: confirmPasswordReg.text,
        channel: channel,
        email: emailReg,
        codeReferal: codeReferal,
        countryId: countryId,
        stateId: stateId,
        cityId: cityId,
        districtId: districtId,
        latitude: latitude,
        longitude: longitude,
      ).timeout(Duration(seconds: 30), onTimeout: () {
        throw TimeoutException("Request timed out. Please try again.");
      });

      // Menyelesaikan proses setelah mendapatkan hasil dari API
      isLoading = false;
      notifyListeners();

      // Handling response error
      response.when(error: (e) {
        debugPrint("ee $e");
        isLoading = false;
        notifyListeners();
        NotificationUtils.showDialogError(
          context,
              () {
            Nav.back();
          },
          widget: e.message == "Validasi gagal"
              ? Text(
            "${e.errors!.email!.toString() != "" ? removeBrackets(e.errors!.email.toString()) : ""}  ${e.errors!.phoneNumber!.toString() != "" ? removeBrackets(e.errors!.phoneNumber.toString()) : ""} ${e.errors!.password.toString() != "" ? removeBrackets(e.errors!.password.toString()) : ""}  ${e.errors!.passwordConfirmation.toString() != "" ? removeBrackets(e.errors!.passwordConfirmation.toString()) : ""} ${e.errors!.codeReferal.toString() != "" ? removeBrackets(e.errors!.codeReferal.toString()) : ""}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          )
              : Text(removeBrackets(
              '${e.message.toString()}  ${e.errorCode.toString()}')),
        );
      }, success: (res) async {
        await AddressPreferences.saveAddressString(stateId,cityId,districtId);
        // Proses setelah registrasi berhasil
        try {
          // Mendaftar user di Firebase Authentication
          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailReg.trim(),
            password: passwordReg.text.trim(),
          );

          // Menambahkan user ke Firestore menggunakan FirebaseChatCore
          await FirebaseChatCore.instance.createUserInFirestore(
            types.User(
              firstName: emailReg.toString().substring(0, 3).trim(),
              id: credential.user!.uid,
              imageUrl: 'https://i.pravatar.cc/300?u=${emailReg.trim()}',
              lastName: emailReg.toString().substring(0, 2).trim(),
            ),
          );
        } catch (e) {
          debugPrint("Error creating user in Firebase: $e");
        }

        // Mengecek apakah data berhasil terdaftar
        if (res.success == false && res.data == null) {
          NotificationUtils.showDialogError(
            context,
                () {
              Nav.back();
            },
            widget: Text(
              "${res.message}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          );
        } else if (res.data?.errors != null) {
          // Menampilkan error validation jika ada
          NotificationUtils.showDialogError(
            context,
                () {
              Nav.back();
            },
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (res.data?.errors?.phoneNumber != null) ...[
                  ...res.data!.errors!.phoneNumber!.map((value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "•",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
                if (res.data?.errors?.password?.isNotEmpty ?? false) ...[
                  ...res.data!.errors!.password!.map((value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "•",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
                if (res.data?.errors?.passwordConfirmation?.isNotEmpty ?? false) ...[
                  ...res.data!.errors!.passwordConfirmation!.map((value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "•",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
                if (res.data?.errors?.codeReferal?.isNotEmpty ?? false) ...[
                  ...res.data!.errors!.codeReferal!.map((value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "•",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
                if (res.data?.errors?.email?.isNotEmpty ?? false) ...[
                  ...res.data!.errors!.email!.map((value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "•",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ],
            ),
          );
        } else if (res.success == true) {
          // Sukses Registrasi
          dataRegister = res.data;
          sendOtp(
            context,
            dataRegister?.userId.toString() ?? "",
            channel,
            phonenumber: phoneNumberReg.toString(),
            Password: passwordReg.text
          );
        }
      });

    } catch (e) {
      if (e is TimeoutException) {
        // Menampilkan error jika timeout
        NotificationUtils.showDialogError(
          context,
              () {
            Nav.back();
          },
          widget: Text(
            "Request timed out. Please try again.",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      } else {
        debugPrint("Unexpected error: $e");
        NotificationUtils.showDialogError(
          context,
              () {
            Nav.back();
          },
          widget: Text(
            "Gagal Registrasi coba lagi nanti",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }
      isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> register(
  //     BuildContext context,
  //     String channel,
  //     String emailReg,
  //     String codeReferal,
  //     String countryId,
  //     String stateId,
  //     String cityId,
  //     String districtId,
  //     String longitude,
  //     String latitude,
  //     String phoneNumberReg) async {
  //   isLoading = true;
  //   notifyListeners();
  //
  //   Either<FailedModel, ResRegister> response = await auth.register(
  //       phoneNumber: phoneNumberReg.toString(),
  //       password: passwordReg.text,
  //       confirmPassword: confirmPasswordReg.text,
  //       channel: channel,
  //       email: emailReg,
  //       codeReferal: codeReferal,
  //       countryId: countryId,
  //       stateId: stateId,
  //       cityId: cityId,
  //       districtId: districtId,
  //       latitude: latitude,
  //       longitude: longitude);
  //
  //   isLoading = false;
  //   notifyListeners();
  //   response.when(error: (e) {
  //     debugPrint("ee $e");
  //     isLoading = false;
  //     notifyListeners();
  //     NotificationUtils.showDialogError(
  //       context,
  //       () {
  //         Nav.back();
  //       },
  //       widget: e.message == "Validasi gagal"
  //           ? Text(
  //               "${e.errors!.email!.toString() != "" ? removeBrackets(e.errors!.email.toString()) : ""}  ${e.errors!.phoneNumber!.toString() != "" ? removeBrackets(e.errors!.phoneNumber.toString()) : ""} ${e.errors!.password.toString() != "" ? removeBrackets(e.errors!.password.toString()) : ""}  ${e.errors!.passwordConfirmation.toString() != "" ? removeBrackets(e.errors!.passwordConfirmation.toString()) : ""} ${e.errors!.codeReferal.toString() != "" ? removeBrackets(e.errors!.codeReferal.toString()) : ""}",
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(fontSize: 16),
  //             )
  //           : Text(removeBrackets(
  //               '${e.message.toString()}  ${e.errorCode.toString()}')),
  //     );
  //   }, success: (res) async {
  //     try {
  //       final credential =
  //           await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailReg.trim(),
  //         password: passwordReg.text.trim(),
  //       );
  //
  //       await FirebaseChatCore.instance.createUserInFirestore(
  //         types.User(
  //           firstName: emailReg.toString().substring(0, 3).trim(),
  //           id: credential.user!.uid,
  //           imageUrl: 'https://i.pravatar.cc/300?u=${emailReg.trim()}',
  //           lastName: emailReg.toString().substring(0, 2).trim(),
  //         ),
  //       );
  //     } catch (e) {}
  //     if (res.success == false && res.data == null) {
  //       NotificationUtils.showDialogError(context, () {
  //         Nav.back();
  //       },
  //           widget: Text(
  //             "${res.message}",
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(fontSize: 16),
  //           ));
  //     } else if (res.data?.errors != null) {
  //       NotificationUtils.showDialogError(
  //         context,
  //         () {
  //           Nav.back();
  //         },
  //         widget: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             if (res.data?.errors?.phoneNumber != null) ...[
  //               ...res.data!.errors!.phoneNumber!.map((value) {
  //                 return Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const Text(
  //                         "•",
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                       const SizedBox(
  //                         width: 8,
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           children: [
  //                             Text(
  //                               value,
  //                               style: const TextStyle(fontSize: 16),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }),
  //             ],
  //             if (res.data?.errors?.password?.isNotEmpty ?? false) ...[
  //               ...res.data!.errors!.password!.map((value) {
  //                 return Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const Text(
  //                         "•",
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                       const SizedBox(
  //                         width: 8,
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           children: [
  //                             Text(
  //                               value,
  //                               style: const TextStyle(fontSize: 16),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }),
  //             ],
  //             if (res.data?.errors?.passwordConfirmation?.isNotEmpty ??
  //                 false) ...[
  //               ...res.data!.errors!.passwordConfirmation!.map((value) {
  //                 return Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const Text(
  //                         "•",
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                       const SizedBox(
  //                         width: 8,
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           children: [
  //                             Text(
  //                               value,
  //                               style: const TextStyle(fontSize: 16),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }),
  //             ],
  //             if (res.data?.errors?.codeReferal?.isNotEmpty ?? false) ...[
  //               ...res.data!.errors!.codeReferal!.map((value) {
  //                 return Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const Text(
  //                         "•",
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                       const SizedBox(
  //                         width: 8,
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           children: [
  //                             Text(
  //                               value,
  //                               style: const TextStyle(fontSize: 16),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }),
  //             ],
  //             if (res.data?.errors?.email?.isNotEmpty ?? false) ...[
  //               ...res.data!.errors!.email!.map((value) {
  //                 return Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const Text(
  //                         "•",
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                       const SizedBox(
  //                         width: 8,
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           children: [
  //                             Text(
  //                               value,
  //                               style: const TextStyle(fontSize: 16),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }),
  //             ],
  //           ],
  //         ),
  //       );
  //     } else if (res.success == true) {
  //       dataRegister = res.data;
  //       sendOtp(
  //         context,
  //         dataRegister?.userId.toString() ?? "",
  //         channel,
  //       );
  //       // NotificationUtils.showDialogSuccess(context, () {
  //       //   Nav.back();
  //       //   sendOtp(
  //       //     context,
  //       //     dataRegister?.userId.toString() ?? "",
  //       //     channel,
  //       //   );
  //       // },
  //       //     widget: Center(
  //       //       child: Text(S.of(context).registration_success),
  //       //     ));
  //     }
  //   });
  //
  //   notifyListeners();
  // }

  //logout
  Future<void> logout(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    Either<Failure, ResLogout> response = await auth.logout();

    isLoading = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(
        context,
        () {
          Nav.back();
        },
        widget: Text(
          e.message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }, success: (res) async {
      if (res.success == true) {
        dataGlobal.dataUser = null;
        await Prefs().setToken(null);
        Nav.toAll(const LoginScreen());
      } else if (res.success == false) {
        NotificationUtils.showDialogError(
          context,
          () {
            Nav.back();
          },
          widget: Text(
            "${res.message}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }
    });

    notifyListeners();
  }

  // send otp

  bool isLoadingSendOtp = false;

  Future<void> sendOtp(
      BuildContext context,
      String idUser,
      String channel,
      {
        String? phonenumber,
        String? Password,
      }) async {
    isLoadingSendOtp = true;
    notifyListeners();

    Either<Failure, ResGetOtp> response = await auth.getOtp(
      idUser: idUser,
    );

    response.when(error: (e) {
      NotificationUtils.showDialogError(
        context,
        () {
          Nav.back();
        },
        widget: Text(
          e.message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }, success: (res) {
      if (res.status == true) {
        setOtpTime();
        // setOtpTime(res.data?.otpTime);
        restartTimer();
        // otpController.text = res.data?.otpCode ?? "";
        setSourceToOtpScreen("register");
        Nav.toAll(OtpScreen(
          channel: channel,
          idUser: idUser,
          phonenumber: phonenumber,
          password: Password,
        ));
      }
    });

    isLoadingSendOtp = false;
    notifyListeners();
  }

  // verify otp
  Future<void> verify(BuildContext context, String otpCode,
      {required String idUser, String? phonenumber,
        String? Password,}) async {
    isLoading = true;
    notifyListeners();

    Either<Failure, ResVerifyOtp> response = await auth.verifyOtp(
      otpCode: otpCode,
      idUser: idUser,
    );

    response.when(error: (e) {
      NotificationUtils.showDialogError(
        context,
        () {
          Nav.back();
        },
        widget: Text(
          e.message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }, success: (res) async {
      if (res.status == false) {
        NotificationUtils.showDialogError(context, () {
          // resendOtp().then((value) => Nav.back());
          Nav.back();
        },
            widget: Text(
              "${res.message}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: S.of(context).back);
      } else if (res.status == true) {
        String? fcmKey = await FirebaseMessaging
            .instance
            .getToken();
        if(phonenumber != null){
          login(context,
              phoneNumber: phonenumber ?? "",
              password: Password ?? "",
              fcmToken: fcmKey.toString(),
          source: 'register');
          stopTimer();
          isLoading = false;
          notifyListeners();
        }else{
          stopTimer();
          NotificationUtils.showDialogSuccessOtp(
            context,
                () {
              Nav.back();
            },
            widget: Center(
              child: Text(S.of(context).registration_success),
            ),
          );
        }
        isLoading = false;
        notifyListeners();

      }
    });

    isLoading = false;
    notifyListeners();
  }

  // resend otp

  Future<void> resendOtp(String channel, String idUser) async {
    isLoading = true;
    notifyListeners();

    Either<Failure, ResResendOtp> response = await auth.resendOtp(
      idUser: idUser,
      channel: channel,
    );

    response.when(
        error: (e) {},
        success: (res) {
          notifyListeners();
          if (res.status == true) {
            setOtpTime();
            // setOtpTime(res.data?.otpTime);
            // otpController.text = res.data?.otpCode ?? "";
            restartTimer();
          }
        });

    isLoading = false;
    notifyListeners();
  }

  // update password

  Future<void> updatePassword(BuildContext context, String oldPasword,
      String newPassword, String confirmPassword) async {
    isLoading = true;
    notifyListeners();

    Either<Failure, ResUpdatePassword> response = await auth.updatePassword(
        oldPassword: oldPasword,
        newPassword: newPassword,
        confirmNewPassword: confirmPassword);

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Center(
            child: Text(e.message),
          ));
    }, success: (res) {
      if (res.success == false) {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Center(
              child: Text(res.message ?? ""),
            ));
      } else if (res.success == true) {
        NotificationUtils.showDialogSuccess(context, () {
          Nav.back();
          Nav.back();
        },
            widget: Center(
              child: Text(S.of(context).password_changed),
            ));
      }
    });

    isLoading = false;
    notifyListeners();
  }

  // send otp for forgot password

  Future<void> sendOtpResetPassword(BuildContext context, String channel,
      {String? email, String? phoneNumber, bool isVerif = false}) async {
    isLoading = true;
    notifyListeners();

    Either<Failure, ResSendOtp> response = await auth.sendOtp(
        phoneNumber: phoneNumber, channel: channel, email: email);

    response.when(error: (e) {
      debugPrint("cek no salah");
      isLoading = false;
      notifyListeners();
      NotificationUtils.showDialogError(context, () {
        isLoading = false;
        Nav.back();
        notifyListeners();
      },
          widget: Center(
            child: Text(
              e.message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ));
    }, success: (res) {
      debugPrint("cek no salah5 ${res.message.toString()}");
      if (res.success == true) {
        dataSendOtp = res.data;
        setOtpTime();
        // setOtpTime(res.data?.otpTime);
        restartTimer();

        // otpController.text = res.data?.otpCode ?? "";
        isVerif
            ? setSourceToOtpScreen("register")
            : setSourceToOtpScreen("forgot_password");
        Nav.replace(OtpScreen(
          channel: channel,
          idUser: res.data?.id.toString() ?? "0",
        ));
      } else {
        debugPrint("cek no salah6 ${res.message.toString()}");
        isLoading = false;
        notifyListeners();
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Center(
              child: Text(
                channel == 'email'
                    ? S.of(context).email_not_registered
                    : res.message.toString(),
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ));
      }
    });

    isLoading = false;
  }

  // reset password

  Future<void> resetPassword(
    BuildContext context,
    String password,
    String confirmPassword,
  ) async {
    isLoading = true;
    notifyListeners();

    Either<Failure, ResResetPassword> response = await auth.resetPassword(
        // phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
        idUser: dataSendOtp?.id ?? 0);
    isLoading = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Center(
            child: Text(
              e.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ));
    }, success: (res) {
      if (res.success == true) {
        NotificationUtils.showDialogSuccess(context, () {
          Nav.toAll(const LoginScreen());
        },
            widget: Center(
              child: Text(
                res.message ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ));
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.toAll(const LoginScreen());
        },
            widget: Center(
              child: Text(
                res.message ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ));
      }
    });

    notifyListeners();
  }

  // verify otp
  Future<void> verifyOtpResetPassword(
      BuildContext context, String otpCode) async {
    isLoading = true;
    notifyListeners();

    Either<Failure, ResVerifyOtp> response = await auth.verifyOtp(
        otpCode: otpCode, idUser: dataSendOtp?.id.toString() ?? "0");

    response.when(
        error: (e) {},
        success: (res) {
          if (res.status == false) {
            NotificationUtils.showDialogError(context, () {
              Nav.back();
            },
                widget: Text(
                  "${res.message}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                textButton: S.of(context).back);
          } else if (res.status == true) {
            stopTimer();
            Nav.replace(const ResetPasswordScreen());
          }
        });

    isLoading = false;
    notifyListeners();
  }

  bool isMemberArea = false;
  MemberArea? memberArea;
  bool isCountryIndonesia = false;

  Future<void> checkCountry(BuildContext context) async {
    isMemberArea = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResMemberArea> response = await auth.checkCountry();

    isMemberArea = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          textButton: S.of(context).back);
    }, success: (res) async {
      if (res.success == true) {
        memberArea = res.data;
        isCountryIndonesia = memberArea?.country == "Indonesia";
        notifyListeners();
      }
    });

    notifyListeners();
  }

  bool isLoadingCredential = false;
  CredentialResponse? response;
  Failure? failure;
  Future<void> cekCredential({
    required BuildContext context,
    String? phoneNumber,
    String? email,
    String? navigasi,
    String? coderef
  }) async {
    isLoadingCredential = true;
    notifyListeners();

    try {
      Either<Failure, CredentialResponse> result = await auth
          .cekCredential(
        phoneNumber: phoneNumber,
        email: email,
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException("Permintaan melebihi waktu. Coba lagi.");
        },
      );

      result.when(
        error: (e) {
          failure = e;
          response = null;

          NotificationUtils.showDialogError(
            context,
                () => Navigator.pop(context),
            widget: Text(
              e.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
        success: (res) {
          if (res.success) {
            response = res;
            if(navigasi == 'nohp'){
              Nav.to(OnBoardingEmailPage(phoneNumber: phoneNumber ?? "no kosong",coderef: coderef ?? "",));
            } else if (navigasi == 'email') {
              Nav.to(OnBoardingLoactionPage(phoneNumber: phoneNumber ?? "no kosong",email: email ?? "email kosong",coderef: coderef ?? "",));
            }
          } else {
            failure = Failure(res.message);
            NotificationUtils.showDialogError(
              context,
                  () => Navigator.pop(context),
              widget: Text(
                res.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }
        },
      );
    } on TimeoutException catch (e) {
      failure = Failure(e.message ?? "Timeout");
      response = null;

      NotificationUtils.showDialogError(
        context,
            () => Navigator.pop(context),
        widget: Text(
          e.message ?? "Request Timeout",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      );
    } catch (e) {
      failure = Failure("Terjadi kesalahan, silakan coba lagi.");
      response = null;

      NotificationUtils.showDialogError(
        context,
            () => Navigator.pop(context),
        widget: const Text(
          "Gagal menghubungi server.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    isLoadingCredential = false;
    notifyListeners();
  }
}
