import 'dart:convert';
import 'package:coolappflutter/presentation/pages/auth/component/map_selection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationProvider with ChangeNotifier {
  List<String> _countries = [];
  List<String> _states = [];
  List<String> _provinces = [];
  double? _latitude;
  double? _longitude;

  List<String> get countries => _countries;
  List<String> get states => _states;
  List<String> get provinces => _provinces;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? selectedDistrict; // Menambah field untuk district
  LatLng? selectedPosition;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchCountries() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk&input=',
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _countries = List<String>.from(
          data['predictions']?.map((item) => item['description']) ?? [],
        );
      } else {
        throw Exception("Failed to load countries");
      }
    } catch (e) {
      debugPrint("Error fetching countries: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<String?> getNearestCountry() async {
  //   try {
  //     if (_latitude != null && _longitude != null) {
  //           // Mendapatkan alamat terformat berdasarkan lat, long
  //     List<Placemark> placemarks = await placemarkFromCoordinates(_latitude!, _longitude!);

  //     // Mendapatkan negara dari hasil geocoding
  //     String country = placemarks.isNotEmpty ? placemarks[0].country ?? "Unknown" : "Unknown";

  //       final response = await http.get(
  //         Uri.parse(
  //             'https://maps.googleapis.com/maps/api/geocode/json?latlng=$_latitude,$_longitude&key=AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk'),
  //       );
  //       if (response.statusCode == 200) {
  //         final data = jsonDecode(response.body);
  //         final country = data['results']?.firstWhere(
  //           (result) => result['types']?.contains('country') ?? false,
  //           orElse: () => null,
  //         )?['formatted_address'];
  //         return country;
  //       } else {
  //         throw Exception("Failed to fetch nearest country");
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint("Error getting nearest country: $e");
  //   }
  //   return null;
  // }

  Future<String?> getNearestCountry() async {
    debugPrint("Mauk Nerest");
    try {
      if (_latitude != null && _longitude != null) {
        // Mendapatkan alamat terformat berdasarkan lat, long
        List<Placemark> placemarks =
            await placemarkFromCoordinates(_latitude!, _longitude!);

        // Mendapatkan negara dari hasil geocoding
        String country = placemarks.isNotEmpty
            ? placemarks[0].country ?? "Unknown"
            : "Unknown";
        return country;
      }
    } catch (e) {
      debugPrint("Error getting nearest country: $e");
    }
    return null;
  }

  Future<void> fetchStates(String country) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk&input=$country'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _states = List<String>.from(
            data['predictions'].map((item) => item['description']));
      } else {
        throw Exception("Failed to load states");
      }
    } catch (e) {
      debugPrint("Error fetching states: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProvinces(String state) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk&input=$state'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _provinces = List<String>.from(
            data['predictions'].map((item) => item['description']));
      } else {
        throw Exception("Failed to load provinces");
      }
    } catch (e) {
      debugPrint("Error fetching provinces: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled.");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          throw Exception("Location permission denied.");
        }
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _latitude = position.latitude;
      _longitude = position.longitude;
      notifyListeners();
      debugPrint("Current Location: Lat=$_latitude, Lng=$_longitude");
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  // Future<void> fetchCurrentLocationAndUpdateCountry() async {
  //   try {
  //     // Mendapatkan latitude dan longitude saat ini
  //     await fetchCurrentLocation();

  //     // Mendapatkan negara terdekat dari lat, long
  //     final nearestCountry = await getNearestCountry();

  //     if (nearestCountry != null) {
  //       // Memasukkan negara terdekat ke dalam list
  //       _countries = [nearestCountry];
  //       notifyListeners(); // Men-trigger pembaruan UI
  //     } else {
  //       // Jika tidak ada negara yang ditemukan, beri pesan atau lakukan tindakan lain
  //       debugPrint("No country found for the given coordinates.");
  //     }
  //   } catch (e) {
  //     debugPrint("Error fetching and updating country: $e");
  //   }
  // }

  Future<void> fetchCurrentLocationAndUpdateCountry() async {
    try {
      // Mendapatkan latitude dan longitude saat ini
      await fetchCurrentLocation();

      // Mendapatkan negara terdekat dari lat, long menggunakan geocoding
      final nearestCountry = await getNearestCountry();

      if (nearestCountry != null) {
        debugPrint("nerest value $nearestCountry");
        // Memasukkan negara terdekat ke dalam list
        _countries = [nearestCountry];
        notifyListeners(); // Men-trigger pembaruan UI
      }
    } catch (e) {
      debugPrint("Error fetching and updating country: $e");
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _latitude = position.latitude;
      _longitude = position.longitude;
      notifyListeners();

      debugPrint("Current Location: Lat=$_latitude, Lng=$_longitude");
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String googleApiKey =
      "AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk"; // Ganti dengan API Key Anda
  double? selectedLatitude;
  double? selectedLongitude;

  // Fungsi untuk mengambil alamat dari Geocoding API Google
  Future<void> fetchLocationData(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleApiKey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        String? country;
        String? state;
        String? city;
        String? district; // Menambahkan district

        for (var result in data['results']) {
          for (var component in result['address_components']) {
            if (component['types'].contains('country')) {
              country = component['long_name'];
            } else if (component['types']
                .contains('administrative_area_level_1')) {
              state = component['long_name'];
            } else if (component['types'].contains('locality')) {
              city = component['long_name'];
            } else if (component['types']
                .contains('administrative_area_level_3')) {
              district = component['long_name']; // Ambil distrik
            }
          }
        }

        selectedCountry = country;
        selectedState = state;
        selectedCity = city ?? '-';
        selectedDistrict = district; // Menyimpan district
        selectedPosition =
            LatLng(latitude, longitude); // Menyimpan posisi yang dipilih
        notifyListeners();
      } else {
        print("Error: ${data['status']}");
      }
    } else {
      print("Failed to fetch location data");
    }
  }

  // Fungsi untuk membuka map dan memilih lokasi
  openMap(BuildContext context) async {
    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MapSelectionScreen(
          initialPosition: LatLng(-6.1751, 106.8650), // Default position
        ),
      ),
    );

    if (result != null) {
      selectedLatitude = result.latitude;
      selectedLongitude = result.longitude;
      notifyListeners();
      fetchLocationData(selectedLatitude!, selectedLongitude!);
    }
  }
}
// class LocationProvider with ChangeNotifier {
//   List<String> _countries = [];
//   List<String> _states = [];
//   List<String> _provinces = [];

//   List<String> get countries => _countries;
//   List<String> get states => _states;
//   List<String> get provinces => _provinces;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   Future<void> fetchCountries() async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       final response = await http.get(
//         Uri.parse(
//           'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk&input=a',
//         ),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _countries = List<String>.from(
//           data['predictions']?.map((item) => item['description']) ?? [],
//         );
//       } else {
//         throw Exception("Failed to load countries");
//       }
//     } catch (e) {
//       debugPrint("Error fetching countries: $e");
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> fetchStates(String country) async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk&input=$country'),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _states = List<String>.from(
//             data['predictions'].map((item) => item['description']));
//       } else {
//         throw Exception("Failed to load states");
//       }
//     } catch (e) {
//       debugPrint("Error fetching states: $e");
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> fetchProvinces(String state) async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk&input=$state'),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _provinces = List<String>.from(
//             data['predictions'].map((item) => item['description']));
//       } else {
//         throw Exception("Failed to load provinces");
//       }
//     } catch (e) {
//       debugPrint("Error fetching provinces: $e");
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
