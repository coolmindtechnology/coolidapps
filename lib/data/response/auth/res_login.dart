// To parse this JSON data, do
//
//     final resLogin = resLoginFromJson(jsonString);

import 'dart:convert';

ResLogin resLoginFromJson(String str) => ResLogin.fromJson(json.decode(str));

String resLoginToJson(ResLogin data) => json.encode(data.toJson());

class ResLogin {
  bool? success;
  String? message;
  DataLogin? data;

  ResLogin({
    this.success,
    this.message,
    this.data,
  });

  factory ResLogin.fromJson(Map<String, dynamic> json) => ResLogin(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : DataLogin.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataLogin {
  String? accessToken;
  String? tokenType;
  dynamic expiresIn;
  dynamic idRole;
  String? isVerified;
  List<dynamic>? permission;
  dynamic email;

  DataLogin(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.idRole,
      this.isVerified,
      this.permission,
      this.email});

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      expiresIn: json["expires_in"],
      idRole: json["id_role"],
      isVerified: json["is_verified"],
      permission: json["permission"] == null
          ? []
          : List<dynamic>.from(json["permission"]!.map((x) => x)),
      email: json["email"]);

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "id_role": idRole,
        "is_verified": isVerified,
        "permission": permission == null
            ? []
            : List<dynamic>.from(permission!.map((x) => x)),
        "email": email
      };
}
