import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/repositories/repo_transaksi_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_history_outcome_real_money.dart';
import 'package:coolappflutter/data/response/affiliate/res_history_real_money.dart';
import 'package:coolappflutter/data/response/affiliate/res_home_affiliate.dart';
import 'package:coolappflutter/data/response/affiliate/res_invoice_realmooney.dart';
import 'package:coolappflutter/data/response/affiliate/res_invoice_witdraw.dart';
import 'package:coolappflutter/data/response/convert_currency/convert_currency.dart';
import 'package:coolappflutter/data/response/transaksi/res_create_withdraw.dart';
import 'package:coolappflutter/data/response/transaksi/res_create_withdraw_banned_account.dart';
import 'package:coolappflutter/data/response/transaksi/res_get_affiliate_management.dart';
import 'package:coolappflutter/data/response/transaksi/res_get_single_total_saldo.dart';
import 'package:coolappflutter/data/response/transaksi/res_history_saldo_reduction.dart';
import 'package:coolappflutter/data/response/transaksi/res_history_topup_affiliate.dart';
import 'package:coolappflutter/data/response/transaksi/res_invoice_saldo.dart';
import 'package:coolappflutter/data/response/transaksi/res_transaction_topup_deposit.dart';
import 'package:coolappflutter/data/response/transaksi/res_update_transaction_saldo_with_real_money.dart';
import 'package:coolappflutter/presentation/pages/affiliate_register/invoice_register_affiliate.dart';
import 'package:coolappflutter/presentation/pages/transakction/voucher_page.dart';
import 'package:coolappflutter/presentation/pages/user/reusable_invoice_screen.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProviderTransaksiAffiliate extends ChangeNotifier {
  RepoTransaksiAffiliate repoTransaksiAffiliate = RepoTransaksiAffiliate();

  DataPaginationHistoryTopupSaldo? dataPaginationHistoryTopupSaldo;
  List<DataHistoryTopupAffiliate> listHistoryTopupSaldo = [];
  int pageHistoryIncomeSaldo = 1;
  bool hasMoreHistoryIncomeSaldo = true;
  final int _limitHistoryIncomeSaldo = 10;
  String getResultConvertCurencyValue = "";

  bool isLoadingHistoryTopup = false;

  Future<void> getConvertCurrency(
    BuildContext context,
    double amount,
  ) async {
    Either<Failure, ConvertCurrencyModel> response =
        await repoTransaksiAffiliate.getConvertcurrency(amount);

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      debugPrint("cek conver currency from api ${res.data.toString()}");
      getResultConvertCurencyValue = res.data.toString();

      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> getHistoryTopup(
    BuildContext context,
    String filter,
  ) async {
    Either<Failure, ResHistoryTopupAffiliate> response =
        await repoTransaksiAffiliate.getHistoryTopupAffiliate(
      pageHistoryIncomeSaldo,
      filter,
    );

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      // listDataHistoryTopup = res.data ?? [];
      // getFilteredHistoryTopupDeposit(null);

      dataPaginationHistoryTopupSaldo = res.data;

      if (dataPaginationHistoryTopupSaldo?.nextPageUrl == null) {
        hasMoreHistoryIncomeSaldo = false;
      }
      listHistoryTopupSaldo.addAll(dataPaginationHistoryTopupSaldo?.data ?? []);
      pageHistoryIncomeSaldo++;
      notifyListeners();
    });
    notifyListeners();
  }

  bool isLoadingHistoryRealMoney = false;
  Future<void> getHistoryRealMoney(
    BuildContext context,
    String filter,
  ) async {
    Either<Failure, ResHistoryRealMoney> response =
        await repoTransaksiAffiliate.getHistoryRealMoney(
      pageHistoryIncomeRealMoney,
      filter,
    );

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      // listDataHistoryTopup = res.data ?? [];
      // getFilteredHistoryTopupDeposit(null);

      dataPaginationHistoryRealMoney = res.data;

      ///for pagination
      if (dataPaginationHistoryRealMoney?.nextPageUrl == null) {
        hasMoreHistoryIncomeRealMoney = false;
      }
      listHistoryRealMoney.addAll(dataPaginationHistoryRealMoney?.data ?? []);
      pageHistoryIncomeRealMoney++;
      notifyListeners();
    });
    notifyListeners();
  }

  /// Refreshes the history of income saldo by resetting the page and list,
  /// setting the loading state to true, and calling the `getHistoryTopup`
  /// function with the provided `context` and `filter`.
  ///
  /// Parameters:
  /// - `context`: The build context.
  /// - `filter`: The filter to apply to the history.
  ///
  /// Returns: A `Future` that completes when the history is refreshed.
  Future refreshHistoryIncomeSaldo(BuildContext context, String filter) async {
    isLoadingHistoryTopup = true;

    notifyListeners();
    pageHistoryIncomeSaldo = 1;
    listHistoryTopupSaldo = [];
    hasMoreHistoryIncomeSaldo = true;
    await getHistoryTopup(context, filter);
    isLoadingHistoryTopup = false;
    notifyListeners();
  }

  DataPaginationHistoryRealMoney? dataPaginationHistoryRealMoney;
  List<HistoryRealMoney> listHistoryRealMoney = [];
  int pageHistoryIncomeRealMoney = 1;
  bool hasMoreHistoryIncomeRealMoney = true;
  // Refreshes the history of real money income.
  //
  // Parameters:
  //   context: The build context.
  //   filter: The filter to apply.
  //
  // Returns:
  //   A future representing the completion of the function.
  Future refreshHistoryIncomeRealMoney(
      BuildContext context, String filter) async {
    isLoadingHistoryRealMoney = true;

    notifyListeners();
    pageHistoryIncomeRealMoney = 1;
    listHistoryRealMoney = [];
    hasMoreHistoryIncomeRealMoney = true;
    await getHistoryRealMoney(context, filter);
    isLoadingHistoryRealMoney = false;
    notifyListeners();
  }

  DataPaginationOutcomeHistoryRealMoney?
      dataPaginationHistoryRealMoneyWithdrawal;
  List<HistoryOutcomeRealMoney> listHistoryRealMoneyWithdrawal = [];
  int pageHistoryIncomeRealMoneyWithdrawal = 1;
  bool hasMoreHistoryIncomeRealMoneyWithdrawal = true;
  bool isLoadingHistoryRealMoneyWithdrawal = false;
  // Refreshes the history of real money withdrawal by setting loading states,
  // resetting lists, and calling the `getHistoryRealMoneyWithdrawal` function.
  //
  // Parameters:
  //   context: The build context.
  //   filter: The filter to apply.
  //
  // Returns:
  //   A future representing the completion of the function.
  Future refreshHistoryRealMoneyWithdrawal(
      BuildContext context, String filter) async {
    isLoadingHistoryRealMoneyWithdrawal = true;
    notifyListeners();
    listHistoryRealMoneyWithdrawal = [];
    pageHistoryIncomeRealMoneyWithdrawal = 1;
    hasMoreHistoryIncomeRealMoneyWithdrawal = true;
    notifyListeners();
    await getHistoryRealMoneyWithdrawal(context, filter);
    isLoadingHistoryRealMoneyWithdrawal = false;
    notifyListeners();
  }

  /// Retrieves the history of real money withdrawals based on the given [filter] and [context].
  ///
  /// The [context] is used to display error dialogs if an error occurs during the retrieval.
  /// The [filter] is used to filter the history based on specific criteria.
  ///
  /// This function makes an asynchronous request to the server to retrieve the history of real money withdrawals.
  /// It uses the [repoTransaksiAffiliate.getHistoryRealMoneyWithdrawal] method to get the data.
  /// The retrieved data is stored in [dataPaginationHistoryRealMoneyWithdrawal].
  /// If the retrieved data is not null, it is added to the [listHistoryRealMoneyWithdrawal].
  /// The [pageHistoryIncomeRealMoneyWithdrawal] is incremented after each successful retrieval.
  ///
  /// If an error occurs during the retrieval, an error dialog is displayed using the [NotificationUtils.showDialogError] method.
  /// The error dialog contains the error message obtained from the [Failure] object.
  ///
  /// This function notifies the listeners after each successful retrieval.
  ///
  /// Parameters:
  /// - [context]: The build context used for displaying error dialogs.
  /// - [filter]: The filter to apply to the history of real money withdrawals.
  ///
  /// Returns: A `Future` that completes when the history of real money withdrawals is retrieved.
  Future<void> getHistoryRealMoneyWithdrawal(
    BuildContext context,
    String filter,
  ) async {
    Either<Failure, ResHistoryOutcomeRealMoney> response =
        await repoTransaksiAffiliate.getHistoryRealMoneyWithdrawal(
      pageHistoryIncomeRealMoneyWithdrawal,
      filter,
    );

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      dataPaginationHistoryRealMoneyWithdrawal = res.data;
      if (kDebugMode) {
        print(
            "dataa baru ${dataPaginationHistoryRealMoneyWithdrawal?.data?[0].toJson()}");
      }

      if (dataPaginationHistoryRealMoneyWithdrawal?.nextPageUrl == null) {
        hasMoreHistoryIncomeRealMoneyWithdrawal = false;
      }
      listHistoryRealMoneyWithdrawal
          .addAll(dataPaginationHistoryRealMoneyWithdrawal?.data ?? []);
      pageHistoryIncomeRealMoneyWithdrawal++;
      notifyListeners();
    });
    notifyListeners();
  }

  bool isTransactionTopupDeposit = false;

  /// Asynchronously performs a top-up deposit transaction.
  ///
  /// Takes in the following parameters:
  /// - `context`: The build context of the widget.
  /// - `id`: The ID of the transaction.
  /// - `nominal`: The nominal value of the transaction.
  /// - `source`: The source of the transaction.
  /// - `fromPage`: The page from which the transaction originated.
  ///
  /// This function sets the `isTransactionTopupDeposit` flag to `true`, notifies the listeners,
  /// and then calls the `transactionTopupDeposit` method of the `repoTransaksiAffiliate` object
  /// with the provided parameters. After the transaction is complete, the flag is set back to `false`
  /// and the listeners are notified.
  ///
  /// If the transaction is successful, the function navigates to different screens based on the
  /// value of `fromPage`. If `fromPage` is "register", it replaces the current screen with the
  /// `InvoiceRegisterAffiliate` widget. If `fromPage` is "deposit", it navigates to the
  /// `InvoiceRegisterAffiliate` widget. If `fromPage` is "topup", it navigates to the `VoucherPage`
  /// widget.
  ///
  /// Finally, the listeners are notified again.
  ///
  /// Returns a `Future<void>`.
  Future<void> transactionTopupDeposit(
    BuildContext context,
    String id,
    String nominal,
    String source,
    String fromPage,
  ) async {
    isTransactionTopupDeposit = true;

    notifyListeners();

    Either<Failure, ResTransactionTopupDeposit> response =
        await repoTransaksiAffiliate.transactionTopupDeposit(
            id, nominal, source);

    isTransactionTopupDeposit = false;
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
      debugPrint("cek apa ini serius? $fromPage");
      var data = res.data;

      if (fromPage == "register") {
        Nav.replace(InvoiceRegisterAffiliate(
          name: data?.customer,
          orderId: data?.orderId,
          date: data?.createdAt,
          amount: data?.amount,
          paymentType: data?.item,
          snapToken: data?.snapToken,
        ));
      } else if (fromPage == "deposit") {
        Nav.to(InvoiceRegisterAffiliate(
          name: data?.customer,
          orderId: data?.orderId,
          date: data?.createdAt,
          amount: data?.amount,
          paymentType: data?.item,
          snapToken: data?.snapToken,
        ));
      } else if (fromPage == "topup") {
        Nav.to(VoucherPage(
          amount: data?.amount,
          orderId: data?.orderId,
          isIndonesia: true,
          resultCenvertCurrency: getResultConvertCurencyValue.toString(),
          isWithdraw: false,
          date: data?.createdAt,
          paymentType: data?.item,
          snapToken: data?.snapToken,
          source: data?.source,
          id: data?.id.toString(),
        ));
      }

      notifyListeners();
    });
    notifyListeners();
  }

  DataPaginationSaldoReduction? dataPaginationReductionSaldo;
  List<DataHistorySaldoReduction> listHistoryReductionSaldo = [];
  int pageHistoryReductionSaldo = 1;
  bool hasMoreHistoryReductionSaldo = true;
  final int _limitHistoryReductionSaldo = 10;

  bool isLoadingHistorySaldoReduction = false;
  Future<void> getHistorySaldoReduction(
    BuildContext context,
    String filter,
  ) async {
    Either<Failure, ResHistorySaldoReduction> response =
        await repoTransaksiAffiliate.getHistorySaldoReduction(
            pageHistoryReductionSaldo, filter);

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      dataPaginationReductionSaldo = res.data;

      if (dataPaginationReductionSaldo?.nextPageUrl == null) {
        hasMoreHistoryReductionSaldo = false;
      }
      listHistoryReductionSaldo
          .addAll(dataPaginationReductionSaldo?.data ?? []);
      pageHistoryReductionSaldo++;

      notifyListeners();
    });
    notifyListeners();
  }

  Future refreshHistoryReductionSaldo(
      BuildContext context, String filter) async {
    isLoadingHistorySaldoReduction = true;

    notifyListeners();
    pageHistoryReductionSaldo = 1;
    listHistoryReductionSaldo = [];
    hasMoreHistoryReductionSaldo = true;
    await getHistorySaldoReduction(context, filter);
    isLoadingHistorySaldoReduction = false;
    notifyListeners();
  }

  bool isGetSingleTotalSaldoAffiliate = false;
  DataSingleTotalSaldo? dataSingleTotalSaldoAffiliate;
  Future<void> getSingleTotalSaldoAffiliate(BuildContext context) async {
    isGetSingleTotalSaldoAffiliate = true;
    notifyListeners();

    Either<Failure, ResGetSingleTotalSaldo> response =
        await repoTransaksiAffiliate.getSingleTotalSaldo(true);
    isGetSingleTotalSaldoAffiliate = false;
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
      dataSingleTotalSaldoAffiliate = res.data;
      notifyListeners();
    });
    notifyListeners();
  }

  bool isGetSingleTotalRealMoney = false;
  DataSingleTotalSaldo? dataSingleTotalRealMoney;
  Future<void> getSingleTotalRealMoney(
    BuildContext context,
  ) async {
    isGetSingleTotalRealMoney = true;
    notifyListeners();

    Either<Failure, ResGetSingleTotalSaldo> response =
        await repoTransaksiAffiliate.getSingleTotalSaldo(false);
    isGetSingleTotalRealMoney = false;
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
      dataSingleTotalRealMoney = res.data;
      notifyListeners();
    });
    notifyListeners();
  }

  bool isGetInvoiceSaldo = false;
  DataInvoiceSaldo? dataInvoiceSaldo;
  Future<void> getInvoiceSaldo(BuildContext context, String id) async {
    isGetInvoiceSaldo = true;
    notifyListeners();

    Either<Failure, ResInvoiceSaldo> response =
        await repoTransaksiAffiliate.getInvoiceSaldo(id);
    isGetInvoiceSaldo = false;
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
      dataInvoiceSaldo = res.data;
      Nav.to(ReusableInvoiceScreen(
        id: dataInvoiceSaldo?.orderId,
        paymentType: dataInvoiceSaldo?.transactionType,
        amount: dataInvoiceSaldo?.amount,
        name: dataInvoiceSaldo?.customer,
        date: dataInvoiceSaldo?.transactionDate,
        source: dataInvoiceSaldo?.source,
        isHistory: true,
      ));
      notifyListeners();
    });
    notifyListeners();
  }

  bool isUpdateTransactionSaldoWithRealMoney = false;
  Future<void> updateTransactionSaldoWithRealMoney(
    BuildContext context,
    String id,
  ) async {
    isUpdateTransactionSaldoWithRealMoney = true;

    notifyListeners();

    Either<Failure, ResUpdateTransactionSaldoWithRealMoney> response =
        await repoTransaksiAffiliate.updateTransactionSaldoWithRealMoney(
      id,
    );

    isUpdateTransactionSaldoWithRealMoney = false;
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
      Nav.back();
      Nav.back(data: "topup_affiliate");

      notifyListeners();
    });
    notifyListeners();
  }

  /// REAL MONEY
  List<HistoryRealMoney> listDataHistoryRealMoney = [];
  List<HistoryRealMoney> filteredDataHistoryRealMoney = [];

  Future<void> getFilteredHistoryRealMoney(DateTime? date) async {
    if (date == null) {
      filteredDataHistoryRealMoney = listDataHistoryRealMoney;
    } else {
      filteredDataHistoryRealMoney = listDataHistoryRealMoney
          .where((element) => element.createdAt!.isAfter(date))
          .toList();
    }

    notifyListeners();
  }

  // bool isLoadingHistoryRealMoney = false;
  // Future<void> getHistoryRealMoney(
  //   BuildContext context,
  // ) async {
  //   isLoadingHistoryRealMoney = true;
  //
  //   notifyListeners();
  //
  //   Either<Failure, ResHistorySaldoReduction> response =
  //       await repoTransaksiAffiliate.getHistorySaldoReduction(1, "");
  //
  //   isLoadingHistoryRealMoney = false;
  //   notifyListeners();
  //
  //   response.when(error: (e) {
  //     NotificationUtils.showDialogError(context, () {
  //       Nav.back();
  //     },
  //         widget: Text(
  //           e.message,
  //           textAlign: TextAlign.center,
  //         ));
  //   }, success: (res) async {
  //     listDataHistorySaldoReduction = res.data ?? [];
  //     getFilteredHistorySaldoReduction(null);
  //     notifyListeners();
  //   });
  //   notifyListeners();
  // }

  DataAffiliasi? dataAffiliasi;
  bool isCreateWithdraw = false;
  Future<void> createWithdraw(
    BuildContext context,
    String amount,
  ) async {
    isCreateWithdraw = true;
    notifyListeners();

    var dataBank = dataAffiliasi;

    Either<ResCreateWithdraw, ResCreateWithdraw> response =
        await repoTransaksiAffiliate.createWithdraw(
      amount, dataGlobal.dataAff?.bankNumber ?? "",
          dataGlobal.dataAff?.bankAccountName ?? "",
          dataGlobal.dataAff?.bankName ?? "",
          dataGlobal.dataAff?.user?.email ?? "",
    );
    isCreateWithdraw = false;
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
        var data = res.data;
        debugPrint(
            "cek get currency ${getResultConvertCurencyValue.toString()}");
        Nav.to(VoucherPage(
          amount: data?.amount,
          orderId: data?.referenceNo,
          resultCenvertCurrency: getResultConvertCurencyValue.toString(),
          isIndonesia: true,
          isWithdraw: true,
          date: data?.createdAt,
          paymentType: data?.transactionType,
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

  bool isGetAffiliateManagement = false;
  DataAffiliateManagement? dataAffiliateManagement;
  int _minWithdraw = 0;
  int _maxWithdraw = 0;
  int _minTopup = 0;
  int _maxTopup = 0;
  int _minTopupInt = 0;
  int _maxTopupInt = 0;
  int get minWithdraw => _minWithdraw;
  int get maxWithdraw => _maxWithdraw;

  int get minTopup => _minTopup;
  int get maxTopup => _maxTopup;
  int get minTopupInt => _minTopupInt;
  int get maxTopupInt => _maxTopupInt;

  Future<void> getAffiliateManagement(BuildContext context) async {
    isGetAffiliateManagement = true;
    notifyListeners();

    Either<Failure, ResGetAffiliateManagement> response =
        await repoTransaksiAffiliate.getAffiliateManagement();
    isGetAffiliateManagement = false;
    notifyListeners();
    print("prikitiw");
    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true && res.data != null) {
        dataAffiliateManagement = res.data;
        _minWithdraw =
            int.parse(dataAffiliateManagement?.withdrawMinimum ?? '0');
        _maxWithdraw =
            int.parse(dataAffiliateManagement?.withdrawMaximum ?? '0');
        _minTopup = int.parse(dataAffiliateManagement?.mininumDeposit ?? '0');
        _maxTopup = int.parse(dataAffiliateManagement?.maximumDeposit ?? '0');
        _minTopupInt =
            int.parse(dataAffiliateManagement?.intlMininumDeposit ?? '0');
        _maxTopupInt =
            int.parse(dataAffiliateManagement?.intlMaximumDeposit ?? '0');
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
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

  bool isGetInvoiceWithdraw = false;
  DataInvoiceWidraw? dataInvoiceWidraw;
  Future<void> getInvoiceWithdraw(BuildContext context, String id) async {
    isGetInvoiceWithdraw = true;
    notifyListeners();

    Either<Failure, ResInvoiceWithdrawal> response =
        await repoTransaksiAffiliate.getInvoiceWithdraw(id);
    isGetInvoiceWithdraw = false;
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
      dataInvoiceWidraw = res.data;
      Nav.to(ReusableInvoiceScreen(
        id: dataInvoiceSaldo?.orderId,
        paymentType: dataInvoiceSaldo?.transactionType,
        amount: dataInvoiceSaldo?.amount,
        name: dataInvoiceSaldo?.customer,
        date: dataInvoiceSaldo?.transactionDate,
        source: dataInvoiceSaldo?.source,
        isHistory: true,
      ));
      notifyListeners();
    });
    notifyListeners();
  }

  bool isGetInvoiceRealMoney = false;
  DataInvoiceRealMoney? dataInvoiceRealMoney;
  Future<void> getInvoiceRealMoney(BuildContext context, String id) async {
    isGetInvoiceRealMoney = true;
    notifyListeners();

    Either<Failure, ResInvoiceRealMoney> response =
        await repoTransaksiAffiliate.getInvoiceRealMoney(id);
    isGetInvoiceRealMoney = false;
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
      dataInvoiceRealMoney = res.data;
      Nav.to(ReusableInvoiceScreen(
        id: dataInvoiceRealMoney?.referenceNo,
        paymentType: dataInvoiceRealMoney?.transactionType,
        amount: dataInvoiceRealMoney?.amount,
        name: dataInvoiceRealMoney?.user?.name,
        date: dataInvoiceRealMoney?.createdAt,
        source: "",
        isHistory: true,
      ));
      notifyListeners();
    });
    notifyListeners();
  }

  bool isCreateTransactionLastWithdraw = false;
  Future<void> createTransactionLastWithdraw(
    BuildContext context,
  ) async {
    isCreateTransactionLastWithdraw = true;
    notifyListeners();

    var dataBank = dataAffiliasi;

    Either<ResCreateWithdrawBanned, ResCreateWithdrawBanned> response =
        await repoTransaksiAffiliate.createTransactionLastWithdraw(
      dataBank?.bankNumber ?? "",
      dataBank?.bankAccountName ?? "",
      dataBank?.bankName ?? "",
      dataBank?.user?.email ?? "",
    );
    isCreateTransactionLastWithdraw = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
        Nav.back();
        Nav.back();
      },
          widget: Text(
            e.data.toString(),
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      if (res.success == true) {
        NotificationUtils.showDialogSuccess(context, () {
          Nav.back();
          Nav.back();
          Nav.back();
        },
            widget: Text(
              " ${res.data.toString()}" ?? "",
              textAlign: TextAlign.center,
            ));
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
          Nav.back();
          Nav.back();
        },
            widget: Text(
              res.data.toString(),
              textAlign: TextAlign.center,
            ));
      }
    });
    notifyListeners();
  }
}
