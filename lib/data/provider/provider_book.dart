import 'package:cool_app/data/helpers/failure.dart';
import 'package:cool_app/data/repositories/repo_ebook.dart';
import 'package:cool_app/data/response/payments/res_history_detail_ebook.dart';
import 'package:cool_app/data/response/payments/res_history_ebook.dart';
import 'package:cool_app/data/response/res_create_log_ebook.dart';
import 'package:cool_app/data/response/res_list_ebook.dart';
import 'package:cool_app/data/response/res_pre_home.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/payments/pre_invoice_screen.dart';
import 'package:cool_app/presentation/pages/user/reusable_invoice_screen.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../presentation/utils/notification_utils.dart';
import '../data_global.dart';
import '../helpers/either.dart';
import '../response/res_detail_ebook.dart';
import '../response/res_transaksi_ebook.dart';

class ProviderBook extends ChangeNotifier {
  ProviderBook();

  ProviderBook.initHomeBook(BuildContext context) {
    getListEbook(context);
  }

  ProviderBook.initAllBook(BuildContext context) {
    getAllBook(context);
  }

  ProviderBook.initDetailEbook(BuildContext context, {int? id}) {
    getDetailEBook(context, id ?? 0);
  }

  ProviderBook.initPreHome(BuildContext context) {
    getPreHome(context);
  }

  ProviderBook.initHistoryEbook(BuildContext context) {
    getHistoryEbook(context);
  }

  TextEditingController searchController = TextEditingController();

  List<DataBook> get display {
    if (searchController.text.trim().isEmpty) return listAllBook;
    String keyboard = searchController.text.trim();

    List<DataBook> filtered = listAllBook.where((e) {
      var found1 =
          e.title?.toLowerCase().contains(keyboard.toLowerCase()) == true;
      var found2 =
          e.summary?.toLowerCase().contains(keyboard.toLowerCase()) == true;

      return found1 || found2;
    }).toList();

    return filtered;
  }

  List<DataBook> get displayPremium {
    List<DataBook> listPremiumBook =
        listAllBook.where((element) => element.isPremium == "1").toList();
    if (searchController.text.trim().isEmpty) return listPremiumBook;
    String keyboard = searchController.text.trim();

    List<DataBook> filtered = listPremiumBook.where((e) {
      var found1 =
          e.title?.toLowerCase().contains(keyboard.toLowerCase()) == true;
      var found2 =
          e.summary?.toLowerCase().contains(keyboard.toLowerCase()) == true;

      return found1 || found2;
    }).toList();

    return filtered;
  }

  List<DataBook> get displayFree {
    List<DataBook> listFreeBook =
        listAllBook.where((element) => element.isPremium == "0").toList();
    if (searchController.text.trim().isEmpty) return listFreeBook;
    String keyboard = searchController.text.trim();

    List<DataBook> filtered = listFreeBook.where((e) {
      var found1 =
          e.title?.toLowerCase().contains(keyboard.toLowerCase()) == true;
      var found2 =
          e.summary?.toLowerCase().contains(keyboard.toLowerCase()) == true;

      return found1 || found2;
    }).toList();

    return filtered;
  }

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  void toggleSearch() {
    _isSearch = !_isSearch;
    notifyListeners();
  }

  void updateSearchController(String text) {
    searchController.text = text;
    notifyListeners();
  }

  bool isListEbook = false, isAllEbook = false;
  List<DataBook> listEbook = [], listAllBook = [];
  RepoEbook repo = RepoEbook();
  Future<void> getListEbook(BuildContext context) async {
    isListEbook = true;
    notifyListeners();

    Either<Failure, ResListEbook> response = await repo.getListEbook();

    isListEbook = false;
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
      if (res.data != null) {
        listEbook = res.data ?? [];
        notifyListeners();
      } else {
        listEbook = res.data ?? [];
      }
    });
    notifyListeners();
  }

  Future<void> getAllBook(BuildContext context) async {
    isAllEbook = true;
    notifyListeners();

    Either<Failure, ResListEbook> response = await repo.getAllBook();

    isAllEbook = false;
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
      if (res.data != null) {
        listAllBook = res.data ?? [];
        notifyListeners();
      } else {
        listAllBook = res.data ?? [];
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool isDetailEbook = false;
  Data? dataEbook;
  Future<void> getDetailEBook(BuildContext context, int id) async {
    isAllEbook = true;
    notifyListeners();

    Either<Failure, ResDetailEbook> response = await repo.getDetailEbook(id);

    isAllEbook = false;
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
      if (res.data != null) {
        dataEbook = res.data;
        notifyListeners();
      } else {
        dataEbook = res.data;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool isPreHome = false;
  DataPre? dataPre;
  Future<void> getPreHome(BuildContext context) async {
    isAllEbook = true;
    notifyListeners();

    Either<Failure, ResPreHome> response = await repo.getPreHome();

    isAllEbook = false;
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
      if (res.data != null) {
        dataPre = res.data;

        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  bool isCreateLogEbook = false;
  Future<void> createLogEbook(BuildContext context, int idEbook) async {
    isCreateLogEbook = true;
    notifyListeners();

    Either<Failure, ResCreateLogEbook> response =
        await repo.createLogEbook(idEbook);

    isCreateLogEbook = false;
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
        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  bool isPaymentEbook = false;
  Future<void> paymentEbook(
      BuildContext context, int idEbook, String price, String transactionType,
      {Function? onUpdate}) async {
    isPaymentEbook = true;
    notifyListeners();

    Either<Failure, ResTransaksiEbook> response = await repo.paymentEbook(
        idEbook, price, transactionType,
        gateway: dataGlobal.isIndonesia ? 'midtrans' : 'paypal');

    isPaymentEbook = false;
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
      if (kDebugMode) {
        print("log id order ${res.data?.orderId}");
      }
      if (res.success == true) {
        Nav.to(PreInvoiceScreen(
          currencyPaypal: res.data?.currencyPaypal,
          snapToken: res.data?.snapToken,
          id: res.data?.orderId,
          paymentType: res.data?.transactionType,
          date: res.data?.createdAt,
          discount: res.data?.discount,
          amount: dataGlobal.isIndonesia
              ? res.data?.totalAmount
              : res.data?.amountPaypal,
          onUpdate: () {
            onUpdate!();
            Nav.back();
          },
        ));

        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  bool isGetHistoryEbook = false;
  List<DataHistoryEbook> dataHistoryEbook = [];

  Future<void> getHistoryEbook(BuildContext context) async {
    isGetHistoryEbook = true;
    notifyListeners();
    Either<Failure, ResHistoryEbook> response =
        await repo.getHistoryPaymentEbook();

    isGetHistoryEbook = false;
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
    }, success: (ResHistoryEbook success) {
      dataHistoryEbook = success.data ?? [];
    });
    notifyListeners();
  }

  bool isGetHistoryDetailEbook = false;
  DataDetailHistoryEbook? dataHistoryDetailEbook;

  Future<void> getHistoryDetailEbook(BuildContext context, String id) async {
    isGetHistoryDetailEbook = true;
    notifyListeners();
    Either<Failure, ResDetailHistoryEbook> response =
        await repo.gerhistoryDetailEbook(id);

    isGetHistoryDetailEbook = false;
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
      dataHistoryDetailEbook = success.data;
      Nav.to(ReusableInvoiceScreen(
        id: dataHistoryDetailEbook?.orderId,
        paymentType: dataHistoryDetailEbook?.paymentType,
        discount: dataHistoryDetailEbook?.discount,
        amount: dataHistoryDetailEbook?.totalAmount,
        date: dataHistoryDetailEbook?.createdAt,
        isHistory: true,
        quantity: "e-book - ${dataHistoryDetailEbook?.title}",
      ));
    });
    notifyListeners();
  }
}
