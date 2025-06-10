import 'dart:convert';

ResponseGetTopic responseRecommendedTopicFromJson(String str) =>
    ResponseGetTopic.fromJson(json.decode(str));

String responseRecommendedTopicToJson(ResponseGetTopic data) =>
    json.encode(data.toJson());

class ResponseGetTopic {
  bool? success;
  String? message;
  List<RecommendedTopic>? data;

  ResponseGetTopic({
    this.success,
    this.message,
    this.data,
  });

  factory ResponseGetTopic.fromJson(Map<String, dynamic> json) =>
      ResponseGetTopic(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null
            ? List<RecommendedTopic>.from(
            json["data"].map((x) => RecommendedTopic.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data != null
        ? List<dynamic>.from(data!.map((x) => x.toJson()))
        : null,
  };
}

class RecommendedTopic {
  String? title;
  int? count;

  RecommendedTopic({
    this.title,
    this.count,
  });

  factory RecommendedTopic.fromJson(Map<String, dynamic> json) =>
      RecommendedTopic(
        title: json["title"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
    "title": title,
    "count": count,
  };
}
