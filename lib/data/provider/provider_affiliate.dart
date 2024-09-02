// ignore_for_file: use_build_context_synchronously

import 'package:cool_app/data/provider/provider_transaksi_affiliate.dart';
import 'package:cool_app/data/repositories/repo_affiliate.dart';
import 'package:cool_app/data/response/affiliate/res_check_topup_affiliate.dart';
import 'package:cool_app/data/response/affiliate/res_detail_member.dart';
import 'package:cool_app/data/response/affiliate/res_home_affiliate.dart';
import 'package:cool_app/data/response/affiliate/res_list_bank.dart';
import 'package:cool_app/data/response/affiliate/res_list_member.dart';
import 'package:cool_app/data/response/affiliate/res_save_rekening.dart';
import 'package:cool_app/data/response/user/res_check_profile.dart';
import 'package:cool_app/presentation/pages/afiliate/components/dialog_transfer_affiliate.dart';
import 'package:cool_app/presentation/pages/afiliate/screen_input_rekening.dart';
import 'package:cool_app/presentation/pages/transakction/topup_saldo.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  // ProviderAffiliate.initEdit(BuildContext context, {BankAccount? datBank}) {
  //   nameBank = TextEditingController(text: datBank?.bankName ?? "-");
  //   noRek = TextEditingController(text: datBank?.accountNo);
  //   nama = TextEditingController(text: datBank?.accountName ?? "-");
  //   // getDataAccountBank(context, datBank?.bankcode ?? "", noRek?.text ?? "");
  // }

  // ProviderAffiliate.initAff(BuildContext context, {Function? onUpdate}) {
  //   if (onUpdate != null) {
  //     getHomeAff(context);
  //   }
  //   getHomeAff(context);
  // }

  // ProviderAffiliate.initDetailMember(BuildContext context,
  //     {DataMemberAffiliate? data}) {
  //   if (data != null) {
  //     getDetailAffiliate(context, data.id.toString());
  //   }
  // }

  // ProviderAffiliate.initMember(BuildContext context) {
  //   getListMember(context);
  // }

  // ProviderAffiliate.initRek(BuildContext context, {DataAffiliasi? dataBank}) {
  //   if (dataBank != null) {
  //     noRek = TextEditingController(text: dataBank.bankNumber);
  //     nameBank = TextEditingController(text: dataBank.bankName);
  //     getListRekening(context);
  //   } else {
  //     getListRekening(context);
  //   }
  // }
  DataAffiliasi? dataAffiliasi;
  bool isLoading = false;
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

    Either<Failure, ResAffiliate> response = await repo.getHomeAffiliate();
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
        dataAffiliasi = res.data;
        // beneficiary@example.com
        context.read<ProviderTransaksiAffiliate>().dataAffiliasi =
            dataAffiliasi;

        /// check if the account is active
        if (dataAffiliasi?.isActive != "1") {
          NotificationUtils.showSimpleDialog(context,
              message: S.of(context).account_disabled_contact_admin, () {
            Nav.back();
            Nav.back();
          }, textOnButton: S.of(context).close);
        } else {
          /// if account is active check data bank
          checkCompleteBank(context);

          if (pilihRek != null) {
            nameBank = TextEditingController(text: dataAffiliasi?.bankName);
          }
          getListRekening(context);
          if (kDebugMode) {
            print("data aff ${dataAffiliasi?.toJson()}");
          }
        }

        notifyListeners();
      }
    });

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
        Nav.back();
        Nav.back(data: 'save');
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
        if (listRek != null) {
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
        } else {
          pilihRek = listRek.firstWhereOrNull((element) {
            notifyListeners();
            return element.name == nameBank?.text;
          });
          if (kDebugMode) {
            print("nama Bank pilih rek ${pilihRek?.code}");
          }
        }

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
    Either<Failure, ResCheckTopupAffiliate> response =
        await repo.checkTopupAffiliate(dataAffiliasi?.idUser ?? "");

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

        // Ensure the notif value is not null before switching
        var notif = resCheckTopupAffiliate?.data?.notif;
        if (notif != null) {
          switch (notif) {
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
            case 5:
              await NotificationUtils.showSimpleDialog2(
                context,
                "${res.message}",
                textButton1: S.of(context).process,
                textButton2: S.of(context).back,
                onPress1: () async {
                  // Convert the strings to numbers
                  double num1 =
                      double.parse(dataAffiliasi?.totalSaldoAffiliate ?? "0.0");
                  double num2 =
                      double.parse(dataAffiliasi?.totalRealMoney ?? "0.0");

                  // Calculate the sum
                  double sum = num1 + num2;
                  Nav.back();
                  await showDialog(
                      context: context,
                      builder: (_) {
                        return DialogTransferAffiliate(
                          calculateSaldo: sum.toString(),
                          bankName: dataAffiliasi?.bankName,
                        );
                      });
                },
                onPress2: () async {
                  Nav.back();
                  Nav.back();
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
        await repo.updateNotifTopupAffiliate(dataAffiliasi?.idUser ?? "");
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
          /// data bank complete will check notification for top up
          checkTopupAffiliate(context);
        }
      },
    );
    notifyListeners();
  }
}
