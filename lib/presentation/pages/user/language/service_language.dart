import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../data/data_global.dart';
import '../../../../data/networks/dio_handler.dart';
import 'model_language.dart';

class LocaleService {
  final Dio _dio = Dio();
  final String _baseUrl = '${ApiEndpoint.baseUrl}/api/locale';

  Future<List<LocaleModel>> fetchLocales() async {
    try {
      final response = await _dio.get(_baseUrl);
      if (response.statusCode == 200 && response.data['success'] == true) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LocaleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch locales');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class PostLocaleService {
  Future<List<LocaleModel>> postfetchLocales() async {
    try {
      dynamic postIdLocale = await PreferenceHandler.retrieveIdLanguage();
      final response =
          await dio.post('${ApiEndpoint.baseUrl}/api/locale/swap-locale',
              data: {"locale_id": postIdLocale.toString()},
              options: Options(
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                headers: {'Authorization': dataGlobal.token},
              ));
      debugPrint("cek lo $response");
      if (response.statusCode == 200 && response.data['success'] == true) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LocaleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch locales');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
