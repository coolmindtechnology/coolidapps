// ignore_for_file: use_build_context_synchronously

import 'package:cool_app/data/helpers/either.dart';
import 'package:cool_app/data/helpers/failure.dart';
import 'package:cool_app/data/provider/provider_transaksi_affiliate.dart';
import 'package:cool_app/data/repositories/repo_auth_affiliate.dart';
import 'package:cool_app/data/response/affiliate/res_cek_is_affiliate.dart';
import 'package:cool_app/data/response/affiliate/res_register_affiliate.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/affiliate_register/input_code_referral_affiliate.dart';
import 'package:cool_app/presentation/pages/afiliate/naf_afiliate.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderAuthAffiliate extends ChangeNotifier {
  RepoAuthAffiliate repoAuthAffiliate = RepoAuthAffiliate();
  DataRegisterAffiliate? dataRegisterAffiliate;

  bool isRegisterAffiliate = false;
  Future<void> registerAffiliate(
    BuildContext context,
    String referralCode,
  ) async {
    isRegisterAffiliate = true;
    notifyListeners();
    await context
        .read<ProviderTransaksiAffiliate>()
        .getAffiliateManagement(context);

    Either<Failure, ResRegisterffiliate> response =
        await repoAuthAffiliate.registerAffiliate(referralCode);

    isRegisterAffiliate = false;
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
        dataRegisterAffiliate = res.data;

        await context
            .read<ProviderTransaksiAffiliate>()
            .transactionTopupDeposit(
                context,
                dataRegisterAffiliate?.id.toString() ?? "",
                context
                        .read<ProviderTransaksiAffiliate>()
                        .dataAffiliateManagement
                        ?.feeCommitment
                        .toString() ??
                    "",
                'other_pay',
                "register");
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

  DataIsAffiliate? dataIsAffiliate;

  bool isCheckAffiliate = false;
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
                      "deposit");
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
          "Become Affiliate",
          onPress1: () async {
            Nav.back();
            await context
                .read<ProviderTransaksiAffiliate>()
                .getAffiliateManagement(context);
            if (context
                    .read<ProviderTransaksiAffiliate>()
                    .dataAffiliateManagement !=
                null) {
              Nav.to(const InputCodeReferralAffiliate());
            }
          },
          onPress2: () {
            Nav.back();
          },
          textButton1: "Ya, Lanjut",
          textButton2: "Tidak",
        );
      }

      notifyListeners();
    });
    notifyListeners();
  }
}
