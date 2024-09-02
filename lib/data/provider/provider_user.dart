// ignore_for_file: use_build_context_synchronously

import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/helpers/either.dart';
import 'package:cool_app/data/helpers/failure.dart';
import 'package:cool_app/data/repositories/repo_user.dart';
import 'package:cool_app/data/response/user/res_check_profile.dart';
import 'package:cool_app/data/response/user/res_get_location_member.dart';
import 'package:cool_app/data/response/user/res_get_total_saldo.dart';
import 'package:cool_app/data/response/user/res_get_user.dart';
import 'package:cool_app/data/response/user/res_update_photo_user.dart';
import 'package:cool_app/data/response/user/res_update_user.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/user/screen_profile.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/get_country.dart';
import 'package:cool_app/presentation/utils/money_formatter.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

class ProviderUser extends ChangeNotifier {
  ProviderUser();

  ProviderUser.initMemberArea(BuildContext context) {
    getMemberArea(context);
    getUser(context);
  }

  ProviderUser.initUser(BuildContext context) {
    getUser(context);
  }
  RepoUser repo = RepoUser();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String initialCodeCountry = "ID";
  String initialDialCode = "62";
  String? phoneNumberWithoutCode;
  String ipCountry = "Indonesia";

  /// Sets the initial values for the text controllers based on the dataUser object in the global data.
  ///
  /// This function retrieves the name, email, idCardNumber, and address from the dataUser object in the global data,
  /// and assigns them to the corresponding text controllers. It then calls the `setPhoneNumber` function to set the initial values for the phone number controller.
  void setInitialValues() {
    nameController.text = dataGlobal.dataUser?.name ?? "";
    emailController.text = dataGlobal.dataUser?.email ?? "";
    idCardController.text = dataGlobal.dataUser?.idCardNumber ?? "";
    addressController.text = dataGlobal.dataUser?.address ?? "";
    setPhoneNumber();
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
    String phoneNumber = dataGlobal.dataUser?.phoneNumber ?? "";
    Country country = PhoneNumber.getCountry(phoneNumber);
    initialCodeCountry = country.code;
    initialDialCode = country.dialCode;
    notifyListeners();
  }

  void setPhoneNumber() {
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
    String phoneNumber = dataGlobal.dataUser?.phoneNumber ?? "";
    Country country = PhoneNumber.getCountry(phoneNumber);

    initialCodeCountry = country.code;
    initialDialCode = country.dialCode;

    // Hapus kode negara dari nomor telepon
    phoneNumberWithoutCode = phoneNumber.substring(initialDialCode.length);

    phoneController.text = phoneNumber;

    Future.microtask(() {
      notifyListeners();
    });
  }

  DataUser? dataUser;

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
    );

    isLoadingUpdateUser = false;
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
      if (res.errors != null) {
        NotificationUtils.showDialogError(
          context,
          () {
            Nav.back();
          },
          textButton: S.of(context).back,
          widget: Text(
            res.message ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }
      if (res.success == true) {
        await getUser(context);
        NotificationUtils.showDialogSuccess(context, () {
          Nav.back();
          Nav.back();
        },
            widget: Center(
              child: Text(
                S.of(context).successfully_updated_user,
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
            textButton: S.of(context).back);
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
  Future<void> getUser(
    BuildContext context,
  ) async {
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
          textButton: S.of(context).back);
    }, success: (res) async {
      if (res.success == true) {
        dataUser = res.data;
        // if (res.data?.role?.id == 2) {
        dataGlobal.dataUser = res.data;
        // }

        getCountryCode();

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
          textButton: S.of(context).back);
    }, success: (res) async {
      if (res.success == true) {
        memberArea = res.data;
        dataGlobal.dataMember = res.data;
        ipCountry = memberArea?.country ?? "";
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
          textButton: S.of(context).back);
    }, success: (res) async {
      if (res.success == false) {
        NotificationUtils.showDialogError(
          context,
          () {
            Nav.back();
          },
          textButton: S.of(context).back,
          widget: Text(
            res.message ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }
      if (res.success == true) {
        NotificationUtils.showSnackbar(
            S.of(context).update_photo_profile_success,
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
            textButton: S.of(context).back);
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
          NotificationUtils.showDialogError(context, () async {
            Nav.back();
            await Nav.to(const ScreenProfile());
            checkProfile(context);
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
    _totalDeposit =
        MoneyFormatter.cconvertCurrency(newTotalDeposit, isIndonesia()) ?? "";
    // Memberi tahu pendengar bahwa nilai totalDeposit telah berubah
    notifyListeners();
  }

  DataTotalSaldo? dataTotalSaldo;
  // Retrieves the total saldo asynchronously and updates the UI accordingly.
  Future<void> getTotalSaldo(
    BuildContext context,
  ) async {
    isLoadingGetTotalSaldo = true;

    notifyListeners();

    Either<Failure, ResGetTotalSaldo> response =
        await repo.getTotalSaldo(isIndonesia());

    isLoadingGetTotalSaldo = false;
    notifyListeners();

    response.when(error: (e) {
      NotificationUtils.showDialogError(context, () {
        Nav.back();
      },
          widget: Text(
            e.message,
            textAlign: TextAlign.center,
          ));
    }, success: (res) async {
      dataTotalSaldo = res.data;
      totalDeposit = dataTotalSaldo?.totalSaldo.toString() ?? "0";

      notifyListeners();
    });
    notifyListeners();
  }
}
