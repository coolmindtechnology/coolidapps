// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/models/data_checkout_transaction.dart';
import 'package:cool_app/data/provider/provider_payment.dart';
import 'package:cool_app/data/provider/provider_user.dart';
import 'package:cool_app/data/repositories/repo_profiling.dart';
import 'package:cool_app/data/response/payments/res_transcation_profiling.dart';
import 'package:cool_app/data/response/profiling/res_add_profiling.dart'
    as add_profiling;
import 'package:cool_app/data/response/profiling/res_check_maximum_profiling.dart';
import 'package:cool_app/data/response/profiling/res_create_multiple_profiling.dart';
import 'package:cool_app/data/response/profiling/res_detail_profiling.dart';
import 'package:cool_app/data/response/profiling/res_get_user_profiling.dart';
import 'package:cool_app/data/response/profiling/res_list_multiple_profiling.dart';
import 'package:cool_app/data/response/profiling/res_pay_profiling.dart';
import 'package:cool_app/data/response/profiling/res_update_transaction_profiling.dart';
import 'package:cool_app/data/response/profiling/res_upgrade_member.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/profiling/screen_feature_kepribadian.dart';
import 'package:cool_app/data/response/profiling/res_share_result_detail.dart';
import 'package:cool_app/data/response/profiling/res_show_detail.dart';
import 'package:cool_app/presentation/pages/payments/pre_invoice_screen.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/widgets/custom_input_field.dart';
import 'package:cool_app/presentation/widgets/item_share_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../presentation/utils/nav_utils.dart';
import '../../presentation/utils/notification_utils.dart';
import '../helpers/either.dart';
import '../helpers/failure.dart';
import '../response/profiling/res_list_profiling.dart';
import '../response/profiling/res_permit_profiling.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class ProviderProfiling extends ChangeNotifier {
  ProviderProfiling();

  ProviderProfiling.initList(BuildContext context) {
    getListProfiling(context);
    getListMutipleProfiling(context);
    checkMaximumProfiling(context);
  }

  ProviderProfiling.showDetail(BuildContext context, String id) {
    getShowProfiling(context, id);
  }
  ProviderProfiling.detail(BuildContext context, String id) {
    getDetailProfiling(context, id);
  }

  ProviderProfiling.getHistory(BuildContext context) {
    getHistoryProfiling(context);
  }

  ProviderProfiling.userProfiling(
    BuildContext context,
  ) {
    getUserProfiling(context);
  }

  // ProviderProfiling.createTransactionProfiling(
  //     BuildContext context, DataCheckoutTransaction dataCheckoutTransaction) {
  //   createTransactionProfiling(context, dataCheckoutTransaction);
  // }
  ProviderProfiling.udpatePaymentProfiling(BuildContext context, String id) {
    udpatePaymentProfiling(context, id);
  }

  ProviderPayment payment = ProviderPayment();

  bool isLoading = false;
  RepoProfiling repo = RepoProfiling();
  List<DataProfiling> listProfiling = [], listDisable = [];
  DataDetailProfiling? detailProfiling;
  DataShowDetail? dataShowDetail;
  final FlutterShareMe flutterShareMe = FlutterShareMe();

  int minYears = 17;

  Future<void> getListProfiling(BuildContext context) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResListProfiling> response = await repo.getProfiling();

    isLoading = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        listProfiling = res.data ?? [];
        listDisable = listProfiling.where((element) {
          return element.status == "1";
        }).toList();
        notifyListeners();
      }
    });
    notifyListeners();
  }

  String _textToSpeech = "";
  String get textToSpeech {
    return _textToSpeech.substring(1, 4000);
  }

  void _updateTextToSpeech(DataDetailProfiling? detailProfilingData) {
    _textToSpeech = " ${detailProfilingData?.personality?.description}";

    notifyListeners();
  }

  bool isShowDetail = false;
  Future<void> getShowProfiling(BuildContext context, String id) async {
    isShowDetail = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResShowDetail> response = await repo.getShowProfiling(id);

    isShowDetail = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        if (kDebugMode) {}
        dataShowDetail = res.data;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool isDetail = false;
  Future<void> getDetailProfiling(BuildContext context, String id) async {
    isDetail = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResDetailProfiling> response =
        await repo.getDetailProfiling(id);

    isDetail = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        if (kDebugMode) {}
        detailProfiling = res.data;
        _updateTextToSpeech(detailProfiling);

        notifyListeners();
      }
    });
    notifyListeners();
  }

  TextEditingController tglLahir = TextEditingController();
  TextEditingController domicile = TextEditingController();
  TextEditingController name = TextEditingController();
  String? monthDate, yearDate, dayDate;
  int? birthDate = 0;
  String? bloodType;
  final keyForm = GlobalKey<FormState>();
  bool isAddProfiling = false;

  Future<void> addDataProfiling(
      BuildContext context, String bloodDtype, String name, String domicile,
      {Function? onAdd}) async {
    isAddProfiling = true;
    notifyListeners();

    Either<Failure, add_profiling.ResAddProfiling> response =
        await repo.addProfiling(dayDate ?? "", monthDate ?? "", yearDate ?? "",
            bloodDtype, name, domicile);

    isAddProfiling = false;
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
      // Nav.back();
      Nav.back();
      showDialog(
          context: context,
          builder: (context) {
            return DialogSimpleAutoPopup(
              seconds: 3,
              message: res.message ?? "-",
            );
          });

      onAdd!();
      notifyListeners();
    });

    notifyListeners();
  }

  bool isHistoryProfiling = false;
  List<DataProfiling> listHistory = [];
  Future<void> getHistoryProfiling(BuildContext context) async {
    isHistoryProfiling = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResListProfiling> response =
        await repo.getHistoryProfiling();

    isHistoryProfiling = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        listHistory = res.data ?? [];
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool isPayProfiling = false;
  Future<void> payProfiling(BuildContext context, List<int> idLog,
      String discount, String transactionType, int qty,
      {Function? onAdd, Function? onUpdate, String? fromPage}) async {
    isPayProfiling = true;
    notifyListeners();

    Either<Failure, ResPayProfiling> response = await repo.payProfiling(
        idLog, discount, transactionType, qty,
        gateway: dataGlobal.isIndonesia ? 'midtrans' : 'paypal');

    isPayProfiling = false;
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
      bool isIndonesia = context.read<ProviderUser>().isIndonesia();
      if (kDebugMode) {
        print("id log profiling ${res.data?.totalAmount}");
      }
      Nav.to(PreInvoiceScreen(
        snapToken: res.data?.snapToken,
        orderId: res.data?.orderId,
        paymentType: res.data?.transactionType,
        date: res.data?.createdAt,
        discount: res.data?.discount,
        amount: !dataGlobal.isIndonesia
            ? res.data?.amountPaypal
            : res.data?.totalAmount,
        currencyPaypal: res.data?.currencyPaypal,
        onUpdate: onUpdate,
        fromPage: fromPage,
        isIndonesia: isIndonesia,
      ));
      // Nav.to(PreInvoiceScreen(
      //   snapToken: res.data?.snapToken,
      //   orderId: res.data?.orderId,
      //   paymentType: res.data?.transactionType,
      //   date: res.data?.createdAt,
      //   discount: res.data?.discount,
      //   amount: res.data?.totalAmount,
      //   onUpdate: onUpdate,
      //   fromPage: fromPage,
      //   isIndonesia: isIndonesia,
      // ));

      if (kDebugMode) {
        print(isIndonesia);
      }

      notifyListeners();
    });

    notifyListeners();
  }

  Future<void> _launchUrlShare(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> shareResultDetail(BuildContext context) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResShareResultDetail> response =
        await repo.shareResultDetail(detailProfiling?.shareCode);

    isLoading = false;
    notifyListeners();

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
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  res.data?.facebook != null
                      ? ItemShareWidget(
                          socialMedia: "Facebook",
                          image: "assets/icons/facebook-round-color-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.facebook ?? "");
                          })
                      : const SizedBox(),
                  res.data?.twitter != null
                      ? ItemShareWidget(
                          socialMedia: "Twitter",
                          image: "assets/icons/x-social-media-logo-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.twitter ?? "");
                          })
                      : const SizedBox(),
                  res.data?.linkedin != null
                      ? ItemShareWidget(
                          socialMedia: "Linkedin",
                          image: "assets/icons/linkedin-app-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.linkedin ?? "");
                          })
                      : const SizedBox(),
                  res.data?.telegram != null
                      ? ItemShareWidget(
                          socialMedia: "Telegram",
                          image: "assets/icons/telegram-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.telegram ?? "");
                          })
                      : const SizedBox(),
                  res.data?.whatsapp != null
                      ? ItemShareWidget(
                          socialMedia: "Whatsapp",
                          onShare: () {
                            _launchUrlShare(res.data?.whatsapp ?? "");
                          },
                          image: "assets/icons/whatsapp-color-icon.png",
                        )
                      : const SizedBox(),
                  res.data?.others != null
                      ? ItemShareWidget(
                          socialMedia: "Others",
                          onShare: () {
                            flutterShareMe.shareToSystem(
                                msg: res.data?.others ?? "");
                            // AppinioSocialShare().shareToSystem(
                            //     "Result Detail Profiling",
                            //     res.data?.others ?? "");
                          },
                          image: "assets/icons/forward-arrow-icon.png",
                        )
                      : const SizedBox(),
                ],
              ),
            );
          });
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> shareCertificate(BuildContext context, String shareCode) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResShareResultDetail> response =
        await repo.shareCertificate(shareCode);

    isLoading = false;
    notifyListeners();

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
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  res.data?.facebook != null
                      ? ItemShareWidget(
                          socialMedia: "Facebook",
                          image: "assets/icons/facebook-round-color-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.facebook ?? "");
                          })
                      : const SizedBox(),
                  res.data?.twitter != null
                      ? ItemShareWidget(
                          socialMedia: "Twitter",
                          image: "assets/icons/x-social-media-logo-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.twitter ?? "");
                          })
                      : const SizedBox(),
                  res.data?.linkedin != null
                      ? ItemShareWidget(
                          socialMedia: "Linkedin",
                          image: "assets/icons/linkedin-app-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.linkedin ?? "");
                          })
                      : const SizedBox(),
                  res.data?.telegram != null
                      ? ItemShareWidget(
                          socialMedia: "Telegram",
                          image: "assets/icons/telegram-icon.png",
                          onShare: () async {
                            _launchUrlShare(res.data?.telegram ?? "");
                          })
                      : const SizedBox(),
                  res.data?.whatsapp != null
                      ? ItemShareWidget(
                          socialMedia: "Whatsapp",
                          onShare: () {
                            _launchUrlShare(res.data?.whatsapp ?? "");
                          },
                          image: "assets/icons/whatsapp-color-icon.png",
                        )
                      : const SizedBox(),
                  res.data?.others != null
                      ? ItemShareWidget(
                          socialMedia: "Others",
                          onShare: () {
                            flutterShareMe.shareToSystem(
                              msg: res.data?.others ?? "",
                            );
                            // AppinioSocialShare().shareToSystem(
                            //     "Certificate Profiling",
                            //     res.data?.others ?? "");
                          },
                          image: "assets/icons/forward-arrow-icon.png",
                        )
                      : const SizedBox(),
                ],
              ),
            );
          });
      notifyListeners();
    });
    notifyListeners();
  }

  bool isUserProfiling = false;
  UserProfiling? userProfiling;
  Future<void> getUserProfiling(BuildContext context) async {
    isUserProfiling = true;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    notifyListeners();
    // });

    Either<Failure, ResGetUserProfiling> response =
        await repo.getUserProfiling();

    isUserProfiling = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        if (kDebugMode) {}
        userProfiling = res.data;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool isCekAvailable = false;
  ResPermiteProfiling? cekAvailable;
  Future<void> cekAvailableProfiling(
      BuildContext context, TextEditingController controller) async {
    isCekAvailable = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResPermiteProfiling> response =
        await repo.cekAvailableLocationProfiling();

    isCekAvailable = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        Nav.to(const ScreenFeatureKepribadian());
        if (kDebugMode) {
          print("cek available $cekAvailable");
        }

        cekAvailable = res;

        notifyListeners();
      } else {
        // for upgrade member

        NotificationUtils.showSimpleDialog2(
          context,
          "${res.message}",
          content: Text(
            S.of(context).upgrade_member_to_get_more_feature,
            textAlign: TextAlign.center,
          ),
          textButton1: S.of(context).yes,
          textButton2: S.of(context).no,
          onPress1: () async {
            Nav.back();
            NotificationUtils.showSimpleDialog(
              context,
              () async {
                if (controller.text.isNotEmpty) {
                  await upgradeToMember(context, controller);
                } else {
                  NotificationUtils.showSnackbar(S.of(context).cannot_be_empty,
                      backgroundColor: primaryColor);
                }
              },
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).referral_code_affiliate),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomInputField(
                    textEditingController: controller,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return S.of(context).cannot_be_empty;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            );
          },
          onPress2: () {
            Nav.back();
          },
        );
        if (kDebugMode) {
          print("cek available $cekAvailable");
        }
      }
    });
    notifyListeners();
  }

  bool isCreatePayment = false;
  ResTransactionProfiling? resTransactionProfiling;

  Future<void> createTransactionProfiling(BuildContext context,
      DataCheckoutTransaction dataCheckoutTransaction, Function() onUpdate,
      {bool isMultiple = false}) async {
    isCreatePayment = true;
    notifyListeners();

    Either<Failure, ResTransactionProfiling> response =
        await repo.createTransactionProfiling(dataCheckoutTransaction);

    isCreatePayment = false;
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
      resTransactionProfiling = res;
      if (resTransactionProfiling?.success == true) {
        bool isIndonesia = context.read<ProviderUser>().isIndonesia();
        if (kDebugMode) {
          print("harga skrg ${res.data?.totalAmount}");
        }
        Nav.to(PreInvoiceScreen(
          // id: res.data?.orderId,
          paymentType: res.data?.paymentType,
          currencyPaypal: res.data?.currencyPaypal,
          date: res.data?.createdAt,
          discount: res.data?.discount,
          amount: dataGlobal.isIndonesia
              ? res.data?.totalAmount.toString()
              : res.data?.amountPaypal,
          quantity: "Profiling ${res.data?.itemDetails?.length.toString()}x",
          id: res.data?.id.toString() ?? "",

          isWithSaldo: true,
          isMultiple: isMultiple,
          onUpdate: onUpdate,
          isIndonesia: isIndonesia,
        ));
      } else {
        NotificationUtils.showDialogError(
          context,
          () {
            Nav.back();
          },
          widget: Text(
            resTransactionProfiling?.message ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }

      notifyListeners();
    });

    notifyListeners();
  }

  bool isCreateMultipleProfiling = false;

  Future<void> createMultipleProfiling(
      BuildContext context, List<Map<String, dynamic>> formData,
      {Function? onAdd}) async {
    isCreateMultipleProfiling = true;
    notifyListeners();

    Either<Failure, ResCreateMultipleProfiling> response =
        await repo.createMultipleProfiling(formData);

    isCreateMultipleProfiling = false;
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
      Nav.back();
      showDialog(
          context: context,
          builder: (context) {
            return DialogSimpleAutoPopup(
              seconds: 3,
              message: res.message ?? "-",
            );
          });

      onAdd!();
      notifyListeners();
    });

    notifyListeners();
  }

  bool isLoadingGetLIstMultipleProfiling = false;
  List<DataListMultipleProfiling> listMultipleProfiling = [];
  Future<void> getListMutipleProfiling(BuildContext context) async {
    isLoadingGetLIstMultipleProfiling = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResListMultipleProfiling> response =
        await repo.getListMultipleProfiling();

    isLoadingGetLIstMultipleProfiling = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        listMultipleProfiling = res.data ?? [];
      }
    });
    notifyListeners();
  }

  //pay multiple profiling
  Future<void> payMultipleProfiling(
      BuildContext context, DataCheckoutTransaction dataCheckoutTransaction,
      {Function? onAdd,
      Function? onUpdate,
      String? fromPage,
      bool isMultiple = false}) async {
    isPayProfiling = true;
    notifyListeners();

    Either<Failure, ResPayProfiling> response =
        await repo.payMultipleProfiling(dataCheckoutTransaction);

    isPayProfiling = false;
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
      bool isIndonesia = context.read<ProviderUser>().isIndonesia();
      Nav.to(PreInvoiceScreen(
        snapToken: res.data?.snapToken,
        orderId: res.data?.orderId,
        paymentType: res.data?.transactionType,
        date: res.data?.createdAt,
        discount: res.data?.discount,
        amount: dataGlobal.isIndonesia
            ? res.data?.totalAmount
            : res.data?.amountPaypal,
        currencyPaypal: res.data?.currencyPaypal,
        onUpdate: onUpdate,
        fromPage: fromPage,
        isMultiple: isMultiple,
        isIndonesia: isIndonesia,
      ));
    });
  }

  bool isCheckMaximumProfiling = false;
  DataMaximumProfiling? dataMaximumProfiling;
  Future<void> checkMaximumProfiling(BuildContext context) async {
    isCheckMaximumProfiling = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResCheckMaximumCreateProfiling> response =
        await repo.checkMaximumProfiling();

    isCheckMaximumProfiling = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        dataMaximumProfiling = res.data;
      }
    });
    notifyListeners();
  }

  bool isPayProfilingWithSaldo = false;
  ResUpdateTransactionProfiling? resUpdateTransactionProfiling;

  Future<void> udpatePaymentProfiling(BuildContext context, String id) async {
    isPayProfilingWithSaldo = true;
    notifyListeners();

    Either<Failure, ResUpdateTransactionProfiling> response =
        await repo.updateTransactionProfiling(id);

    isPayProfilingWithSaldo = false;
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
      resUpdateTransactionProfiling = res;
    });

    notifyListeners();
  }

  bool isUpgradeToMember = false;
  ResUpgradeMember? resUpgradeMember;

  Future<void> upgradeToMember(
      BuildContext context, TextEditingController code) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isUpgradeToMember = true;
      notifyListeners();
    });

    Either<Failure, ResUpgradeMember> response =
        await repo.upgradeToMember(code.text);
    isUpgradeToMember = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        await Nav.back();
        NotificationUtils.showDialogSuccess(context, () {
          Nav.back();
        },
            widget: Text(
              S.of(context).member_upgrade_successfull,
              textAlign: TextAlign.center,
            ));
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              res.message ?? "",
              textAlign: TextAlign.center,
            ));
      }
    });
    notifyListeners();
  }
}

class DialogSimpleAutoPopup extends StatefulWidget {
  final int seconds;
  final String message;

  const DialogSimpleAutoPopup({
    super.key,
    required this.seconds,
    required this.message,
  });

  @override
  State<DialogSimpleAutoPopup> createState() => _DialogSimpleAutoPopupState();
}

class _DialogSimpleAutoPopupState extends State<DialogSimpleAutoPopup> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer(
      Duration(seconds: widget.seconds),
      () {
        Nav.back();
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Center(
        child: Text(
          widget.message,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            Nav.back();
          },
          child: Text(S.of(context).close),
        )
      ],
    );
  }
}
