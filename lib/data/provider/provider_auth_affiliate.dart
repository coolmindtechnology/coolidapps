// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_transaksi_affiliate.dart';
import 'package:coolappflutter/data/repositories/repo_auth_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_cek_is_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_register_affiliate.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/affiliate_register/input_code_referral_affiliate.dart';
import 'package:coolappflutter/presentation/pages/afiliate/home_affiliate.dart';
import 'package:coolappflutter/presentation/pages/afiliate/naf_afiliate.dart';
import 'package:coolappflutter/presentation/pages/main/term_affiliasi.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderAuthAffiliate extends ChangeNotifier {
  RepoAuthAffiliate repoAuthAffiliate = RepoAuthAffiliate();
  DataRegisterAffiliate? dataRegisterAffiliate;
  String? dataCodeReferal;

  bool isRegisterAffiliate = false;
  Future<void> registerAffiliate(
    BuildContext context,
    String referralCode,) async {
    isRegisterAffiliate = true;
    notifyListeners();
    await context
        .read<ProviderTransaksiAffiliate>()
        .getAffiliateManagement(context);

    Either<Failure, ResRegisterffiliate> response =
        await repoAuthAffiliate.registerAffiliate(referralCode);
    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
      isRegisterAffiliate = false;
      notifyListeners();
    }, success: (res) async {
      if (res.success == true) {
        dataRegisterAffiliate = res.data;
        fetchPriceUpgrade(dataRegisterAffiliate?.id.toString() ?? "", context);
        Timer(const Duration(seconds: 4), () {
          isRegisterAffiliate = false;
          notifyListeners();
        });
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              res.message ?? "",
              textAlign: TextAlign.center,
            ));
      }

      notifyListeners();
    });
    notifyListeners();
  }

  final Dio dio = Dio();
  Future<void> fetchPriceUpgrade(String id, BuildContext context) async {
    try {
      debugPrint("cek prices ooo");
      dynamic url =
          '${ApiEndpoint.baseUrl}/api/affiliate/getPriceUpgradeAff/$id';

      final Response response = await dio.get(url);
      debugPrint("cek prices ${response.data['data']["price"].toString()}");

      if (response.statusCode == 200) {
        await context
            .read<ProviderTransaksiAffiliate>()
            .transactionTopupDeposit(
                context,
                id,
                response.data['data']["price"].toString(),
                'other_pay',
                "register",
                 "true"
        );
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("cek prices ooo tesjadi kesalahan $e");
    }
  }

  bool isLoading = false;

  Future<void> autofill(String id, BuildContext context) async {
    try {
      isLoading = true;
      debugPrint("cek prices ooo");
      dynamic url = '${ApiEndpoint.baseUrl}/api/affiliate/referalCodeAgent/$id';
      debugPrint("${ApiEndpoint.baseUrl}/api/affiliate/referalCodeAgent/$id");
      final Response response = await dio.get(url);
      debugPrint("cek prices ${response.data} $isLoading");
      dataCodeReferal = response.data['data']["code"].toString();
      notifyListeners();

      if (response.statusCode == 200) {
        Timer(const Duration(seconds: 2), () {
          isLoading = false;
          notifyListeners();
        });

        debugPrint("cek prices ${response.data} $isLoading");
      } else {
        isLoading = false;
        notifyListeners();

        print('Error: ${response.statusCode}');
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();

      debugPrint("cek prices ooo tesjadi kesalahan code $e");
      notifyListeners();
    }
  }

  DataIsAffiliate? dataIsAffiliate;

  bool isCheckAffiliate = false;
  dynamic dataIdUser;
  Future<void> checkIsAffiliate(
    BuildContext context,
  ) async {
    isCheckAffiliate = true;
    notifyListeners();

    Either<Failure, ResCekIsAffiliate> response =
        await repoAuthAffiliate.checkIsAffiliate();

    isCheckAffiliate = false;
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
      dataIsAffiliate = res.data;

      if (res.success == true && dataIsAffiliate?.isAllow == true) {
        await context
            .read<ProviderTransaksiAffiliate>()
            .getAffiliateManagement(context);
        Nav.to(const NafAffiliate());
      } else if (res.success == true && dataIsAffiliate?.isAllow == false) {
        NotificationUtils.showSimpleDialog2(
          context,
          S.of(context).no_deposit_fee,
          onPress1: () async {
            Nav.back();
            await context
                .read<ProviderTransaksiAffiliate>()
                .getAffiliateManagement(context);
            if (context
                    .read<ProviderTransaksiAffiliate>()
                    .dataAffiliateManagement !=
                null) {
              await context
                  .read<ProviderTransaksiAffiliate>()
                  .transactionTopupDeposit(
                      context,
                      dataIsAffiliate?.idUser.toString() ?? "",
                      context
                              .read<ProviderTransaksiAffiliate>()
                              .dataAffiliateManagement
                              ?.feeCommitment
                              .toString() ??
                          "",
                      'other_pay',
                      "deposit","true");
            }
          },
          onPress2: () {
            Nav.back();
          },
          textButton1: "Ya, Lanjut",
          textButton2: "Tidak",
        );
      } else {
        NotificationUtils.showSimpleDialog2(
          context,
          S.of(context).become_affiliate,
          onPress1: () async {
            debugPrint("cek id from home ${dataIsAffiliate?.idUser}");
            Nav.back();

            Nav.to(const TermHomeAffiliasi());

            // await context
            //     .read<ProviderTransaksiAffiliate>()
            //     .getAffiliateManagement(context);
            // if (context
            //         .read<ProviderTransaksiAffiliate>()
            //         .dataAffiliateManagement !=
            //     null) {
            // Nav.to(const InputCodeReferralAffiliate());
            // }
          },
          onPress2: () {
            Nav.back();
          },
          textButton1: S.of(context).yes_continue,
          textButton2: S.of(context).no,
        );
      }

      notifyListeners();
    });
    notifyListeners();
  }
}
