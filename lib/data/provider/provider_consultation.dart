import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/response/consultation/res_get_theme.dart';
import 'package:coolappflutter/data/response/consultation/res_list_consultation.dart';
import 'package:coolappflutter/data/response/consultation/res_list_time.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../locals/shared_pref.dart';
import '../response/consultation/res_detail_consultant.dart';
import '../response/consultation/res_list_consultant_person.dart';

class ProviderConsultation extends ChangeNotifier {
  ProviderConsultation();

  ProviderConsultation.initList(BuildContext context, String type) {
    getListConsultations(context, "active");
  }

  List<Data> _consultations = [];
  List<Themes> _getThemes = [];

  bool _isLoading = false;

  List<Data> get consultations => _consultations;
  List<Themes> get getThemes => _getThemes;

  bool get isLoading => _isLoading;

  Future<void> getListConsultations(BuildContext context, String type) async {
    _isLoading = true;
    notifyListeners();

    final String? token = await Prefs().getToken();
    final Dio dio = Dio();
    final String url = "${ApiEndpoint.getListConsultation}/?type=$type";

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final responseData = ResponseListConsultation.fromJson(response.data);
        _consultations = responseData.datas?.data ?? [];
        print('input data oke');
      } else {
        throw Exception('Failed to load consultations');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getListTheme(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final String? token = await Prefs().getToken();
    final Dio dio = Dio();
    final String url = ApiEndpoint.getListTheme;

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final responseData = ResponseListTheme.fromJson(response.data);
        _getThemes = responseData.datas?.data ?? [];
      } else {
        throw Exception('Failed to load consultations');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  SessionData? sessionData;
  Future<void> getListTime(BuildContext contex, String time) async {
    _isLoading = true;
    notifyListeners();

    final String? token = await Prefs().getToken();
    final Dio dio = Dio();
    final String url = ApiEndpoint.getListTime(time);
    debugPrint("timeeee");

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final responseData = ResponseSessionTimes.fromJson(response.data);
        debugPrint("timeeee $responseData");
        sessionData = responseData.data;
      } else {
        throw Exception('Failed to load consultations');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<DataConsultan> _consultantPerson = [];

  List<DataConsultan> get consultantsPerson => _consultantPerson;

  Future<void> getListConsultanPerson(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final String? token = await Prefs().getToken();
    final Dio dio = Dio();
    final String url = ApiEndpoint.getListConsultanPerson;

    try {
      final response = await dio.get(
        url,
        // data: {
        //   "type_session": "consultation",
        // },
        queryParameters: {
          'type_session': 'consultation',
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      final responseData = ResponseListConsultant.fromJson(response.data);
      debugPrint("${responseData.data?.data}");

      if (response.statusCode == 200) {
        final responseData = ResponseListConsultant.fromJson(response.data);
        _consultantPerson = responseData.data?.data ?? [];
      } else {
        throw Exception('Failed to load consultations');
      }
    } catch (error) {
      debugPrint("cek e $error");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  DataDetailConsultant? _detailConsultant;

  DataDetailConsultant? get detailConsultant => _detailConsultant;
  // Properti untuk menyimpan detail konsultasi
  String? image;
  String? name;
  String? typebrain;
  String? typeblood;
  String? address;
  Future<void> getDetailConsultant(int id) async {
    _isLoading = true;
    notifyListeners();

    final String? token =
        await Prefs().getToken(); // Mengambil token dari shared preferences
    final Dio dio = Dio();
    final String url = ApiEndpoint.getDetailConsultant(id);

    debugPrint("tes detaill");

    try {
      final response = await dio.get(
        "${ApiEndpoint.baseUrl}/api/consultant/get-list-consultant?consultant_id=$id",
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final responseData = ResponseDetailConsultant.fromJson(response.data);
        _detailConsultant = responseData.data;
        image = responseData.data!.image.toString();
        name = responseData.data!.name.toString();
        typebrain = responseData.data!.typeBrain.toString();
        typeblood = responseData.data!.typeBlood.toString();
        address = responseData.data!.address.toString();
        debugPrint("tes detaill ${responseData.data!.name.toString()}");
        notifyListeners();
      } else {
        throw Exception('Failed to fetch consultant details');
      }
    } catch (error) {
      debugPrint('Error fetching details: $error');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> fetchConsultantsPerson(BuildContext context) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     final response = await Dio().get(
  //       'https://staging-cool.hantrr.com/api/consultant/get-list-consultant?page=1',
  //     );

  //     _consultantPerson = responseListConsultantFromJson(response.data);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to fetch consultants: $e')),
  //     );
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // RepoConsultation repo = RepoConsultation();
  // List<Data> listConsultation = [];

  // Future<void> getListConsultations(BuildContext context) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   Either<Failure, ResponseListConsultation> response =
  //       await repo.getListColcultation();

  //   response.when(error: (e) {
  //     NotificationUtils.showDialogError(context, () {
  //       Nav.back();
  //     },
  //         widget: Text(
  //           e.message,
  //           textAlign: TextAlign.center,
  //           style: const TextStyle(fontSize: 16),
  //         ),
  //         textButton: S.of(context).back);
  //   }, success: (res) async {
  //     if (res.datas != null) {
  //       _consultations = res.datas?.data ?? [];
  //       notifyListeners();
  //     }
  //   });
  //   notifyListeners();
  // }

  bool _isRequesting = false;

  Future<void> createConsultation(
      BuildContext context,
      String consulId,
      String timeId,
      String partisipant,
      String typeSeesion,
      String time) async {
    if (_isRequesting) return; // Cegah pemanggilan ganda
    _isRequesting = true;

    try {
      final String? token = await Prefs().getToken();
      final Dio dio = Dio();

      final String baseUrl =
          "${ApiEndpoint.baseUrl}/api/consultation/create-consultation";

      if (token == null) {
        throw Exception("Token tidak ditemukan, silakan login kembali.");
      }

      Map<String, dynamic> data = {
        "consultant_id": consulId,
        "theme_id": timeId,
        "participant_explanation": partisipant,
        "type_session": typeSeesion,
        "time": time
      };

      Response response = await dio.post(
        baseUrl,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Consultation created successfully: ${response.data}");
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              response.statusMessage.toString(),
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ));
        debugPrint("Failed to create consultation: ${response.statusMessage}");
      }
    } catch (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.toString(),
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ));
    } finally {
      _isRequesting = false; // Reset flag setelah selesai
    }
  }

}
