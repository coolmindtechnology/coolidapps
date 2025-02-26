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
  Countrys? countrys;
  Countrys? state;
  Countrys? city;
  Countrys? district;
  String? longitude;
  String? latitude;

  DataAddress(
      {this.id,
      this.countrys,
      this.state,
      this.city,
      this.district,
      this.longitude,
      this.latitude});

  DataAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countrys =
        json['country'] != null ? Countrys.fromJson(json['country']) : null;
    state = json['state'] != null ? Countrys.fromJson(json['state']) : null;
    city = json['city'] != null ? Countrys.fromJson(json['city']) : null;
    district =
        json['district'] != null ? Countrys.fromJson(json['district']) : null;
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (countrys != null) {
      data['countrys'] = countrys!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}

class Countrys {
  int? id;
  String? name;

  Countrys({this.id, this.name});

  Countrys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
// class AddressResponse {
//   bool? success;
//   String? message;
//   DataAddress? data;

//   AddressResponse({this.success, this.message, this.data});

//   AddressResponse.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? DataAddress.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class DataAddress {
//   int? id;
//   String? countrys;
//   String? state;
//   String? city;
//   String? district;
//   String? longitude;
//   String? latitude;

//   DataAddress(
//       {this.id,
//       this.countrys,
//       this.state,
//       this.city,
//       this.district,
//       this.longitude,
//       this.latitude});

//   DataAddress.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     countrys = json['countrys'];
//     state = json['state'];
//     city = json['city'];
//     district = json['district'];
//     longitude = json['longitude'];
//     latitude = json['latitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['countrys'] = countrys;
//     data['state'] = state;
//     data['city'] = city;
//     data['district'] = district;
//     data['longitude'] = longitude;
//     data['latitude'] = latitude;
//     return data;
//   }
// }
