import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/repositories/repo_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_by_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_summary.dart';
import 'package:coolappflutter/data/response/consultant/res_check_session.dart';
import 'package:coolappflutter/data/response/consultant/res_dashboard_consultant.dart'
    as dashboard;
import 'package:coolappflutter/data/response/consultant/res_dashboard_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_follow_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_get_comissen.dart';
import 'package:coolappflutter/data/response/consultant/res_get_participant.dart';
import 'package:coolappflutter/data/response/consultant/res_get_participant.dart'
    as participantlist;
import 'package:coolappflutter/data/response/consultant/res_get_term.dart';
import 'package:coolappflutter/data/response/consultant/res_get_topic.dart';
import 'package:coolappflutter/data/response/consultant/res_regist_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_update_status.dart';
import 'package:coolappflutter/data/response/consultation/res_detail_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/konsultant_dashboard.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_summary.dart'
    as summary;
import 'package:coolappflutter/data/response/consultant/res_regist_consultant.dart'
    as regist;
import 'package:coolappflutter/presentation/widgets/Container/Container_Promo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConsultantProvider extends ChangeNotifier {
  // Inisialisasi RepoConsultant
  final RepoConsultant repoConsultant = RepoConsultant();

  ///////loading fungsi //////////////
  bool isLoadingRegisterConsultant = false;
  bool isLoadingHomeConsultant = false;
  bool isLoadingParticipant = false;
  bool isLoading = false;
  bool isLoadingTerms = false;
  bool isLoadingCommissions = false;
  bool isLoadingStatus = false;
  bool isLoadingApprove = false;
  bool isLoadingStatusAcc = false;
  bool isLoadingSession = false;

  // modedl data////////
  ResGetTerm? termData;
  summary.Data? approvalData;
  regist.Data? registrationData;
  dashboard.Data? homeConsultantData;
  ResGetComissen? commissionData;

  // data list//////////
  List<participantlist.Datum>? participantData;
  List<participantlist.Datum> get listParticipant => participantData ?? [];
  ResGetTerm? get terms => termData;

  //=========================== Fungsi untuk register consultant =========================== //
  Future<void> registerConsultant({
    required List<String> titleExperience,
    required List<String> descriptionExperience,
    required List<String> documents,
  }) async {
    isLoadingRegisterConsultant = true;
    notifyListeners();

    // Log data yang akan dikirim
    print('Title Experience: $titleExperience');
    print('Description Experience: $descriptionExperience');
    print('Documents: $documents');

    // Mengirim data ke repository
    Either<Failure, ResRegistConsultant> response =
        await repoConsultant.registerconsultant(
      title_experience: titleExperience,
      description_experience: descriptionExperience,
      documents: documents,
    );

    isLoadingRegisterConsultant = false;
    notifyListeners();

    // Handle response
    response.when(
      error: (e) {
        print('gagal provider');
        throw Exception(e.message ?? 'Terjadi kesalahan');
      },
      success: (res) {
        // Jika sukses, cukup beri notifikasi atau panggil function di UI, jangan return value di sini
        if (res.success != true) {
          // Jika berhasil tetapi status success false
          throw Exception(res.message ?? 'Pendaftaran gagal');
        }
      },
    );
  }

  //==========================fungsi get approval data  ===========================================/
  Future<void> getApprovalData(BuildContext context) async {
    // Set loading state
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Call API
    Either<Failure, ResApprovalConsultant> response =
        await repoConsultant.getSummary();

    // Update loading state
    isLoading = false;
    notifyListeners();

    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error fetching approval data");
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
          textButton:
              "Back", // Ganti dengan S.of(context).back jika menggunakan l10n
        );
      },
      success: (res) async {
        debugPrint("Approval data fetched successfully");
        if (res.success == true) {
          approvalData = res.data;
          notifyListeners();
          if (kDebugMode) {
            print("Approval Data: ${approvalData?.toJson()}");
          }
        } else {
          debugPrint("Failed to fetch approval data");
        }
      },
    );
    notifyListeners();
  }

  //=====================================fungsi get data untuk dashboard konsultant ============================//
  Future<void> getHomeConsultant(BuildContext context) async {
    // Set loading state
    isLoadingHomeConsultant = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Call API
    Either<Failure, ResHomeConsultant> response =
        await repoConsultant.getHomeConsultant();

    // Update loading state
    isLoadingHomeConsultant = true;
    notifyListeners();

    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error fetching home consultant data");
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
          textButton:
              "Back", // Ganti dengan S.of(context).back jika menggunakan l10n
        );
      },
      success: (res) async {
        debugPrint("Home consultant data fetched successfully");
        if (res.success == true) {
          homeConsultantData = res.data;
          dataGlobal.dataConsultant = res.data;
          notifyListeners();
          if (kDebugMode) {
            print("Home Consultant Data: ${homeConsultantData?.toJson()}");
          }
        } else {
          debugPrint("Failed to fetch home consultant data");
        }
      },
    );
    notifyListeners();
  }

// ==============================================fungsi untuk get list data participant =====================================//
  Future<void> getParticipant(BuildContext context, {String? parameter}) async {
    // Set loading state
    isLoadingParticipant = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Call API
    debugPrint("Fetching participant data from API...");

    // Memanggil fungsi getListParticipant dengan parameter opsional
    Either<Failure, ResGetParticipant> response =
        await repoConsultant.getListParticipant(parameter: parameter);

    // Update loading state
    isLoadingParticipant = false;
    notifyListeners();

    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error fetching participant data");
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
          textButton:
              "Back", // Ganti dengan S.of(context).back jika menggunakan l10n
        );
      },
      success: (res) async {
        debugPrint("Participant data fetched successfully");
        if (res.success == true) {
          participantData = res.data;
          debugPrint(
              "API response sukses: ${res.data}"); // Simpan data ke state
          notifyListeners();
          if (kDebugMode) {
            print(
                "Participant Data: ${participantData?.map((e) => e.toJson())}");
          }
        } else {
          debugPrint("API response gagal : ${res.data}");
          debugPrint("Failed to fetch participant data");
        }
      },
    );
    notifyListeners();
  }

  //===========================================fungsi get detail konsultant==========================================/
  bool isLoadingDetailConsultant = false;
  DataDetailConsultant? detailConsultantData;
  Future<void> getDetailConsultantData(BuildContext context, String id) async {
    // Set loading state
    isLoadingDetailConsultant = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Debug log
    debugPrint("Fetching detail consultant data from API...");

    // Call API (repo)
    Either<Failure, ResponseDetailConsultant> response =
    await repoConsultant.getDetailConsultant(id);

    // Update loading state
    isLoadingDetailConsultant = false;
    notifyListeners();

    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error fetching detail consultant data");
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
      success: (res) async {
        debugPrint("Detail consultant data fetched successfully");
        if (res.success == true) {
          detailConsultantData = res.data;
          debugPrint("API response sukses: ${res.data?.toJson()}");
          notifyListeners();
        } else {
          debugPrint("API response gagal: ${res.data}");
          debugPrint("Failed to fetch detail consultant data");
        }
      },
    );

    // Final notify
    notifyListeners();
  }


  //=========================================fungsi get topic consultant =============================================/
  bool isLoadingTopicConsultant = false;
  List<RecommendedTopic>? topicConsultantData;
  Future<void> getTopicConsultantData(BuildContext context, String id) async {
    // Set loading state
    isLoadingTopicConsultant = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Debug log
    debugPrint("Fetching topic consultant data from API...");

    // Call API (repo)
    Either<Failure, ResponseGetTopic> response =
    await repoConsultant.getTopicConsultant(id);

    // Update loading state
    isLoadingTopicConsultant = false;
    notifyListeners();

    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error fetching topic consultant data");
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
      success: (res) async {
        debugPrint("Topic consultant data fetched successfully");
        if (res.success == true) {
          topicConsultantData = res.data;
          debugPrint("API response sukses: ${res.data}");
          notifyListeners();
        } else {
          debugPrint("API response gagal: ${res.data}");
          debugPrint("Failed to fetch topic consultant data");
        }
      },
    );

    // Final notify
    notifyListeners();
  }


  //=========================================fungsi follow konsultant ============================================//
  bool isLoadingFollow = false;
  DataFollowConsultant? followData;
  Future<void> followConsultant(BuildContext context, String id) async {
    // Set loading state
    isLoadingFollow = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Panggil repo
    debugPrint("Calling API to follow consultant...");
    Either<Failure, ResponseFollowConsultant> response =
    await repoConsultant.followConsultant(id);

    // Update loading state
    isLoadingFollow = false;
    notifyListeners();

    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error following consultant: ${failure.message}");
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
          textButton: "Back", // Ganti l10n jika ada
        );
      },
      success: (res) async {
        debugPrint("Follow consultant response fetched successfully");
        if (res.success == true) {
          followData = res.data;
          debugPrint("API response sukses: ${res.data}");
          NotificationUtils.showDialogSuccess(
            context,
                () {
              Nav.back();
            },
            widget: Text(
              res?.message ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: "Back", // Ganti l10n jika ada
          );
          notifyListeners();
        } else {
          debugPrint("API response gagal: ${res.message}");
          NotificationUtils.showDialogError(
            context,
                () {
              Nav.back();
            },
            widget: Text(
              res.message ?? "Gagal follow consultant",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: "Back", // Ganti l10n jika ada
          );
        }
      },
    );
    notifyListeners();
  }




  //==========================================fungsi get data term and condition ====================================/
  Future<void> getTermsAndConditions(BuildContext context) async {
    isLoadingTerms = true;
    notifyListeners();

    // Panggil API melalui repo
    final Either<Failure, ResGetTerm> response =
        await repoConsultant.getTermCondition();

    // Set loading ke false setelah API selesai
    isLoadingTerms = false;

    response.when(
      error: (failure) {
        debugPrint("Error fetching terms and conditions");
        // Tampilkan dialog error
        NotificationUtils.showDialogError(
          context,
          () {
            Nav.back(); // Kembali ke layar sebelumnya
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
        debugPrint("Terms and Conditions fetched successfully");
        if (res.success == true) {
          termData = res;
          notifyListeners(); // Update UI setelah data berhasil diambil
          if (kDebugMode) {
            print("Terms Data: ${termData?.toJson()}");
          }
        } else {
          debugPrint("Failed to fetch terms and conditions");
        }
      },
    );
  }

  //=====================get data comissen ====================////////
  Future<void> getCommissions(BuildContext context, {String? token}) async {
    isLoadingCommissions = true;
    notifyListeners(); // Menandakan bahwa loading sedang berlangsung

    // Panggil API melalui repository untuk mendapatkan data commission
    final Either<Failure, ResGetComissen> response =
        await repoConsultant.getComissen(token: token);

    // Set loading ke false setelah API selesai
    isLoadingCommissions = false;
    notifyListeners(); // Update UI untuk menandakan bahwa loading selesai

    response.when(
      error: (failure) {
        debugPrint("Error fetching commission history");
        // Tampilkan dialog error jika gagal
        NotificationUtils.showDialogError(
          context,
          () {
            Nav.back(); // Kembali ke layar sebelumnya
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
        debugPrint("Commissions fetched successfully");
        if (res.success == true) {
          commissionData = res;
          notifyListeners(); // Update UI dengan data terbaru
          if (kDebugMode) {
            print("Commission Data: ${commissionData?.toJson()}");
          }
        } else {
          debugPrint("Failed to fetch commission history");
        }
      },
    );
  }

  ///=========================update status consultant======================/
  Future<void> updateStatusProvider(BuildContext context, int status) async {
    // Set loading state
    isLoadingStatus = true;
    notifyListeners();

    // Call API
    Either<Failure, ResUpdateStatus> response =
        await repoConsultant.updateStatus(status);

    // Update loading state
    isLoadingStatus = false;
    notifyListeners();
    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error updating status");
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
      success: (res) async {
        if (res.success == true) {
          debugPrint("Status updated successfully");
          // Update UI data
          homeConsultantData?.availableStatus =
              res.data?.availableStatus.toString();
          notifyListeners(); // Trigger UI rebuild
        } else {
          debugPrint("Failed to update status: ${res.message}");
          NotificationUtils.showDialogError(
            context,
            () {
              Nav.back();
            },
            widget: Text(
              res.message ?? "Failed to update status",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: "Back",
          );
        }
      },
    );
    notifyListeners();
  }

  ///=================================== approve by consultant =================================/
  Future<void> approveByConsultant(
    BuildContext context,
    int consultationId,
    String type,
  ) async {
    // Set loading state
    isLoadingStatusAcc = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Call API
    Either<Failure, ResApproveByConsultant> response =
        await repoConsultant.ApproveByConsultant(consultationId, "true");

    // Update loading state
    isLoadingStatusAcc = false;
    notifyListeners();

    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error Approve by consultant");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pop(context); // Tutup dialog
              Nav.toAll(KonsultantDashboard()); // Navigasi ke dashboard
            });
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SizedBox(
                height: 380,
                child: ContainerPromo(
                  title: S.of(context).cannotAcceptConsultation,
                  imageUrl: AppAsset.icRedWaring,
                  subtitle: S.of(context).conflictingSession,
                  subtitle2: S.of(context).returnIn3Seconds,
                ),
              ),
            );
          },
        );
      },
      success: (res) async {
        debugPrint("Approve by consultant successfully");
        if (res.success == true) {
          if (kDebugMode) {
            print("Approve by consultant: ${res.data?.toJson()}");
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.pop(context); // Tutup dialog
                Nav.toAll(KonsultantDashboard()); // Navigasi ke dashboard
              });

              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  height: 300,
                  child: ContainerPromo(
                    title: S.of(context).approvalSuccessful,
                    imageUrl: AppAsset.icCheck,
                    subtitle: S.of(context).consultationApproved,
                    subtitle2: S.of(context).returnIn3Seconds,
                  ),
                ),
              );
            },
          );
        }
      },
    );

    notifyListeners();
  }

  ///=================================== approve by consultant =================================/
  Future<void> RejectByConsultant(
      BuildContext context, int consultationId, String noted) async {
    // Set loading state
    isLoadingApprove = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Call API
    Either<Failure, ResApproveByConsultant> response =
        await repoConsultant.ApproveByConsultant(consultationId, "false",
            note: noted);

    // Update loading state
    isLoadingApprove = false;
    notifyListeners();

    // Handle response
    response.when(
      error: (failure) {
        debugPrint("Error reject by consultant");
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
      success: (res) async {
        debugPrint("Reject by consultant hit oke");
        if (res.success == true) {
          if (kDebugMode) {
            print("Reject by consultant: ${res.data?.toJson()}");
          }
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pop(context); // Tutup dialog
            Nav.toAll(KonsultantDashboard()); // Navigasi ke dashboard
          });
        }
      },
    );

    notifyListeners();
  }



  ///==========================check session =====================================//
  Future<void> checkUserSession(BuildContext context, {String? token}) async {
    isLoadingSession = true;
    notifyListeners(); // Menandakan bahwa loading sedang berlangsung

    // Panggil API melalui repository untuk memeriksa sesi pengguna
    final Either<Failure, ResCheckSession> response = await repoConsultant.checkSession(token: token);

    // Set loading ke false setelah API selesai
    isLoadingSession = false;
    notifyListeners(); // Update UI untuk menandakan bahwa loading selesai

    response.when(
      error: (failure) {
        debugPrint("Error checking user session");
        // Tampilkan dialog error jika terjadi kegagalan
        NotificationUtils.showDialogError(
          context,
              () {
            Nav.back(); // Kembali ke layar sebelumnya
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
        debugPrint("User session checked successfully");
        if (res.success == true) {
          // debugPrint("Session valid, navigating to Dashboard...");
          // Nav.pushReplacementNamed(Routes.dashboard); // Navigasi ke halaman Dashboard
        } else {
          debugPrint("Session invalid, staying on the same page.");
        }
      },
    );
  }

}
