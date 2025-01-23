import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CountryStateCityProvider with ChangeNotifier {
  final Dio _dio = Dio();

  List<dynamic> countries = [];
  List<dynamic> states = [];
  List<dynamic> cities = [];
  List<dynamic> district = [];

  int? selectedCountryId;
  int? selectedStateId;
  int? selectedCityId;
  int? selectedDistrictId;

  // Set selected IDs
  void setSelectedCountryId(int id) {
    selectedCountryId = id;

    selectedStateId = null;
    selectedCityId = null;
    selectedDistrictId = null;

    // notifyListeners();
  }

  void setSelectedStateId(int id) {
    selectedStateId = id;
    selectedCityId = null;
    selectedDistrictId = null;
    // notifyListeners();
  }

  void setSelectedCityId(int id) {
    selectedCityId = id;
    selectedDistrictId = null;

    // notifyListeners();
  }

  void setSelectedDistrictId(int id) {
    selectedDistrictId = id;
    // notifyListeners();
  }

  Future<void> fetchCountries(int countryId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoint.baseUrl}/api/geoloc/country',
      );
      notifyListeners();
      if (response.data['success']) {
        countries = response.data['data'];
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching countries: $e');
    }
  }

  Future<void> fetchStates(int countryId) async {
    try {
      // selectedCountryId = countryId;
      states = [];
      cities = [];
      // selectedStateId = null;
      // selectedCityId = null;
      notifyListeners();

      final response = await _dio.post(
        '${ApiEndpoint.baseUrl}/api/geoloc/state',
        data: {'country_id': countryId},
      );
      if (response.data['success']) {
        states = response.data['data'];
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching states: $e');
    }
  }

  Future<void> fetchCities(int countryId, int stateId) async {
    try {
      // selectedCountryId = countryId;
      // selectedStateId = stateId;

      cities = [];
      // selectedCityId = null;
      notifyListeners();
      debugPrint("state : $stateId, country : $countryId");
      final response = await _dio.post(
        '${ApiEndpoint.baseUrl}/api/geoloc/city',
        data: {
          'state_id': stateId,
          'country_id': countryId,
        },
      );
      debugPrint("$response");
      if (response.data['success']) {
        cities = response.data['data'];
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching cities: $e');
    }
  }

  // void selectCity(int cityId) {
  //   selectedCityId = cityId;
  //   notifyListeners();
  // }

  Future<void> fetchDistricts(int countryId, int stateId, int cityId) async {
    String url = '${ApiEndpoint.baseUrl}/api/geoloc/district';
    debugPrint("state : $stateId, country : $countryId , cityId $cityId");
    final body = {
      'country_id': countryId,
      'state_id': stateId,
      'city_id': cityId,
    };
    // selectedCountryId = countryId;
    // selectedStateId = stateId;
    // selectedCityId = cityId;

    notifyListeners();

    try {
      final response = await _dio.post(url, data: body);
      debugPrint("res : $response");
      if (response.data['success']) {
        district = List<Map<String, dynamic>>.from(response.data['data']);
        notifyListeners();
      } else {
        print('Failed to fetch districts: ${response.data['message']}');
      }
    } catch (e) {
      print('Error fetching districts: $e');
    }
  }

  // Post address to server
  Future<void> postAddress({
    required int userId,
    required double? longitude,
    required double? latitude,
  }) async {
    if (selectedCountryId == null ||
        selectedStateId == null ||
        selectedCityId == null ||
        selectedDistrictId == null) {
      throw Exception(
          "All fields must be selected before posting the address.");
    }

    final body = {
      "user_id": userId,
      "country_id": selectedCountryId!,
      "state_id": selectedStateId!,
      "city_id": selectedCityId!,
      "district_id": selectedDistrictId!,
      "longitude": longitude.toString(),
      "latitude": latitude.toString(),
    };

    try {
      final response = await _dio.post(
        '${ApiEndpoint.baseUrl}/api/geoloc/post-address',
        data: body,
      );

      if (response.data['success'] == true) {
        print("Address posted successfully: ${response.data['data']}");
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      print("Error posting address: $e");
      rethrow;
    }
  }
}
