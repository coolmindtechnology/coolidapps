// To parse this JSON data, do
//
//     final resSplashScreen = resSplashScreenFromJson(jsonString);

import 'dart:convert';

ResSplashScreen resSplashScreenFromJson(String str) =>
    ResSplashScreen.fromJson(json.decode(str));

String resSplashScreenToJson(ResSplashScreen data) =>
    json.encode(data.toJson());

class ResSplashScreen {
  String? logo;

  ResSplashScreen({
    this.logo,
  });

  factory ResSplashScreen.fromJson(Map<String, dynamic> json) =>
      ResSplashScreen(
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
      };
}
