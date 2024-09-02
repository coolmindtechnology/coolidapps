// To parse this JSON data, do
//
//     final resPostReaction = resPostReactionFromJson(jsonString);

import 'dart:convert';

ResPostReaction resPostReactionFromJson(String str) =>
    ResPostReaction.fromJson(json.decode(str));

String resPostReactionToJson(ResPostReaction data) =>
    json.encode(data.toJson());

class ResPostReaction {
  bool? success;
  String? message;
  dynamic data;

  ResPostReaction({
    this.success,
    this.message,
    this.data,
  });

  factory ResPostReaction.fromJson(Map<String, dynamic> json) =>
      ResPostReaction(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
