import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/response/promotion/res_post_withdrawl_commision.dart';
import 'package:coolappflutter/presentation/pages/payments/commision/web_view.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:coolappflutter/data/repositories/repo_promotion.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/response/promotion/res_getlist_promotion.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PromotionProvider extends ChangeNotifier {
  // Inisialisasi repository
  final RepoPromotion repoPromotion = RepoPromotion();

  // State loading
  bool isLoadingPromotion = false;
  bool isWithdrawing = false;

  // Data list promotion
  List<Datum>? promotionList;

  List<Datum> get listPromotion => promotionList ?? [];

  // **Get List Promotion**
  Future<void> fetchListPromotion() async {
    isLoadingPromotion = true;
    notifyListeners();

    Either<Failure, ResListPromotion> response = await repoPromotion
        .getlistMeet();

    isLoadingPromotion = false;

    response.when(
      error: (failure) {
        debugPrint("Error fetching promotion list: ${failure.message}");
        notifyListeners();
      },
      success: (res) {
        if (res != null) {
          promotionList = res.data;
          dataGlobal.dataPromotion = res;
          debugPrint("Promotion list fetched successfully");
        } else {
          debugPrint("Failed to fetch promotion list");
          debugPrint(res.message);
        }
        notifyListeners();
      },
    );
  }

  // **Withdraw Commission**
  Future<void> withdrawCommission({
    required String email,
    required String amount,
    required BuildContext context, // Tambahkan context untuk navigasi
  }) async {
    isWithdrawing = true;
    notifyListeners();

    Either<Failure, ResPostWithDrawlCommision> response = await repoPromotion
        .postWithdrawl(
      email: email,
      amount: amount,
    );

    isWithdrawing = false;

    response.when(
      error: (failure) {
        debugPrint("Error withdrawing commission: ${failure.message}");
        NotificationUtils.showDialogError(
          context,
              () {
            Nav.back();
          },
          widget: Text(
            " ${failure.message}",
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
        debugPrint("bawah pop up");
        isWithdrawing = false;
        notifyListeners();
      },
      success: (res) async {
        debugPrint("Withdrawal successful: ${res.message}");

        if (res.success == true && res.data != null && res.data!.url != null) {
          final String url = res.data!.url!;
          final Uri? uri = Uri.tryParse(url);

          if (uri != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewPage(url: url)),
            );
          } else {
            debugPrint("Invalid URL: $url");
          }
        }else{
          NotificationUtils.showDialogError(
            context,
                () {
              Nav.back();
            },
            widget: Text(
              " ${res.message}",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
          isWithdrawing = false;
          notifyListeners();
        }
      },
    );
  }

}
