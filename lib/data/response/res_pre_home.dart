// To parse this JSON data, do
//
//     final resPreHome = resPreHomeFromJson(jsonString);

import 'dart:convert';

ResPreHome resPreHomeFromJson(String str) =>
    ResPreHome.fromJson(json.decode(str));

String resPreHomeToJson(ResPreHome data) => json.encode(data.toJson());

class ResPreHome {
  DataPre? data;

  ResPreHome({
    this.data,
  });

  factory ResPreHome.fromJson(Map<String, dynamic> json) => ResPreHome(
        data: json["data"] == null ? null : DataPre.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class DataPre {
  Title? title;
  Greeting? greeting;
  String? logo;
  String? image;

  DataPre({
    this.title,
    this.greeting,
    this.logo,
    this.image,
  });

  factory DataPre.fromJson(Map<String, dynamic> json) => DataPre(
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
  String? preHomeGreeting;

  Greeting({
    this.preHomeGreeting,
  });

  factory Greeting.fromJson(Map<String, dynamic> json) => Greeting(
        preHomeGreeting: json["pre_home_greeting"],
      );

  Map<String, dynamic> toJson() => {
        "pre_home_greeting": preHomeGreeting,
      };
}

class Title {
  String? homeTitle;

  Title({
    this.homeTitle,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        homeTitle: json["home_title"],
      );

  Map<String, dynamic> toJson() => {
        "home_title": homeTitle,
      };
}
