enum Level { logOnly, error }

class Failure {
  final String message;

  Failure(this.message);

  @override

  /// Returns a string representation of the `Failure` object.
  ///
  /// This method returns the `message` property of the `Failure` object.
  ///
  /// Returns:
  ///   - A `String` representing the message of the `Failure` object.
  String toString() {
    return message;
  }
}

class FailedModel {
  bool? success;
  String? message;
  Errors? errors;
  dynamic errorCode;

  FailedModel({this.success, this.message, this.errors});

  FailedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    errorCode = json['error_code'];

    // Periksa tipe data errors, jika string maka langsung set ke null atau handling string
    if (json['errors'] is Map<String, dynamic>) {
      errors = Errors.fromJson(json['errors']);
    } else {
      errors = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['error_code'] = errorCode;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }

    return data;
  }
}

class Errors {
  List<String>? phoneNumber;
  List<String>? email;
  List<String>? password;
  List<String>? passwordConfirmation;
  List<String>? codeReferal;

  Errors({
    this.phoneNumber,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.codeReferal,
  });

  Errors.fromJson(Map<String, dynamic> json) {
    // Periksa apakah tipe datanya list, jika tidak kosong, lakukan casting
    phoneNumber = _castToListOfString(json['phone_number']);
    email = _castToListOfString(json['email']);
    password = _castToListOfString(json['password']);
    passwordConfirmation = _castToListOfString(json['password_confirmation']);
    codeReferal = _castToListOfString(json['code_referal']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['code_referal'] = codeReferal;
    return data;
  }

  // Helper untuk casting data menjadi List<String>
  List<String>? _castToListOfString(dynamic value) {
    if (value is List) {
      return value.cast<String>();
    }
    return null; // Jika bukan list, kembalikan null
  }
}
