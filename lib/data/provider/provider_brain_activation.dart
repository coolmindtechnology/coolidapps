import 'package:cool_app/data/models/subcribtion_brain_transaction_data_model.dart';
import 'package:cool_app/data/networks/dio_handler.dart';
import 'package:cool_app/data/repositories/repo_brain.dart';
import 'package:cool_app/data/response/brain_activation/rec_cek_daily.dart';
import 'package:cool_app/data/response/brain_activation/res_check_allow_subcribe.dart';
import 'package:cool_app/data/response/brain_activation/res_list_brain_activation.dart';
import 'package:cool_app/data/response/brain_activation/res_list_subcription_all_item.dart';
import 'package:cool_app/data/response/brain_activation/res_list_subcription_per_item.dart';
import 'package:cool_app/data/response/brain_activation/res_show_price_subcribe_brain.dart';
import 'package:cool_app/data/response/brain_activation/res_subcribe_brain_transaction.dart';
import 'package:cool_app/data/response/brain_activation/res_timer_play.dart';
import 'package:cool_app/data/response/brain_activation/res_transaksi_brain_activation.dart';
import 'package:cool_app/data/response/payments/res_create_data_transaction.dart';
import 'package:cool_app/data/response/res_update_payment.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/payments/pre_invoice_screen.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../presentation/utils/nav_utils.dart';
import '../../presentation/utils/notification_utils.dart';
import '../data_global.dart';
import '../helpers/either.dart';
import '../helpers/failure.dart';

class ProviderBrainActivation extends ChangeNotifier {
  ProviderBrainActivation() {
    assert(() {
      return true;
    }());
  }
  ProviderBrainActivation.tes(BuildContext context, String id) {
    // tes();
    getListBrain(context, id);
  }

  ProviderBrainActivation.cekDaily(BuildContext context, {int? idAudio}) {
    getCekDaily(context, idAudio ?? 0);
  }
  List<int>? tesDuration;
  List<double>? audioData;
  String url =
      "http://ia802609.us.archive.org/13/items/quraninindonesia/001AlFaatihah.mp3";

  void tes() async {
    // Mengunduh file MP3

    final Response<List<int>> response =
        await dio.get(url, options: Options(responseType: ResponseType.bytes));
    if (response.statusCode == 200) {
      tesDuration = response.data!;
      // Mengonversi respons ke Uint8List
      // final Uint8List mp3Bytes = Uint8List.fromList(response.data!);
      // audioData = processAudio(mp3Bytes);

      audioData = loadparseJson(response.data!);
      // Memberi tahu pendengar (listener) bahwa nilai telah berubah
      notifyListeners();
    } else {
      if (kDebugMode) {
        if (kDebugMode) {
          print(
              'Gagal mengunduh file MP3, status code: ${response.statusCode}');
        }
      }
    }
  }

  List<double> processAudio(Uint8List mp3Bytes) {
    return mp3Bytes.map((byte) => byte.toDouble()).toList();
  }

  List<double> loadparseJson(List<int> jsonBody) {
    final List<int> points = jsonBody;
    List<int> filteredData = [];
    // Change this value to number of audio samples you want.
    // Values between 256 and 1024 are good for showing [RectangleWaveform] and [SquigglyWaveform]
    // While the values above them are good for showing [PolygonWaveform]
    const int samples = 256;
    final double blockSize = points.length / samples;

    for (int i = 0; i < samples; i++) {
      final double blockStart =
          blockSize * i; // the location of the first sample in the block
      int sum = 0;
      for (int j = 0; j < blockSize; j++) {
        sum = sum +
            points[(blockStart + j).toInt()]
                .toInt(); // find the sum of all the samples in the block
      }
      filteredData.add((sum / blockSize)
          .round() // take the average of the block and add it to the filtered data
          .toInt()); // divide the sum by the block size to get the average
    }
    final maxNum = filteredData.reduce((a, b) => math.max(a.abs(), b.abs()));

    final double multiplier = math.pow(maxNum, -1).toDouble();

    return filteredData.map<double>((e) => (e * multiplier)).toList();
  }

  bool isBrain = false;
  List<DataBrain> listBrain = [];
  RepoBrain repo = RepoBrain();
  Future<void> getListBrain(BuildContext context, String id) async {
    isBrain = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResListBrainActivation> response =
        await repo.getListBrain(id);

    isBrain = false;
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
      if (res != null) {
        listBrain = res.data ?? [];
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool isPaymentBrainActivation = false;
  Future<void> paymentBrainActivation(
      BuildContext context, int idBrain, String price, String idLogProfiling,
      {Function? onUpdate}) async {
    isPaymentBrainActivation = true;
    notifyListeners();

    Either<Failure, ResTransakasiBrainActivation> response =
        await repo.paymentBrainActivation(idBrain, price, idLogProfiling,
            gateway: !dataGlobal.isIndonesia ? "paypal" : null);

    isPaymentBrainActivation = false;
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
        Nav.to(PreInvoiceScreen(
          snapToken: res.data?.snapToken,
          orderId: res.data?.orderId,
          paymentType: res.data?.transactionType,
          date: res.data?.createdAt,
          discount: res.data?.discount,
          amount: res.data?.amountPaypal,
          onUpdate: onUpdate,
          fromPage: "profiling",
          currencyPaypal: res.data?.currencyPaypal,
        ));
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
          Nav.back();
        },
            widget: Text(
              res.message ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: S.of(context).back);
      }
    });
    notifyListeners();
  }

  bool updatePayment = false;
  Future<void> updatePaymentStatus(BuildContext context, String idOrder,
      {Function? onUpdate}) async {
    updatePayment = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResUpdatePayment> response =
        await repo.updatePayment(idOrder);

    updatePayment = false;
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
        print("status tran ${res.success}");
      }
      if (res != null) {
        Nav.back();
        onUpdate!();
        notifyListeners();
      }
    });
    notifyListeners();
  }

  bool isDuration = false;
  TimePlayBrain? timerPlay;
  bool? isSuccess;
  Future<void> getDurationAudio(BuildContext context, int idAudio,
      {Function? onUpdate}) async {
    isDuration = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResTimerPlay> response =
        await repo.getDurationAudio(idAudio);

    isDuration = false;
    notifyListeners();
    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
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
        timerPlay = res.data;
        isSuccess = res.success ?? false;
        if (kDebugMode) {
          print("status tran ${res.success}");
        }
        notifyListeners();
      } else {
        isSuccess = res.success ?? false;
        NotificationUtils.showSnackbar("${res.message}",
            backgroundColor: primaryColor);
      }
    });
    notifyListeners();
  }

  bool isCekDaily = false;
  CekDaily? cekDaily;

  Future<void> getCekDaily(BuildContext context, int idAudio,
      {Function? onUpdate}) async {
    isDuration = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResCekDaily> response = await repo.cekDaily(idAudio);

    isDuration = false;
    notifyListeners();
    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
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
        cekDaily = res.data;
        if (kDebugMode) {
          print("cek Daily ${cekDaily?.toJson()}");
        }
        notifyListeners();
      } else {
        isSuccess = res.success ?? false;
        NotificationUtils.showSnackbar("${res.message}",
            backgroundColor: primaryColor);
      }
    });
    notifyListeners();
  }

  bool isGetListSubcriptionPerItem = false;
  bool _valueAllList = false;

  bool get valueAllList => _valueAllList;

  void setValue(bool newValue) {
    _valueAllList = newValue;
    notifyListeners();
  }

  List<DataSubcriptionPerItem> listDataSubcriptionPerItem = [];
  DataResponse? dataResponse;

  Future<void> getListSubcriptionPerItem(
    BuildContext context,
    String idLogProfiling,
  ) async {
    isGetListSubcriptionPerItem = true;
    notifyListeners();

    Either<Failure, ResListSubcriptionPerItem> response =
        await repo.gesListSubcriptionPerItem(idLogProfiling);

    isGetListSubcriptionPerItem = false;
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
      setValue(res.data?.allLists ?? false);
      dataResponse = res.data;
      listDataSubcriptionPerItem = res.data?.lists ?? [];
      notifyListeners();
    });
    notifyListeners();
  }

  bool isGetListSubcriptionAllItem = false;
  List<DataSubcripctionAllItem> listDataSubcriptionAllItem = [];
  Future<void> getListSubcriptionAllItem(
    BuildContext context,
  ) async {
    isGetListSubcriptionAllItem = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResListSubcriptionAllItem> response =
        await repo.gesListSubcriptionAllItem();

    isGetListSubcriptionAllItem = false;
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
      listDataSubcriptionAllItem = res.data ?? [];
      notifyListeners();
    });
    notifyListeners();
  }

  bool isCreateTransactionSubcribeBrainActivation = false;
  Future<void> createTransactionSubcribeBrainActivation(
      BuildContext context, SubscribeBrainTransactionDataModel data,
      {Function? onUpdate}) async {
    isCreateTransactionSubcribeBrainActivation = true;
    notifyListeners();

    Either<Failure, ResSubcribeBrainTransaction> response =
        await repo.createTransactionSubcribeBrain(data);

    isCreateTransactionSubcribeBrainActivation = false;
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
        Nav.to(PreInvoiceScreen(
          snapToken: res.data?.snapToken,
          orderId: res.data?.orderId,
          paymentType: res.data?.transactionType,
          date: res.data?.createdAt,
          discount: res.data?.discount,
          amount: dataGlobal.isIndonesia
              ? res.data?.totalAmount
              : res.data?.amountPaypal,
          onUpdate: onUpdate,
          fromPage: "profiling",
          currencyPaypal: res.data?.currencyPaypal,
        ));
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
          Nav.back();
        },
            widget: Text(
              res.message ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: S.of(context).back);
      }
    });
    notifyListeners();
  }

  bool isCekAllowSubcribe = false;
  ResCheckAllowSubcribe? cekAllowSubcribe;

  Future<void> checAllowSubcribe(BuildContext context, String? idLog,
      {Function? onUpdate}) async {
    isCekAllowSubcribe = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResCheckAllowSubcribe> response =
        await repo.checkAllowSubcribe(idLog);

    isCekAllowSubcribe = false;
    notifyListeners();
    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          textButton: S.of(context).back);
    }, success: (res) async {
      cekAllowSubcribe = res;

      notifyListeners();
    });
    notifyListeners();
  }

  bool isCreateTransactionSubcribeBrainProfiling = false;
  Future<void> subcribeBrainProfiling(
      BuildContext context, SubscribeBrainTransactionDataModel data,
      {Function? onUpdate}) async {
    isCreateTransactionSubcribeBrainActivation = true;
    notifyListeners();

    Either<Failure, ResCreateDataTransaction> response =
        await repo.subcribeBrainProfiling(data);

    isCreateTransactionSubcribeBrainActivation = false;
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
        Nav.to(PreInvoiceScreen(
          snapToken: res.data?.snapToken,
          orderId: res.data?.orderId,
          paymentType: res.data?.transactionType,
          date: res.data?.createdAt,
          discount: res.data?.discount,
          amount:  dataGlobal.isIndonesia
              ? res.data?.totalAmount
              : res.data?.amountPaypal,
          onUpdate: onUpdate,
          fromPage: "profiling",
          currencyPaypal: res.data?.currencyPaypal,
        ));
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
          Nav.back();
        },
            widget: Text(
              res.message ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: S.of(context).back);
      }
    });
    notifyListeners();
  }

  bool isGetShowPrice = false;
  ResShowPriceBrainSubcribe? showPrice;

  Future<void> getShowPrice(
    BuildContext context,
    String idLogProfiling,
  ) async {
    isGetShowPrice = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResShowPriceBrainSubcribe> response =
        await repo.getShowPrice(idLogProfiling);

    isGetShowPrice = false;
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
      showPrice = res;
      notifyListeners();
    });
    notifyListeners();
  }
}
