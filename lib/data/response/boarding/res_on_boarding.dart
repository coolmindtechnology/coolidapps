// To parse this JSON data, do
//
//     final resOnBoarding = resOnBoardingFromJson(jsonString);

import 'dart:convert';

ResOnBoarding resOnBoardingFromJson(String str) =>
    ResOnBoarding.fromJson(json.decode(str));

String resOnBoardingToJson(ResOnBoarding data) => json.encode(data.toJson());

class ResOnBoarding {
  DataOnBoarding? data;

  ResOnBoarding({
    this.data,
  });

  factory ResOnBoarding.fromJson(Map<String, dynamic> json) => ResOnBoarding(
        data:
            json["data"] == null ? null : DataOnBoarding.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class DataOnBoarding {
  Title? title;
  Greeting? greeting;
  String? logo;
  String? image;

  DataOnBoarding({
    this.title,
    this.greeting,
    this.logo,
    this.image,
  });

  factory DataOnBoarding.fromJson(Map<String, dynamic> json) => DataOnBoarding(
        title: json["title"] == null ? null : Title.fromJson(json["title"]),
        greeting: json["greeting"] == null
            ? null
            : Greeting.fromJson(json["greeting"]),
        logo: json["logo"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title?.toJson(),
        "greeting": greeting?.toJson(),
        "logo": logo,
        "image": image,
      };
}

class Greeting {
  String? onBoardingGreeting;

  Greeting({
    this.onBoardingGreeting,
  });

  factory Greeting.fromJson(Map<String, dynamic> json) => Greeting(
        onBoardingGreeting: json["on_boarding_greeting"],
      );

  Map<String, dynamic> toJson() => {
        "on_boarding_greeting": onBoardingGreeting,
      };
}

class Title {
  String? onBoardingTitle;

  Title({
    this.onBoardingTitle,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        onBoardingTitle: json["on_boarding_title"],
      );

  Map<String, dynamic> toJson() => {
        "on_boarding_title": onBoardingTitle,
      };
}
