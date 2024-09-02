// To parse this JSON data, do
//
//     final reslistCoolChatById = reslistCoolChatByIdFromJson(jsonString);

import 'dart:convert';

import 'package:cool_app/data/models/data_post.dart';

ResListCoolChatById reslistCoolChatByIdFromJson(String str) =>
    ResListCoolChatById.fromJson(json.decode(str));

String reslistCoolChatByIdToJson(ResListCoolChatById data) =>
    json.encode(data.toJson());

class ResListCoolChatById {
  List<DataPost>? data;

  ResListCoolChatById({
    this.data,
  });

  factory ResListCoolChatById.fromJson(Map<String, dynamic> json) =>
      ResListCoolChatById(
        data: json["data"] == null
            ? []
            : List<DataPost>.from(
                json["data"]!.map((x) => DataPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
