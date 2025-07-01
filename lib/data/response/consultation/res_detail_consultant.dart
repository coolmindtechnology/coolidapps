import 'dart:convert';

ResponseDetailConsultant responseDetailConsultantFromJson(String str) =>
    ResponseDetailConsultant.fromJson(json.decode(str));

String responseDetailConsultantToJson(ResponseDetailConsultant data) =>
    json.encode(data.toJson());

class ResponseDetailConsultant {
  bool? success;
  String? message;
  DataDetailConsultant? data;

  ResponseDetailConsultant({this.success, this.message, this.data});

  ResponseDetailConsultant.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? DataDetailConsultant.fromJson(json['data'])
        : null;
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

class DataDetailConsultant {
  int? id;
  String? image;
  String? name;
  String? typeBlood;
  String? typeBrain;
  String? address;
  int? sessionSuccess;
  dynamic rating;
  int? follower; // Tambahan follower
  bool? isFollow;

  DataDetailConsultant({
    this.id,
    this.image,
    this.name,
    this.typeBlood,
    this.typeBrain,
    this.address,
    this.sessionSuccess,
    this.rating,
    this.follower,
    this.isFollow,// Inisialisasi follower
  });

  DataDetailConsultant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    typeBlood = json['type_blood'];
    typeBrain = json['type_brain'];
    address = json['address'];
    sessionSuccess = json['session_success'];
    rating = json['rating'];
    follower = json['follower'];
    isFollow = json['is_follow'];// Parsing follower
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['type_blood'] = typeBlood;
    data['type_brain'] = typeBrain;
    data['address'] = address;
    data['session_success'] = sessionSuccess;
    data['rating'] = rating;
    data['follower'] = follower;
    data['is_follow'] = isFollow;// Tambahkan follower
    return data;
  }
}
