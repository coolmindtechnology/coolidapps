// ignore_for_file: use_build_context_synchronously

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/provider/provider_auth_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/provider/provider_transaksi_affiliate.dart';
import 'package:coolappflutter/data/repositories/repo_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_check_topup_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_overview.dart'
    as affiliasiover;
import 'package:coolappflutter/data/response/affiliate/res_detail_member.dart';
import 'package:coolappflutter/data/response/affiliate/res_home_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_list_bank.dart';
import 'package:coolappflutter/data/response/affiliate/res_list_member.dart';
import 'package:coolappflutter/data/response/affiliate/res_overview.dart';
import 'package:coolappflutter/data/response/affiliate/res_save_rekening.dart';
import 'package:coolappflutter/data/response/user/res_check_profile.dart';
import 'package:coolappflutter/presentation/pages/afiliate/components/dialog_transfer_affiliate.dart';
import 'package:coolappflutter/presentation/pages/afiliate/screen_input_rekening.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/boarding/Boarding1.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/konsultant_dashboard.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/konsultasi_status.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/terma_konsultan.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/pages/main/term_affiliasi.dart';
import 'package:coolappflutter/presentation/pages/transakction/topup_saldo.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../presentation/pages/afiliate/result_rekening_bank.dart';
import '../../presentation/utils/nav_utils.dart';
import '../../presentation/utils/notification_utils.dart';
import '../helpers/either.dart';
import '../helpers/failure.dart';
import '../models/data_member_affiliate.dart';
import '../response/affiliate/res_bank_account.dart';
import 'package:collection/collection.dart';

class ProviderAffiliate extends ChangeNotifier {
  DataAffiliasi? dataAffiliasi;
  affiliasiover.Data? dataOverview;
  bool isLoading = false;
  bool isCektopup = false;
  RepoAffiliate repo = RepoAffiliate();

  /// Retrieves the home affiliate data and performs necessary actions based on the response.
  ///
  /// This function sends a request to the server to retrieve the home affiliate data. It then updates the UI by setting the `isLoading` flag to `true` and notifying the listeners. The response from the server is handled using the `when` method of the `Either` class. If the response is an error, a dialog is shown with the error message and a back button. If the response is successful, the `dataAffiliasi` is updated with the response data. The `ProviderTransaksiAffiliate` is then updated with the `dataAffiliasi`. If the `isActive` property of `dataAffiliasi` is not equal to "1", a simple dialog is shown with a message and two buttons. If `pilihRek` is not null, the `nameBank` is updated with the `bankName` property of `dataAffiliasi`. The `getListRekening` function is called with the `context`. If the `kDebugMode` flag is set to `true`, the `dataAffiliasi` is printed to the console. Finally, the `notifyListeners` function is called to update the UI.
  ///
  /// Parameters:
  /// - `context`: The `BuildContext` used to access the widget tree and show dialogs.
  ///
  /// Returns:
  /// - `Future<void>`: A `Future` that completes when the function finishes executing.

  Future<void> getHomeAff(BuildContext context) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResOverView> response = await repo.getOverViewAffiliate();
    isLoading = false;
    notifyListeners();
    response.when(error: (e) {
      debugPrint("cekt");
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
      debugPrint("cektt");
      if (res.success == true) {
        dataOverview = res.data;
        dataGlobal.dataAff = res.data;
        dataOverview = res.data;
        notifyListeners();
        // Provider.of<ProviderProfiling>(context, listen: false)
        //     .getListProfiling(context);
        // beneficiary@example.com
        context.read<ProviderTransaksiAffiliate>().dataAffiliasi =
            dataAffiliasi;
        debugPrint("cekmm");
        checkCompleteBank(context);
        checkTopupAffiliate(context);

        if (pilihRek != null) {
          nameBank = TextEditingController(text: dataOverview?.bankName);
        }
        getListRekening(context);
        if (kDebugMode) {
          print("data aff ${dataOverview?.toJson()}");
        }
        notifyListeners();
      }
    });

    notifyListeners();
  }

  bool isCheckloading = false;
  Future<void> checkConsultantStatus(BuildContext context) async {
    isCheckloading = false;
    Either<Failure, ResOverView> response = await repo.getOverViewAffiliate();

    response.when(
      error: (e) {
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
          textButton: S.of(context).back,
        );
      },
      success: (res) async {
        print(res.data?.statusApprovalConsultant ??
            "Status approval consultant tidak ditemukan di response");

        if (res.success == true) {
          String? statusApproval = res.data?.statusApprovalConsultant;

          if (statusApproval == null) {
            // Jika statusApproval bernilai null
            Nav.to(TermaKonsultant(
              isCheck: true,
            ));
            print('Status approval consultant: null');
          } else if (statusApproval == "not_found") {
            Nav.to(TermaKonsultant(
              isCheck: true,
            ));
            print('Status approval consultant: not_found');
          } else if (statusApproval == "waiting") {
            Nav.to(KonsulatsiStatusPage(isRejected: false));
            print('Status approval consultant: waiting');
          } else if (statusApproval == "reject") {
            Nav.to(KonsulatsiStatusPage(isRejected: true));
            print('Status approval consultant: waiting');
          } else if (statusApproval == "approve") {
            final prefs = await SharedPreferences.getInstance();
            final isFirstTimeBoarding =
                prefs.getBool('isFirstTimeBoarding') ?? true;
            if (isFirstTimeBoarding) {
              // Jika pertama kali, arahkan ke BoardingKonsultan1
              await prefs.setBool(
                  'isFirstTimeBoarding', false); // Tandai sudah masuk
              Nav.to(BoardingKonsultan1());
              print('Status approval consultant: approved (first time)');
            } else {
              // Jika bukan pertama kali, arahkan ke KonsultantDashboard
              Nav.to(KonsultantDashboard());
              print('Status approval consultant: approved (not first time)');
            }
          } else {
            // Penanganan jika status tidak dikenali
            NotificationUtils.showDialogError(
              context,
              () {
                Nav.back();
              },
              widget: Text(
                "Status tidak dikenali: $statusApproval",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              textButton: S.of(context).back,
            );
            print("Status approval consultant tidak dikenali: $statusApproval");
          }
        } else {
          // Penanganan jika res.success == false
          NotificationUtils.showDialogError(
            context,
            () {
              Nav.back();
            },
            widget: const Text(
              "Gagal memuat data.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            textButton: S.of(context).back,
          );
        }
      },
    );

    notifyListeners();
  }

  bool isSaveRek = false;
  DataRek? pilihRek;
  String? kodeBank;
  // TextEditingController nomorRek = TextEditingController();
  TextEditingController? nameBank, noRek, nama;
  Future<void> saveRek(BuildContext context, String bankName, String bankNumber,
      String accountName,
      {Function? onUpdate}) async {
    debugPrint("rekkk $noRek");
    isSaveRek = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResSaveRekening> response =
        await repo.saveRekening(bankName, bankNumber, accountName);
    isSaveRek = false;
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
        NotificationUtils.showSnackbar(res.message ?? "",
            backgroundColor: primaryColor);
        // Nav.back();
        // Nav.back(data: 'save');
        Nav.toAll(NavMenuScreen());
        onUpdate!();
        notifyListeners();
      }
    });

    notifyListeners();
  }

  bool isListRek = false;
  List<DataRek> listRek = [];
  Future<void> getListRekening(BuildContext context) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResListBank> response = await repo.getListBank();
    isLoading = false;
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
      if (res.status == 200) {
        listRek = res.data ?? [];
        // if (listRek != null) {
        pilihRek = listRek.firstWhereOrNull((element) {
          notifyListeners();
          if (kDebugMode) {
            print("nama Bank ${nameBank?.text ?? "-"}");
          }
          return element.name == nameBank?.text.toString();
        });
        if (kDebugMode) {
          print("nama Bank pilih rek ${pilihRek?.code}");
        }
        // getDataAccountBank(
        //     context, pilihRek?.kodeBank ?? "" ?? "", pilihRek?.namaBank ?? "");

        // }

        notifyListeners();
      }
    });

    notifyListeners();
  }

  bool isListMember = false;
  List<DataMemberAffiliate> listMember = [];
  Future<void> getListMember(BuildContext context) async {
    isListMember = true;

    notifyListeners();

    Either<Failure, ResListMember> response = await repo.getListMember();
    isListMember = false;
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
        listMember = res.data ?? [];
        if (kDebugMode) {
          print("data list member ${listMember[0].toJson()}");
        }
        notifyListeners();
      }
    });

    notifyListeners();
  }

  bool isAccountBank = false;
  ResBankAccount? dataAccountBank;
  Future<void> getDataAccountBank(
      BuildContext context, String bankCode, String accountNumber,
      {Function? onUpdate}) async {
    isAccountBank = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResBankAccount> response =
        await repo.getBankAccount(bankCode, accountNumber);
    isAccountBank = false;
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
        dataAccountBank = res;
        onUpdate!();
        if (pilihRek != null) {
          kodeBank = pilihRek?.code;
        }
        nameBank = TextEditingController(text: dataAccountBank?.data?.bankName);
        Nav.to(ResultRekeningBank(
          bankName: dataAccountBank,
          onUpdate: () {
            onUpdate();
          },
        ));
        // lisTempatTinggal = res?.data ?? [];
        // if (statusTempatTinggal != null) {
        //   valTempatTinggal = lisTempatTinggal.firstWhereOrNull((element) {
        //     notifyListeners();
        //     return element.statusTempatTinggal ==
        //         tableTempatTinggal.statusTempatTinggal;
        //   });
        // }
        if (kDebugMode) {
          print("data Account bank ${dataAccountBank?.toJson()}");
        }
        notifyListeners();
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              S.of(context).bank_account_not_found,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: S.of(context).back);
      }
    });

    notifyListeners();
  }

  bool isDetailAffiliate = false;
  DataMemberAffiliate? detailDataMember;
  Future<void> getDetailAffiliate(BuildContext context, String idMember) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResDetailMeber> response =
        await repo.getDetailMemberAffiliate(idMember);
    isLoading = false;
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
        detailDataMember = res.data;
        if (kDebugMode) {
          print("data detail member ${detailDataMember?.toJson()}");
        }
        notifyListeners();
      }
    });

    notifyListeners();
  }

  ResCheckTopupAffiliate? _resCheckTopupAffiliate;

  ResCheckTopupAffiliate? get resCheckTopupAffiliate => _resCheckTopupAffiliate;

  set resCheckTopupAffiliate(ResCheckTopupAffiliate? value) {
    _resCheckTopupAffiliate = value;
    notifyListeners();
  }

  /// Checks the top-up affiliate status and displays appropriate notifications or dialogs based on the response.
  ///
  /// Parameters:
  ///   - context: The build context used to display notifications or dialogs.
  ///
  /// Returns:
  ///   A `Future` that completes when the top-up affiliate check is complete.
  Future<void> checkTopupAffiliate(
    BuildContext context,
  ) async {
    isCektopup = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    Either<Failure, ResCheckTopupAffiliate> response =
        await repo.checkTopupAffiliate(dataGlobal.dataUser?.id.toString() ?? 'kosong cek id');
    isCektopup = false;
    notifyListeners();
    response.when(error: (e) {
      debugPrint("masuk eeee?");
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      debugPrint("masuk sukses?");
      if (res.success == true) {
        resCheckTopupAffiliate = res;

        // Ensure the notif value is not null before switching
        var notif = resCheckTopupAffiliate?.data?.notif;
        if (notif != null) {
          switch (notif) {
            case 0:
              await NotificationUtils.showDialogError(
                context,
                () {
                  Nav.back();
                },
                widget: Text(
                  "${res.message}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            case 1:
              await NotificationUtils.showDialogError(
                context,
                () {
                  Nav.back();
                },
                widget: Text(
                  "${res.message}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            case 2:
              await NotificationUtils.showDialogError(
                context,
                () {
                  Nav.back();
                },
                widget: Text(
                  "${res.message}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            case 3:
              await NotificationUtils.showSimpleDialog2(
                context,
                resCheckTopupAffiliate?.message ?? "",
                textButton1: S.of(context).top_up,
                textButton2: S.of(context).back,
                onPress1: () async {
                  Nav.back();
                  var data = await Nav.to(const TopupSaldoPage());
                  if (data != null) {
                    checkTopupAffiliate(context);
                  }
                },
                onPress2: () {
                  Nav.back();
                },
              );
                break;
              case 4:
                await NotificationUtils.showSimpleDialog2(
                  context,
                  resCheckTopupAffiliate?.message ?? "",
                  textButton1: S.of(context).top_up,
                  textButton2: S.of(context).back,
                  onPress1: () async {
                    Nav.back();
                    var data = await Nav.to(const TopupSaldoPage());
                    if (data != null) {
                      checkTopupAffiliate(context);
                    }
                  },
                  onPress2: () {
                    Nav.back();
                  },
                );
              await NotificationUtils.showDialogSuccess(
                context,
                () {
                  Nav.back();
                  //update notif top up to false
                  updateNotifTopupAffiliate(context);
                },
                widget: Text(
                  "${res.message}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            // case 5:
            //   await NotificationUtils.showDialogError5(
            //     context,
            //     () {
            //       updateNotifTopupAffiliate(context);
            //       Nav.back();
            //     },
            //     widget: Text(
            //       "${res.message}",
            //       style: const TextStyle(fontSize: 16),
            //       textAlign: TextAlign.justify,
            //     ),
            //   );
              // await NotificationUtils.showSimpleDialog2(
              //   context,
              //   "${res.message}",
              // textButton1: S.of(context).process,
              // textButton2: S.of(context).back,
              // onPress1: () async {
              //   // Convert the strings to numbers
              //   double num1 = double.parse(
              //       dataAffiliasi?.totalSaldoAffiliate.toString() == ""
              //           ? "0.0"
              //           : "${dataAffiliasi?.totalSaldoAffiliate.toString()}");
              //   double num2 = double.parse(
              //       dataAffiliasi?.totalRealMoney.toString() == ""
              //           ? "0.0"
              //           : "${dataAffiliasi?.totalRealMoney.toString()}");

              //   // Calculate the sum
              //   double sum = num1 + num2;
              //   Nav.back();
              //   await showDialog(
              //       barrierDismissible: false,
              //       context: context,
              //       builder: (_) {
              //         debugPrint("tes cek vacum transfer");
              //         return DialogTransferAffiliate(
              //           calculateSaldo: sum.toString(),
              //           bankName: dataAffiliasi?.bankName,
              //         );
              //       });
              // },
              //   onPress2: () async {
              //     Nav.back();
              //     Nav.back();
              //   },
              // );
              break;
            case 6:
              await NotificationUtils.showDialogError(
                context,
                () {
                  Nav.back();
                },
                widget: Text(
                  "${res.message}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            case 7:
              await NotificationUtils.showDialogError(
                context,
                () {
                  Nav.back();
                },
                widget: Text(
                  "${res.message}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            case 8:
              await NotificationUtils.showDialogError(
                context,
                () {
                  Nav.back();
                },
                widget: Text(
                  "${res.message}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            case 9:
              await NotificationUtils.showDialogError(
                context,
                () {
                  Nav.back();
                },
                widget: Text(
                  "${res.message}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            case 10:
              await NotificationUtils.showDialogSuccess(
                context,
                    () {
                  Nav.back();
                  updateNotifTopupAffiliate(context);
                },
                widget: Text(
                  "${res.message}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
              break;
              case 11:
              await NotificationUtils.showSimpleDialog2(
                context,
                resCheckTopupAffiliate?.message ?? "",
                textButton1: S.of(context).register_affiliate,
                textButton2: S.of(context).back,
                onPress1: () async {
                  if ( resCheckTopupAffiliate
                      ?.data
                      ?.notif !=
                      5) {
                    updateNotifTopupAffiliate(context);
                    Nav.back();
                    Nav.toAll(const TermHomeAffiliasi());
                  }

                },
                onPress2: () {
                  Nav.back();
                  updateNotifTopupAffiliate(context);
                },
              );
              break;
            default:
              // Handle other cases if needed
              break;
          }
        }

        notifyListeners();
      } else {
        resCheckTopupAffiliate = null;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  Future<void> updateNotifTopupAffiliate(
    BuildContext context,
  ) async {
    Either<Failure, ResCheckTopupAffiliate> response =
        await repo.updateNotifTopupAffiliate(dataGlobal.dataAff!.idUser);
    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        resCheckTopupAffiliate = res;
        notifyListeners();
      }
    });
  }

  Future<void> checkCompleteBank(BuildContext context) async {
    Either<Failure, ResCheckProfile> response = await repo.checkCompleteBank();
    response.when(
      error: (e) {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              e.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ));
      },
      success: (res) {
        if (res.success != true) {
          NotificationUtils.showDialogError(context, () async {
            await Nav.back();
            var data = await Nav.to(ScreenInputRekening(
              dataBank: dataAffiliasi,
              onUpdate: () async {},
            ));

            /// check again
            ///if without save account, when back from input rekening page
            if (data == null) {
              await checkCompleteBank(context);
            } else {
              /// if save account, when back from input rekening page
              await getHomeAff(context);
              await checkCompleteBank(context);
            }
          },
              widget: Text(
                res.message ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ));
        } else {
          // NotificationUtils.showDialogError(context, () async {
          //   await Nav.back();
          //   var data = await Nav.to(ScreenInputRekening(
          //     dataBank: dataAffiliasi,
          //     onUpdate: () async {},
          //   ));
          //
          //   /// check again
          //   ///if without save account, when back from input rekening page
          //   if (data == null) {
          //     await checkCompleteBank(context);
          //   } else {
          //     /// if save account, when back from input rekening page
          //     await getHomeAff(context);
          //     await checkCompleteBank(context);
          //   }
          // },
          //     widget: Text(
          //       res.message ?? "",
          //       textAlign: TextAlign.center,
          //       style: const TextStyle(fontSize: 16),
          //     ));
          /// data bank complete will check notification for top up
          // checkTopupAffiliate(context);


        }
      },
    );
    notifyListeners();
  }
}
