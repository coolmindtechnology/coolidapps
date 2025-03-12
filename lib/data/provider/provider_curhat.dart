
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/repositories/repo_curhat.dart';
import 'package:coolappflutter/data/response/curhat/res_create_curhat.dart';
import 'package:coolappflutter/data/response/curhat/res_getlist_curhat.dart';
import 'package:coolappflutter/data/response/curhat/res_getlist_curhat.dart' as curhat;
import 'package:coolappflutter/presentation/pages/curhat/normal_user/curhart_dashboard.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurhatProvider extends ChangeNotifier {
  // Inisialisasi RepoConsultant
  final RepoCurhat repoCurhat = RepoCurhat();
  List<curhat.Datum>? curhatdata;
  List<curhat.Datum> get listCurhat => curhatdata ?? [];


  bool isLoadingCurhat = false;
  bool isLoadingCreateCurhat = false;


  ////===================get list curhat=====================//
  Future<void> getListCurhat(BuildContext context, {String? parameter}) async {
    // Set loading state
    isLoadingCurhat = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    debugPrint("Fetching curhat data from API...");

    // Memanggil fungsi getlistCurhat dengan parameter opsional
    Either<Failure, ResGetListCurhat> response =
    await repoCurhat.getlistCurhat(parameter: parameter);

    // Update loading state
    isLoadingCurhat = false;
    notifyListeners();

    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error fetching curhat data");
        NotificationUtils.showDialogError(
          context,
              () {
            Nav.back();
          },
          widget: Text(
            failure.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          textButton: "Back",
        );
      },
      success: (res) {
        debugPrint("Curhat data fetched successfully");
        if (res.success == true) {
          curhatdata = res.data as List<Datum>?;
          debugPrint("API response sukses: ${res.data}");
          notifyListeners();
        } else {
          debugPrint("API response gagal : ${res.data}");
          debugPrint("Failed to fetch curhat data");
        }
      },
    );
    notifyListeners();
  }
  ////===================get list curhat=====================//
  ///==================create curhat=====================//
  Future<void> createCurhat(
      BuildContext context,
      String consultantId,
      String themeId,
      String time,
      String? participantExplanation,
      ) async {
    isLoadingCreateCurhat = true;
    notifyListeners();

    debugPrint("Creating curhat...");

    Either<Failure, ResponseCreateCurhat> response =
    await repoCurhat.CreateCurhat(consultantId, themeId, time, participantexplanation: participantExplanation);

    isLoadingCreateCurhat = false;

    response.when(
      error: (failure) {
        debugPrint("Error creating curhat: ${failure.message}");
        NotificationUtils.showDialogError(
          context,
              () => Nav.back(),
          widget: Text(
            failure.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          textButton: "Back",
        );
      },
      success: (res) async {
        if (res.success == true) {
          debugPrint("Curhat created successfully: ${res.data?.toJson()}");

          NotificationUtils.showDialogSuccess(
            context,
                () => Nav.toAll(CurhatDashboard()), // Navigasi ke dashboard
            widget: const Text(
              "Curhat berhasil dibuat!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            textButton: "OK",
          );
        } else {
          debugPrint("Failed to create curhat: ${res.data}");
          NotificationUtils.showDialogError(
            context,
                () => Nav.back(),
            widget: const Text(
              "Gagal membuat curhat.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            textButton: "Back",
          );
        }
      },
    );

    notifyListeners();
  }

}