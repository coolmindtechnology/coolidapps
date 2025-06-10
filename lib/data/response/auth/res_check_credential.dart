import 'dart:convert';

CredentialResponse credentialResponseFromJson(String str) => CredentialResponse.fromJson(json.decode(str));

String credentialResponseToJson(CredentialResponse data) => json.encode(data.toJson());

class CredentialResponse {
  final bool success;
  final String message;
  final dynamic data;

  CredentialResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CredentialResponse.fromJson(Map<String, dynamic> json) {
    return CredentialResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}
