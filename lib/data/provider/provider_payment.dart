import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
import 'package:coolappflutter/data/repositories/repo_payment.dart';
import 'package:coolappflutter/data/response/payments/res_create_data_topup_transaction.dart';
import 'package:coolappflutter/data/response/payments/res_get_amount_deposit.dart';
import 'package:coolappflutter/data/response/payments/res_get_data_top_up.dart';
import 'package:coolappflutter/data/response/payments/res_get_invoice_brain_activation.dart';
import 'package:coolappflutter/data/response/payments/res_history_brain_activation.dart';
import 'package:coolappflutter/data/response/payments/res_history_topup.dart';
import 'package:coolappflutter/data/response/payments/res_invoice_transaction.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/payments/pre_invoice_screen.dart';
import 'package:coolappflutter/presentation/pages/payments/top_up_page.dart';
import 'package:coolappflutter/presentation/pages/user/reusable_invoice_screen.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';

import '../data_global.dart';

class ProviderPayment extends ChangeNotifier {
//   ProviderPayment();
//   ProviderPayment.getListTpUp(BuildContext context) {
//     getListTopUp(context);
//   }
//   ProviderPayment.getAmountDeposit(BuildContext context) {
//     getAmoutDeposit(context);
//   }
//   ProviderPayment.getHistoryTopup(BuildContext context) {
//     getHistoryTopup(context);
//   }

//   ProviderPayment.getHistoryBrain(BuildContext context) {
//     getHistoryBrainActivation(context);
//   }

//   ProviderPayment.getInvoice(BuildContext context, String? id) {
//     getInvoice(context, id);
//   }
  RepoPayment repoPayment = RepoPayment();
  bool isLoading = false;

  List<DataListTopUp>? listDataListTopUp;

  String _totalDeposit = "0";

  // Getter untuk totalDeposit
  String get totalDeposit => _totalDeposit;

  // Setter untuk totalDeposit
  set totalDeposit(String newTotalDeposit) {
    _totalDeposit = newTotalDeposit;
    // Memberi tahu pendengar bahwa nilai totalDeposit telah berubah
    notifyListeners();
  }

  bool isLoadingListPro = false;
  Future<void> getListTopUp(
    BuildContext context,
  ) async {
    isLoadingListPro = true;
    notifyListeners();

    Either<Failure, ResGetDataTopUp> response =
        await repoPayment.getListTopUp();

    isLoadingListPro = false;
    notifyListeners();

    response.when(error: (e) {
      debugPrint("tes topup3 ${e.toString()}");
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        listDataListTopUp = res.data;
        dataGlobal.dataTopUp = res;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool isLoadingListTopUp = false;
  Future<void> cekListTopUp(
      BuildContext context,
      ) async {
    isLoadingListTopUp = true;
    notifyListeners();

    Either<Failure, ResGetDataTopUp> response =
    await repoPayment.getListTopUp();

    isLoadingListTopUp = false;
    notifyListeners();

    response.when(error: (e) {
      debugPrint("tes topup3 ${e.toString()}");
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        Nav.to(const TopUpPage());
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool isCreatePayment = false;
  Future<void> createTopupTransaction(
      BuildContext context, DataCheckoutTransaction dataCheckoutTransaction,
      {Function? onUpdate}) async {
    isCreatePayment = true;
    notifyListeners();

    Either<Failure, ResCreateTopupTransaction> response =
        await repoPayment.createTopupTransaction(dataCheckoutTransaction);

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
      if (res.success == true) {
        Nav.to(PreInvoiceScreen(
          snapToken: res.data?.snapToken,
          orderId: res.data?.orderId,
          paymentType: res.data?.transactionType,
          date: res.data?.createdAt,
          discount: res.data?.discount,
          currencyPaypal: res.data?.currencyPaypal,
          amount: dataGlobal.isIndonesia
              ? res.data?.totalAmount
              : res.data?.amountPaypal,
          onUpdate: onUpdate,
        ));
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              S.of(context).unknown_error_occurred,
              textAlign: TextAlign.center,
            ));
      }
    });

    notifyListeners();
  }

  DataTotalDeposit? dataTotalDeposit;
  Future<void> getAmoutDeposit(
    BuildContext context,
  ) async {
    isLoading = true;

    notifyListeners();

    Either<Failure, ResGetAmountDeposit> response =
        await repoPayment.getShowDeposit();

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
      dataTotalDeposit = res.data;
      totalDeposit = dataTotalDeposit?.totalDeposit ?? "0";

      notifyListeners();
    });
    notifyListeners();
  }

  List<DataHistoryTopup> listDataHistoryTopup = [];
  List<DataHistoryTopup> getFilteredHistory(String status) {
    return listDataHistoryTopup
        .where((element) => element.status == status)
        .toList();
  }

  bool isLoadingHistoryTopu = false;
  Future<void> getHistoryTopup(
    BuildContext context,
  ) async {
    isLoadingHistoryTopu = true;

    notifyListeners();

    Either<Failure, ResHistoryTopup> response =
        await repoPayment.getHistoryTopup();

    isLoadingHistoryTopu = false;
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
      listDataHistoryTopup = res.data ?? [];
      notifyListeners();
    });
    notifyListeners();
  }

  bool isLoadingInvoice = false;
  DataInvoiceTransaction? dataInvoice;
  Future<void> getInvoice(BuildContext context, String? id) async {
    isLoadingInvoice = true;

    notifyListeners();

    Either<Failure, ResInvoiceTransaction> response =
        await repoPayment.getInvoice(id);

    isLoadingInvoice = false;
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
      dataInvoice = res.data;

      notifyListeners();
    });
    notifyListeners();
  }

  bool isLoadingHistoryBrainActivation = false;
  List<DataHistoryBrainActivation> dataHistoryBrainActivation = [];
  Future<void> getHistoryBrainActivation(
    BuildContext context,
  ) async {
    isLoadingHistoryBrainActivation = true;

    notifyListeners();

    Either<Failure, ResHistoryBrainActivation> response =
        await repoPayment.getHistoryBrainActivation();

    isLoadingHistoryBrainActivation = false;
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
      dataHistoryBrainActivation = res.data ?? [];
      notifyListeners();
    });
    notifyListeners();
  }

  bool isGetHistoryBrain = false;
  DataInvoiceBrainActivation? dataInvoiceBrainActivation;
  Future<void> getInvoiceBrain(BuildContext context, String id) async {
    isGetHistoryBrain = true;
    notifyListeners();
    Either<Failure, ResGetInvoiceBrainAcitovation> response =
        await repoPayment.getInvoiceBrain(id);

    isGetHistoryBrain = false;
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
    }, success: (success) {
      dataInvoiceBrainActivation = success.data;
      Nav.to(ReusableInvoiceScreen(
        id: dataInvoiceBrainActivation?.orderId,
        paymentType: dataInvoiceBrainActivation?.paymentType,
        discount: dataInvoiceBrainActivation?.discount,
        amount: dataInvoiceBrainActivation?.totalAmount,
        date: dataInvoiceBrainActivation?.createdAt,
        isHistory: true,
        quantity:
            "${dataInvoiceBrainActivation?.itemPayment} - ${dataInvoiceBrainActivation?.name}",
      ));
    });
    notifyListeners();
  }
}
