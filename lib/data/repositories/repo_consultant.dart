import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/networks/error_handler.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_by_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_approval_summary.dart';
import 'package:coolappflutter/data/response/consultant/res_check_session.dart';
import 'package:coolappflutter/data/response/consultant/res_check_session_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_dashboard_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_follow_consultant.dart';
import 'package:coolappflutter/data/response/consultant/res_get_comissen.dart';
import 'package:coolappflutter/data/response/consultant/res_get_participant.dart';
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
import 'package:coolappflutter/data/response/consultation/res_payment_consultation.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../helpers/either.dart';

class RepoConsultant {
  Future<Either<Failure, ResRegistConsultant>> registerconsultant({
    required List<String>
        title_experience, // Menggunakan List untuk title_experience
    required List<String>
        description_experience, // Menggunakan List untuk description_experience
    required List<String> documents, // Menggunakan List untuk document
  }) async {
    try {
      // Membuat FormData untuk mengirim data
      FormData formData = FormData();

      // Menambahkan title dan description
      formData.fields
          .add(MapEntry('title_experience', title_experience.join(',')));
      formData.fields.add(
          MapEntry('description_experience', description_experience.join(',')));

      // Menambahkan semua dokumen ke formData
      for (String document in documents) {
        formData.files.add(
            MapEntry('document[]', await MultipartFile.fromFile(document)));
      }

      // Mengirim data ke server
      Response res = await dio.post(
        ApiEndpoint.registerConsultant,
        data: formData,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token,
            'Accept': 'application/json',
            // Content-Type tidak perlu ditentukan di sini, dio akan mengatur otomatis
          },
        ),
      );

      if (res.statusCode == 200) {
        return Either.success(ResRegistConsultant.fromJson(res.data));
      } else {
        return Either.error(ErrorHandler.handle(res).failure);
      }
    } catch (e, st) {
      debugPrint("Error: $e");
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResApprovalConsultant>> getSummary(
      {String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getSummaryApproval,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResApprovalConsultant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResHomeConsultant>> getHomeConsultant(
      {String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getHomeConsultant,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResHomeConsultant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetParticipant>> getListParticipant(
      {String? parameter}) async {
    try {
      // Membentuk URL dengan menambahkan parameter category ke query string jika parameter tidak null
      String url =
          '${ApiEndpoint.getParticipant}?category=${parameter ?? 'archive'}';

      // Melakukan request GET
      Response res = await dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token, // Header Authorization
          },
        ),
      );

      // Mengembalikan hasil response dari API
      return Either.success(ResGetParticipant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResponseDetailConsultant>> getDetailConsultant(
      String id) async {
    try {
      // Membentuk URL dengan menambahkan parameter category ke query string jika parameter tidak null
      String url =  ApiEndpoint.getDetailConsultant(id);

      // Melakukan request GET
      Response res = await dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token, // Header Authorization
          },
        ),
      );

      // Mengembalikan hasil response dari API
      return Either.success(ResponseDetailConsultant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResponseGetTopic>> getTopicConsultant(
      String id) async {
    try {
      // Membentuk URL dengan menambahkan parameter category ke query string jika parameter tidak null
      String url =  ApiEndpoint.getTopicConsultant(id);

      // Melakukan request GET
      Response res = await dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token, // Header Authorization
          },
        ),
      );

      // Mengembalikan hasil response dari API
      return Either.success(ResponseGetTopic.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResponseFollowConsultant>> followConsultant(String id, String status) async {
    try {
      // Endpoint URL
      String url = ApiEndpoint.followConsultant(id);

      // Body yang dikirim
      Map<String, dynamic> body = {
        "foll": status,
      };

      // Melakukan request PUT
      Response res = await dio.put(
        url,
        data: body,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token, // Header Authorization
          },
        ),
      );

      // Mengembalikan hasil response dari API
      return Either.success(ResponseFollowConsultant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResGetTerm>> getTermCondition({String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getTermConsultant,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetTerm.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResGetComissen>> getComissen({String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.getHistoryCommission,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetComissen.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResUpdateStatus>> updateStatus(int Status) async {
    try {
      Response res = await dio.post(
          ApiEndpoint.updateAvailable(dataGlobal.dataConsultant?.id),
          data: {
            "available_status": Status,
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResUpdateStatus.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResApproveByConsultant>> ApproveByConsultant(
      int consultationId, String status,
      {String? note}) async {
    try {
      final data = {
        "consultation_id": consultationId,
        "status_approval": status,
        if (note != null)
          "note_consultant": note, // Menambahkan hanya jika note tidak null
      };

      Response res = await dio.post(
        ApiEndpoint.approveByConsultant,
        data: data,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {'Authorization': dataGlobal.token},
        ),
      );

      return Either.success(ResApproveByConsultant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ResCheckSession>> checkSession(
      {String? token}) async {
    try {
      Response res = await dio.get(ApiEndpoint.checkSession,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResCheckSession.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResCheckSessionConsultant>> checkSessionConsultant() async {
    try {
      Response res = await dio.get(ApiEndpoint.checkSession,
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResCheckSessionConsultant.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResponseCreateConsultation>> createConsultation({
    required String consultantId,
    required String themeId,
    required String participantExplanation,
    required String typeSession,
    required String time,
  }) async {
    try {
      final String url = "${ApiEndpoint.baseUrl}/api/consultation/create-consultation";

      Map<String, dynamic> data = {
        "consultant_id": consultantId,
        "theme_id": themeId,
        "participant_explanation": participantExplanation,
        "type_session": typeSession,
        "time": time
      };

      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer ${dataGlobal.token}",
            "Content-Type": "application/json",
          },
          validateStatus: (status) => status == 200 || status == 201 || status == 400,
        ),
      );

      return Either.success(ResponseCreateConsultation.fromJson(response.data));
    } catch (e, st) {
      print("Error create consultation: $st");
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResponseJoin>> joinroom(
      {String? token, String? id}) async {
    try {
      Response res = await dio.post(ApiEndpoint.joinSession(id),
          data: {
            "is_present": "present", // << Tambahkan payload di sini
          },
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResponseJoin.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResStopSession>> StopSession(String id, String type, String idDocument) async {
    try {
      // Endpoint URL
      String url = ApiEndpoint.postEndSession;     // Body yang dikirim
      Map<String, dynamic> body = {
        "consultation_id": id,
        "is_status" : 1,
        "type_session" : type,
        "document_id" : idDocument,
      };

      // Melakukan request PUT
      Response res = await dio.post(
        url,
        data: body,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token, // Header Authorization
          },
        ),
      );

      // Mengembalikan hasil response dari API
      return Either.success(ResStopSession.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResCheckPrice>> GetPrice(String timestart, String timeend, String day, String type) async {
    try {
      // Endpoint URL
      String url = '${ApiEndpoint.getPrice}?time_start=${timestart}&time_end=${timeend}&day=${day}&type_consultation=${type}';     // Body yang dikirim
      // Melakukan request PUT
      Response res = await dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token, // Header Authorization
          },
        ),
      );

      // Mengembalikan hasil response dari API
      return Either.success(ResCheckPrice.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResPaymentKonsultasi>> PayMentConsultasi(String idconsultation, String type , String harga) async {
    try {
      // Endpoint URL
      String url = ApiEndpoint.payProfiling;     // Body yang dikirim
      Map<String, dynamic> body = {
        "id_consultations": idconsultation,
        "id_item_payments": 6,
        "discount": 0,
        "transaction_type": type,
        "price": harga,
        "gateway": "midtrans"
      };

      // Melakukan request PUT
      Response res = await dio.post(
        url,
        data: body,
        options: Options(
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
          headers: {
            'Authorization': dataGlobal.token, // Header Authorization
          },
        ),
      );

      // Mengembalikan hasil response dari API
      return Either.success(ResPaymentKonsultasi.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st); // Menampilkan error jika ada
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


  Future<Either<Failure, ResGetChatArchived>> getChatArcived(String id) async {
    try {
      Response res = await dio.get(ApiEndpoint.getArchiveChat(id),
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
            headers: {'Authorization': dataGlobal.token},
          ));

      return Either.success(ResGetChatArchived.fromJson(res.data));
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return Either.error(ErrorHandler.handle(e).failure);
    }
  }


}
