import 'dart:convert';

AddressResponse addressResponseFromJson(String str) =>
    AddressResponse.fromJson(json.decode(str));

String addressResponseToJson(AddressResponse data) =>
    json.encode(data.toJson());

class AddressResponse {
  bool? success;
  String? message;
  DataAddress? data;

  AddressResponse({this.success, this.message, this.data});

  AddressResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DataAddress.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataAddress {
  int? id;
  String? country;
  String? state;
  String? city;
  String? district;
  String? longitude;
  String? latitude;

  DataAddress({
    this.id,
    this.country,
    this.state,
    this.city,
    this.district,
    this.longitude,
    this.latitude,
  });

  DataAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    district = json['district'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['district'] = district;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
