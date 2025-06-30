import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/repositories/repo_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_by_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_summary.dart';
import 'package:coolappflutter/data/response/consultant/res_check_session.dart';
import 'package:coolappflutter/data/response/consultant/res_check_session_consultant.dart';
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
import 'package:coolappflutter/data/response/consultant/res_stop_room.dart';
import 'package:coolappflutter/data/response/consultant/res_update_status.dart';
import 'package:coolappflutter/data/response/consultation/res_create_consultation.dart';
import 'package:coolappflutter/data/response/consultation/res_detail_consultant.dart';
import 'package:coolappflutter/data/response/consultation/res_get_chat_archive.dart';
import 'package:coolappflutter/data/response/consultation/res_get_price.dart';
import 'package:coolappflutter/data/response/consultation/res_join_consultation.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/chat/New_Chat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/konsultant_dashboard.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/New_UserChat.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/pages/payments/pre_invoice_screen.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_summary.dart'
    as summary;
import 'package:coolappflutter/data/response/consultant/res_regist_consultant.dart'
    as regist;
import 'package:coolappflutter/presentation/widgets/Container/Container_Promo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../response/consultation/res_payment_consultation.dart';

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
  Future<void> followConsultant(BuildContext context, String id, String status) async {
    // Set loading state
    isLoadingFollow = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Panggil repo
    debugPrint("Calling API to follow consultant...");
    Either<Failure, ResponseFollowConsultant> response =
    await repoConsultant.followConsultant(id, status);

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
            textButton: "Oke", // Ganti l10n jika ada
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
    notifyListeners();

    final Either<Failure, ResCheckSession> response =
    await repoConsultant.checkSession(token: token);

    isLoadingSession = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("Error checking user session");
        // NotificationUtils.showDialogError(
        //   context,
        //       () {
        //     Nav.back();
        //   },
        //   widget: Text(
        //     failure.message,
        //     textAlign: TextAlign.center,
        //     style: const TextStyle(fontSize: 16),
        //   ),
        //   textButton: "Back",
        // );
      },
      success: (res) {
        debugPrint("User session checked successfully");

        if (res.success == true && res.data != null && res.data!.isNotEmpty) {
          final session = res.data!.first;

          final String receiverUserID = session.firebaseConf?.consultantIds.toString() ?? "";
          final String tema = session.theme ?? '';
          final String nama = session.targetName ?? ''; // ganti jika kamu consultant
          final String type = session.typeSession ?? ''; // ganti jika kamu consultant
          final String tipeOtak = session.targetTypeBrain ?? '';
          final String waktu = session.timeSelected ?? '';
          final String image = session.targetImage ?? ''; // tambahkan jika punya image
          final String status = session.sessionStatus ?? '';
          final Object consultantID = session.id ?? '';
          final String consultationID = session.id?.toString() ?? '';

          NotificationUtils.showDialogError(
            context,
                () {
              Navigator.pop(context); // tutup dialog dulu
              Nav.toAll(NewUserChatPage(
                explanation: session.explanation.toString(),
                reciverUserID: receiverUserID,
                Tema: tema,
                nama: nama,
                type: type,
                tipeotak: tipeOtak,
                waktu: waktu,
                image: image,
                consultantID: consultantID.toString(),
                consultationID: consultationID,
                status: true,
              ));
            },
            widget: Text(
              res.message ?? "Session ditemukan.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: "Lanjut",
          );
        } else {
          debugPrint("Session invalid or no data");
        }
      },
    );
  }


  ///==========================check session =====================================//
  Future<void> checkConsultantSession(BuildContext context, {String? token}) async {
    isLoadingSession = true;
    notifyListeners();

    final Either<Failure, ResCheckSessionConsultant> response =
    await repoConsultant.checkSessionConsultant();

    isLoadingSession = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("Error checking user session");
        // NotificationUtils.showDialogError(
        //   context,
        //       () {
        //     Nav.back();
        //   },
        //   widget: Text(
        //     failure.message,
        //     textAlign: TextAlign.center,
        //     style: const TextStyle(fontSize: 16),
        //   ),
        //   textButton: "Back",
        // );
      },
      success: (res) {
        debugPrint("User session checked successfully");

        if (res.success == true && res.data != null && res.data!.isNotEmpty) {
          final session = res.data!.first;

          final String receiverUserID = session.firebaseConf?.participantIds.toString() ?? "";
          final String tema = session.theme ?? '';
          final String type = session.typeSession ?? '';
          final String nama = session.targetName ?? ''; // ganti jika kamu consultant
          final String tipeOtak = session.targetTypeBrain ?? '';
          final String waktu = session.timeSelected ?? '';
          final String image = session.targetImage ?? ''; // tambahkan jika punya image
          final String status = session.sessionStatus ?? '';
          final Object consultantID = session.id ?? '';
          final String consultationID = session.id?.toString() ?? '';

          NotificationUtils.showDialogError(
            context,
                () {
              Navigator.pop(context); // tutup dialog dulu
              Nav.toAll(NewChatPage(
                reciverUserID: receiverUserID,
                Tema: tema,
                nama: nama,
                type: type,
                tipeotak: tipeOtak,
                waktu: waktu,
                image: image,
                consultationID: consultationID,
                status: true,
              ));
            },
            widget: Text(
              res.message ?? "Session ditemukan.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: "Lanjut",
          );
        } else {
          debugPrint("Session invalid or no data");
        }
      },
    );
  }





  ///================================== check consultation=================///
  ConsultationData? createdConsultationData;
  bool isCreatingConsultation = false;

  Future<void> createConsultation(
      BuildContext context, {
        required String consultantId,
        required String themeId,
        required String participantExplanation,
        required String typeSession,
        required String time,
      }) async {
    if (isCreatingConsultation) return;

    isCreatingConsultation = true;
    notifyListeners();

    final result = await repoConsultant.createConsultation(
      consultantId: consultantId,
      themeId: themeId,
      participantExplanation: participantExplanation,
      typeSession: typeSession,
      time: time,
    );

    isCreatingConsultation = false;
    notifyListeners();

    result.when(
      error: (failure) {
        NotificationUtils.showDialogError(
          context,
              () => Nav.back(),
          widget: Text(
            failure.message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      },
      success: (response) {
        if (response.success) {
          debugPrint("✅ Consultation created: ${response.message}");
          createdConsultationData = response.data;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Timer untuk navigasi otomatis setelah 3 detik
              Future.delayed(Duration(seconds: 3), () {
                Nav.toAll(NavMenuScreen()); // Ganti ke rute tujuan
              });

              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  height: 350,
                  child: ContainerPromo(
                    title: S.of(context).Awaiting_Confirmation,
                    imageUrl: 'konsultasi/Time_Circle.jpg',
                    subtitle: S.of(context).Awaiting_Confirmation,
                    subtitle2: S.of(context).Back_to_Consultation,
                  ),
                ),
              );
            },
          );
          // Di sini bisa arahkan ke halaman Chat atau lainnya
        } else {
          NotificationUtils.showDialogError(
            context,
                () => Nav.back(),
            widget: Text(
              response.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }
      },
    );
  }



  ///=====================joinroom=========================///
  bool isLoadingJoin = false;
  Future<void> joinRoom(BuildContext context, String? id) async {
    isLoadingJoin = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResponseJoin> response =
    await repoConsultant.joinroom(id: id);

    isLoadingJoin = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("❌ Failed to join room: ${failure.message}");
      },
      success: (res) async {
        debugPrint("✅ Successfully joined room");

        if (res.success == true) {
          if (kDebugMode) {
            print("🟢 Join room response data: ${res.data?.toJson()}");
          }
        }
      },
    );

    notifyListeners();
  }



  ///=============================fungsi stop session================/
  bool isLoadingStop = false;

  Future<void> stopSession(BuildContext context, String consultationId, String typeSession, String idDocument) async {
    isLoadingStop = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResStopSession> response =
    await repoConsultant.StopSession(consultationId, typeSession, idDocument);

    isLoadingStop = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("❌ Failed to stop session: ${failure.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menghentikan sesi: ${failure.message}")),
        );
      },
      success: (res) {
        debugPrint("✅ Successfully stopped session");
        if (res.success == true) {
          if (kDebugMode) {
            print("🟢 Stop session response data: ${res.data?.toJson()}");
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(res.message ?? "Sesi berhasil dihentikan")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(res.message ?? "Sesi gagal dihentikan")),
          );
        }
      },
    );

    notifyListeners();
  }

  ResCheckPrice? priceData;
  bool isLoadingPrice = false;

  Future<void> getPrice(BuildContext context, {
    required String timeStart,
    required String timeEnd,
    required String day,
    required String type,
  }) async {
    isLoadingPrice = true;
    notifyListeners(); // Mulai loading

    final Either<Failure, ResCheckPrice> response =
    await repoConsultant.GetPrice(timeStart, timeEnd, day, type);

    isLoadingPrice = false;
    notifyListeners(); // Selesai loading

    response.when(
      error: (failure) {
        debugPrint("Error saat ambil data harga");
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
        debugPrint("Berhasil ambil data harga");
        if (res.success == true) {
          priceData = res;
          notifyListeners(); // Update UI
          if (kDebugMode) {
            print("Data Harga: ${priceData?.toJson()}");
          }
        } else {
          debugPrint("Gagal ambil data harga");
        }
      },
    );
  }


  ResPaymentKonsultasi? paymentData;
  bool isLoadingPayment = false;

  Future<void> payConsultation(
      BuildContext context, {
        required String idConsultation,
        required String type,
        required String harga,
        Function? onAdd,
        Function? onUpdate,
        String? fromPage,
      }) async {
    isLoadingPayment = true;
    notifyListeners();

    final Either<Failure, ResPaymentKonsultasi> response =
    await repoConsultant.PayMentConsultasi(idConsultation, type, harga);

    isLoadingPayment = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("❌ Error saat membuat pembayaran konsultasi");
        NotificationUtils.showDialogError(
          context,
              () => Nav.back(),
          widget: Text(
            failure.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          textButton: "Kembali",
        );
      },
      success: (res) {
        debugPrint("✅ Pembayaran konsultasi berhasil dibuat");

        final data = res.data;
        if (res.success == true && data != null) {
          bool isIndonesia = context.read<ProviderUser>().isIndonesia();

          if (kDebugMode) {
            print("🧾 Total Amount: ${data.totalAmount}");
          }

          Nav.toAll(
            PreInvoiceScreen(
              snapToken: data.snapToken,
              orderId: data.orderId,
              paymentType: data.transactionType,
              date: data.createdAt,
              discount: data.discount,
              amount: !dataGlobal.isIndonesia ? data.amountPaypal : data.totalAmount,
              currencyPaypal: data.currencyPaypal,
              onUpdate: onUpdate,
              fromPage: fromPage,
              isIndonesia: isIndonesia,
            ),
          );

          paymentData = res;
          notifyListeners();

          if (kDebugMode) {
            print("📦 Payment Data: ${paymentData?.toJson()}");
          }

          if (onUpdate != null) onUpdate(); // Optional callback
        } else {
          debugPrint("⚠️ Respon sukses tapi data null atau flag success = false");
        }
      },
    );
  }


  ResGetChatArchived? chatArchivedData;
  bool isLoadingChatArchived = false;

  Future<void> getChatArchived(BuildContext context, String id) async {
    isLoadingChatArchived = true;
    notifyListeners(); // Start loading

    final Either<Failure, ResGetChatArchived> response =
    await repoConsultant.getChatArcived(id);

    isLoadingChatArchived = false;
    notifyListeners(); // End loading

    response.when(
      error: (failure) {
        debugPrint("❌ Error ambil data chat arsip");
        NotificationUtils.showDialogError(
          context,
          () {
            Nav.back();
            Nav.back();
          },
          widget: Text(
            failure.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          textButton: "Kembali",
        );
      },
      success: (res) {
        debugPrint("✅ Berhasil ambil data chat arsip");

        if (res.success) {
          chatArchivedData = res;
          notifyListeners();
          if (kDebugMode) {
            print("Data Chat Archived: ${chatArchivedData?.toJson()}");
          }
        } else {
          debugPrint("⚠️ Response success false dari API");
        }
      },
    );
  }



}
