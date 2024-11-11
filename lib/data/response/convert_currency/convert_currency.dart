import 'dart:convert';

ConvertCurrencyModel rescreateWithdrawFromJson(String str) =>
    ConvertCurrencyModel.fromJson(json.decode(str));

String rescConvertCurrencyToJson(ConvertCurrencyModel data) =>
    json.encode(data.toJson());

class ConvertCurrencyModel {
  bool? success;
  dynamic data;
  String? message;

  ConvertCurrencyModel({this.success, this.data, this.message});

  ConvertCurrencyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}
