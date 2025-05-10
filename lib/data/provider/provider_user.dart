// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/networks/dio_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/repositories/repo_user.dart';
import 'package:coolappflutter/data/response/user/res_address.dart';
import 'package:coolappflutter/data/response/user/res_category_bug.dart';
import 'package:coolappflutter/data/response/user/res_check_profile.dart';
import 'package:coolappflutter/data/response/user/res_get_deetail_report.dart';
import 'package:coolappflutter/data/response/user/res_get_location_member.dart';
import 'package:coolappflutter/data/response/user/res_get_log_report.dart';
import 'package:coolappflutter/data/response/user/res_get_total_saldo.dart';
import 'package:coolappflutter/data/response/user/res_get_user.dart';
import 'package:coolappflutter/data/response/user/res_report_bug.dart';
import 'package:coolappflutter/data/response/user/res_update_photo_user.dart';
import 'package:coolappflutter/data/response/user/res_update_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/user/screen_profile.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/get_country.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

import '../../presentation/pages/auth/component/country_state_city_provider.dart';
import '../../presentation/pages/auth/component/map_selection.dart';
import '../locals/preference_handler.dart';

class ProviderUser extends ChangeNotifier {
  ///deleted account
  bool _isLoadingsss = true;

  bool get isLoadingsss => _isLoadingsss;

  void setLoading(bool value) {
    _isLoadingsss = value;
    notifyListeners();
  }

  ///
  ProviderUser();

  ProviderUser.initMemberArea(BuildContext context) {
    getMemberArea(context);
    // getUser(context);
  }

  RepoUser repo = RepoUser();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController SelectedCountryController = TextEditingController();
  TextEditingController SelectedStateController = TextEditingController();
  TextEditingController SelectedCityController = TextEditingController();
  TextEditingController SelectedDistrictController = TextEditingController();
  TextEditingController SelectedLongtitudeController = TextEditingController();
  TextEditingController SelectedLatitudeController = TextEditingController();
  int countryssId = 0;
  int stateId = 0;
  int cityssId = 0;
  int disctrictId = 0;


  dynamic initialCodeCountry = "ID";
  dynamic initialDialCode = "62";
  dynamic phoneNumberWithoutCode;
  String ipCountry = "Indonesia";
  final provider = Provider.of<CountryStateCityProvider>;

  /// Sets the initial values for the text controllers based on the dataUser object in the global data.
  ///
  /// This function retrieves the name, email, idCardNumber, and address from the dataUser object in the global data,
  /// and assigns them to the corresponding text controllers. It then calls the `setPhoneNumber` function to set the initial values for the phone number controller.
  void setInitialValues(value) {
    nameController.text = dataGlobal.dataUser?.name ?? "";
    emailController.text = dataGlobal.dataUser?.email ?? "";
    idCardController.text = dataGlobal.dataUser?.idCardNumber ?? "";
    addressController.text = dataGlobal.dataUser?.address ?? "";
    SelectedCountryController.text = dataAddress?.country?.toString() ?? "";
    SelectedStateController.text = dataAddress?.state?.toString() ?? "";
    SelectedCityController.text = dataAddress?.city?.toString() ?? "";
    SelectedDistrictController.text = dataAddress?.district?.toString() ?? "";


    setPhoneNumber(value);
  }

  void setSelectedCountryId(value) {
    countryssId = value;
    notifyListeners();
  }

  void setSelectedStateId(value) {
    stateId = value;
    notifyListeners();
  }

  void setSelectedCityId(value) {
    cityssId = value;
    notifyListeners();
  }

  void setSelectedDistrictId(value) {
    disctrictId = value;
    notifyListeners();
  }

  double? _latitude;
  double? _longitude;
  double? selectedLatitude;
  double? selectedLongitude;

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

  openMap(BuildContext context) async {
    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const MapSelectionScreen(
          initialPosition: LatLng(-6.1751, 106.8650), // Default position
        ),
      ),
    );

    if (result != null) {
      selectedLatitude = result.latitude;
      selectedLongitude = result.longitude;
      notifyListeners();
      // fetchLocationData(selectedLatitude!, selectedLongitude!);
    }
  }

  /// Checks if the current user's phone number and IP country are both from Indonesia.
  ///
  /// This function retrieves the user's phone number and IP country using the `getLocalePhonenumber` method.
  /// It then checks if the initial code country is "ID" (Indonesia) and if the IP country is also "Indonesia".
  /// If both conditions are met, it returns `true`, otherwise it returns `false`.
  ///
  /// Returns:
  ///   - `true` if the initial code country is "ID" and the IP country is "Indonesia".
  ///   - `false` otherwise.
  bool isIndonesia() {
    getLocalePhonenumber();
    if (initialCodeCountry == "ID"
    // && ipCountry == "Indonesia"
    ) {
      return true;
    } else {
      return false;
    }
  }

  // Retrieves the user's phone number from the global data, gets the country information based on the phone number,
  // assigns the country code and dial code to the initial variables, and notifies the listeners.
  void getLocalePhonenumber() {
    String phoneNumber = dataGlobal.dataUser?.phoneNumber.toString() ?? "";
    Country country = PhoneNumber.getCountry(phoneNumber);
    initialCodeCountry = country.code;
    initialDialCode = country.dialCode;
    notifyListeners();
  }

  void setPhoneNumber(value) {
    /// Sets the phone number for the user.
    ///
    /// This function retrieves the user's phone number from the global data,
    /// gets the country information based on the phone number, assigns the country code
    /// and dial code to the initial variables, and updates the phone number controller.
    /// The function then notifies the listeners.
    ///
    /// Parameters:
    ///   - None
    ///
    /// Returns:
    ///   - None
    String phoneNumber = value ?? "";
    Country country = PhoneNumber.getCountry(value);

    initialCodeCountry = country.code;
    initialDialCode = country.dialCode;

    // Hapus kode negara dari nomor telepon
    phoneNumberWithoutCode = phoneNumber.substring(initialDialCode.length);

    phoneController.text = phoneNumber;

    notifyListeners();

    Future.microtask(() {
      notifyListeners();
    });
  }

  DataUser? dataUser;
  DataAddress? dataAddress;

  bool isLoading = false;

  //update user
  /// Updates the user with the provided information.
  ///
  /// Parameters:
  ///   - `context`: The build context of the widget calling this function.
  ///
  /// Returns:
  ///   - `Future<void>`: A future that completes when the user is updated.
  ///
  /// Throws:
  ///   - `Failure`: If there is an error updating the user.
  ///
  /// Side effects:
  ///   - Sets `isLoadingUpdateUser` to `true` and notifies listeners.
  ///   - Calls `repo.updateUser` with the provided user information.
  ///   - Sets `isLoadingUpdateUser` to `false` and notifies listeners.
  ///   - Shows a dialog error if there is an error updating the user.
  ///   - Shows a dialog success if the user is updated successfully.
  ///   - Calls `getUser` if the user is updated successfully.
  ///   - Notifies listeners.
  bool isLoadingUpdateUser = false;

  Future<void> updateUser(BuildContext context) async {
    isLoadingUpdateUser = true;
    notifyListeners();
    Either<Failure, ResUpdateUser> response = await repo.updateUser(
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        idCardNumber: idCardController.text,
        address: addressController.text,
        country: SelectedCountryController.text,
        state: SelectedStateController.text,
        city: SelectedCityController.text,
        district: SelectedDistrictController.text,
        longtitude: SelectedLongtitudeController.text,
        latitude: SelectedLatitudeController.text,
    );


    isLoadingUpdateUser = false;
    debugPrint("negara yang di pilih ${SelectedCountryController.text}");
    debugPrint("state yang di pilih ${SelectedStateController.text}");
    debugPrint("city yang di pilih ${SelectedCityController.text}");
    debugPrint("distrik yang di pilih ${SelectedDistrictController.text}");
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
          textButton: S
              .of(context)
              .back);
    }, success: (res) async {
      if (res.errors != null) {
        NotificationUtils.showDialogError(
          context,
              () {
            Nav.back();
          },
          textButton: S
              .of(context)
              .back,
          widget: Text(
            res.message ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }
      if (res.success == true) {
        // await getUser(context);
        NotificationUtils.showDialogSuccess(context, () async {
          await getUser(context);
          Nav.back();
          Nav.back();
        },
            widget: Center(
              child: Text(
                S
                    .of(context)
                    .successfully_updated_user,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ));
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              res.message ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: S
                .of(context)
                .back);
      }
    });

    notifyListeners();
  }

  //get user
  /// Retrieves the user data asynchronously.
  ///
  /// Parameters:
  ///   - `context`: The build context of the widget calling this function.
  ///
  /// Returns:
  ///   - `Future<void>`: A future that completes when the user data is retrieved.
  ///
  /// Side effects:
  ///   - Sets `isLoading` to `true` and notifies listeners.
  ///   - Calls `repo.getUser` to retrieve the user data.
  ///   - Sets `isLoading` to `false` and notifies listeners.
  ///   - Shows a dialog error if there is an error retrieving the user data.
  ///   - Updates the `dataUser` and `dataGlobal.dataUser` with the retrieved user data.
  ///   - Notifies listeners.
  Future<void> getUser(BuildContext context,) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResGetUser> response = await repo.getUser();

    isLoading = false;
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
          textButton: S
              .of(context)
              .back);
    }, success: (res) async {
      if (res.success == true) {
        dataUser = res.data;
        debugPrint("id user from provider user ${dataUser!.id.toString()}");
        await PreferenceHandler.storingIdUser(dataUser!.id.toString());
        // if (res.data?.role?.id == 2) {
        dataGlobal.dataUser = res.data;
        // }

        getCountryCode();

        notifyListeners();
      }
    });

    notifyListeners();
  }

  Future<void> getAddress(BuildContext context,) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, AddressResponse> response = await repo.getAddress();

    isLoading = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            'Silahkan pin Lokasi Anda',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          textButton: 'Oke');
    }, success: (res) async {
      if (res.success == true) {
        dataAddress = res.data;

        notifyListeners();
      }
    });

    notifyListeners();
  }

  bool isMemberArea = false;
  MemberArea? memberArea;

  Future<void> getMemberArea(BuildContext context) async {
    isMemberArea = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResMemberArea> response = await repo.cekMemberArea();

    isMemberArea = false;
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
          textButton: S
              .of(context)
              .back);
    }, success: (res) async {
      if (res.success == true) {
        memberArea = res.data;
        dataGlobal.dataMember = res.data;
        ipCountry = memberArea?.country.toString() ?? "";
        notifyListeners();
      }
    });

    notifyListeners();
  }

  bool isProfileUser = false;
  XFile? image;

  /// Updates the profile user with the provided photo.
  ///
  /// Parameters:
  ///   - `context`: The build context of the widget calling this function.
  ///   - `photo`: The photo to update the profile with.
  ///   - `onUpdate`: An optional callback function to be called after the update is complete.
  ///
  /// Returns:
  ///   - `Future<void>`: A future that completes when the profile user is updated.
  ///
  /// Side effects:
  ///   - Sets `isProfileUser` to `true` and notifies listeners.
  ///   - Calls `repo.updatePhotoUser` with the provided photo.
  ///   - Sets `isProfileUser` to `false` and notifies listeners.
  ///   - Shows a dialog error if there is an error updating the profile user.
  ///   - Calls `getUser` if the update is successful.
  ///   - Notifies listeners.
  Future<void> updateProfileUser(BuildContext context, XFile photo,
      {Function? onUpdate}) async {
    isProfileUser = true;
    notifyListeners();
    Either<Failure, ResUpdateProfile> response =
    await repo.updatePhotoUser(photo);

    isProfileUser = false;
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
          textButton: S
              .of(context)
              .back);
    }, success: (res) async {
      if (res.success == false) {
        NotificationUtils.showDialogError(
          context,
              () {
            Nav.back();
          },
          textButton: S
              .of(context)
              .back,
          widget: Text(
            res.message ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }
      if (res.success == true) {
        NotificationUtils.showSnackbar(
            S
                .of(context)
                .update_photo_profile_success,
            backgroundColor: primaryColor);
        await getUser(context);
      } else {
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              res.message ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            textButton: S
                .of(context)
                .back);
      }
    });

    notifyListeners();
  }

  /// Checks the user's profile by making a request to the repository.
  ///
  /// Parameters:
  ///   - `context`: The build context of the widget calling this function.
  ///
  /// Returns:
  ///   - `Future<void>`: A future that completes when the profile is checked.
  ///
  /// Side effects:
  ///   - Shows a dialog error if there is an error checking the profile.
  ///   - Navigates back if the profile is not successful.
  ///   - Navigates to the profile screen if the profile is not successful.
  ///   - Recursively calls `checkProfile` if the profile is not successful.
  ///   - Notifies listeners.
  /// Checks the user's profile by making a request to the repository.
  ///
  /// Parameters:
  ///   - `context`: The build context of the widget calling this function.
  ///
  /// Returns:
  ///   - `Future<void>`: A future that completes when the profile is checked.
  ///
  /// Side effects:
  ///   - Shows a dialog error if there is an error checking the profile.
  ///   - Navigates back if the profile is not successful.
  ///   - Navigates to the profile screen if the profile is not successful.
  ///   - Recursively calls `checkProfile` if the profile is not successful.
  ///   - Notifies listeners.
  Future<void> checkProfile(BuildContext context) async {
    Either<Failure, ResCheckProfile> response = await repo.checkProfile();
    response.when(
      error: (e) {
        notifyListeners();
        NotificationUtils.showDialogError(context, () {
          Nav.back();
        },
            widget: Text(
              e.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ));
      },
      success: (res) {
        if (res.success != true) {
          notifyListeners();
          NotificationUtils.showDialogError(context, () async {
            notifyListeners();
            Nav.back();
            await Nav.to(ScreenProfile(
              phone: dataGlobal.dataUser?.phoneNumber.toString(),
            ));
            // checkProfile(context);
          },
              widget: Text(
                res.message ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ));
        }
      },
    );
    notifyListeners();
  }

  bool isLoadingGetTotalSaldo = false;

  String _totalDeposit = "0";

  // Getter untuk totalDeposit
  String get totalDeposit => _totalDeposit;

  // Setter untuk totalDeposit
  set totalDeposit(String newTotalDeposit) {
    notifyListeners();
    _totalDeposit =
        MoneyFormatter.cconvertCurrency(newTotalDeposit, isIndonesia()) ?? "";
    // Memberi tahu pendengar bahwa nilai totalDeposit telah berubah
    notifyListeners();
  }

  DataTotalSaldo? dataTotalSaldo;

  // Retrieves the total saldo asynchronously and updates the UI accordingly.
  Future<void> getTotalSaldo(BuildContext context,) async {
    isLoadingGetTotalSaldo = true;

    // notifyListeners();

    Either<Failure, ResGetTotalSaldo> response =
    await repo.getTotalSaldo(isIndonesia());

    isLoadingGetTotalSaldo = false;
    // notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      notifyListeners();
      dataTotalSaldo = res.data;
      totalDeposit = dataTotalSaldo?.totalSaldo.toString() ?? "0";

      notifyListeners();
    });
    notifyListeners();
  }

  bool _isLoadingss = true;
  Map<String, dynamic> _invoiceData = {};

  bool get isLoadings => _isLoadingss;

  Map<String, dynamic> get invoiceData => _invoiceData;

  Future<void> fetchInvoiceDetail(String id) async {
    debugPrint("mmmmm");
    _isLoadingss = true;
    // notifyListeners();

    try {
      // var response = await Dio().get(
      //   'https://coolcompas.hantrr.com/api/user/detail-list-history-profiling/$id',
      //   options: Options(
      //     headers: {
      //       'Authorization': 'Bearer ${dataGlobal.token}',
      //     },
      //   ),
      // );
      debugPrint("okkkk hit api");
      debugPrint("id yang dikirim : $id");
      Dio dio = DioHandler().dio;
      Response res = await dio.get(
          "${ApiEndpoint.baseUrl}/api/user/detail-list-history-profiling/$id",
          options: Options(
            headers: {'Authorization': dataGlobal.token},
            validateStatus: (status) {
              return status == 200 || status == 400;
            },
          ));
      debugPrint("okk: $res");
      if (res.data['success'] == true) {
        _isLoadingss = false;
        _invoiceData = res.data['data'];
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }

    _isLoadingss = false;
    notifyListeners();
  }

  ResGetCategory? categoryData;
  bool isLoadingCategory = false;

  Future<void> getCategroyBug(BuildContext context,) async {
    isLoadingCategory = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResGetCategory> response = await repo.getCategoryBug();

    isLoadingCategory = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("Error fetching list kategori bug");
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
        debugPrint("list kategori bug fetched successfully");
        if (res.success == true) {
          categoryData = res;
          notifyListeners(); // Update UI dengan data terbaru
          if (kDebugMode) {
            print("list kategori bug: ${categoryData?.toJson()}");
          }
        } else {
          debugPrint("Failed to fetch list kategori bug");
        }
      },
    );

    notifyListeners();
  }

  bool isLoadingReportBug = false;

  Future<void> reportBug({
    required List<int> categories,
    required String body,
    File? media
  }) async {
    isLoadingReportBug = true;
    notifyListeners();

    try {
      // Tambahkan timeout di sini
      Either<Failure, ResReportBug> response = await repo.ReportBugByUser(
          categories,
          body,
          media
      ).timeout(Duration(seconds: 30), onTimeout: () {
        throw TimeoutException('Request timed out. Please try again.');
      });

      isLoadingReportBug = false;
      notifyListeners();

      // Handle response
      response.when(
        error: (e) {
          throw Exception(e.message ?? 'Terjadi kesalahan');
        },
        success: (res) {
          if (res.success != true) {
            throw Exception(res.message ?? 'Laporan bug gagal');
          }
        },
      );
    } on TimeoutException catch (_) {
      isLoadingReportBug = false;
      notifyListeners();
      throw Exception('Request timed out. Please try again.');
    } catch (e) {
      isLoadingReportBug = false;
      notifyListeners();
      throw Exception('Error during report: $e');
    }
  }

  ResGetLogReport? logReportData;
  bool  isLoadingLogReport = false;
  Future<void> getLogReport(BuildContext context) async {
    isLoadingLogReport = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResGetLogReport> response = await repo.getLogReport();

    isLoadingLogReport = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("Error fetching log report");
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
        debugPrint("Log report fetched successfully");
        if (res.success == true) {
          logReportData = res;
          notifyListeners();
          if (kDebugMode) {
            print("Log report data: ${logReportData?.toJson()}");
          }
        } else {
          debugPrint("Failed to fetch log report");
        }
      },
    );

    notifyListeners();
  }

  bool isLoadingDetailLog = false;
  ResGetDetailLogReport? detailLogReportData;
  Future<void> getDetailLogReport(BuildContext context, String? id) async {
    isLoadingDetailLog = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    Either<Failure, ResGetDetailLogReport> response = await repo.getDetailLogReport(id);

    isLoadingDetailLog = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("Error fetching detail log report");
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
        debugPrint("Detail log report fetched successfully");
        if (res.success == true) {
          detailLogReportData = res;
          notifyListeners();
          if (kDebugMode) {
            print("Detail log report data: ${detailLogReportData?.toJson()}");
          }
        } else {
          debugPrint("Failed to fetch detail log report");
        }
      },
    );

    notifyListeners();
  }


}
