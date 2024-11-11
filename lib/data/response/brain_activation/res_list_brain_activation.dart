// To parse this JSON data, do
//
//     final resListBrainActivation = resListBrainActivationFromJson(jsonString);

import 'dart:convert';

ResListBrainActivation resListBrainActivationFromJson(String str) =>
    ResListBrainActivation.fromJson(json.decode(str));

String resListBrainActivationToJson(ResListBrainActivation data) =>
    json.encode(data.toJson());

class ResListBrainActivation {
  bool? success;
  String? message;
  List<DataBrain>? data;

  ResListBrainActivation({
    this.success,
    this.message,
    this.data,
  });

  factory ResListBrainActivation.fromJson(Map<String, dynamic> json) =>
      ResListBrainActivation(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataBrain>.from(
                json["data"]!.map((x) => DataBrain.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataBrain {
  int? id;
  String? name;
  String? upload;
  dynamic status;
  dynamic price;
  dynamic intlPrice;
  String? yearlyPrice;
  dynamic intlYearlyPrice;
  dynamic intlYearlyDiscount;
  dynamic intlMonthlyPrice;
  dynamic intlMonthlyDiscount;
  String? monthlyDiscount;
  String? monthlyPrice;
  String? yearlyDiscount;
  dynamic deletedAt;
  String? duration;
  LogBrain? logBrain;

  DataBrain({
    this.id,
    this.name,
    this.upload,
    this.status,
    this.price,
    this.intlPrice,
    this.yearlyPrice,
    this.intlYearlyPrice,
    this.intlYearlyDiscount,
    this.intlMonthlyPrice,
    this.intlMonthlyDiscount,
    this.monthlyDiscount,
    this.monthlyPrice,
    this.yearlyDiscount,
    this.deletedAt,
    this.duration,
    this.logBrain,
  });

  factory DataBrain.fromJson(Map<String, dynamic> json) => DataBrain(
        id: json["id"],
        name: json["name"],
        upload: json["upload"],
        status: json["status"],
        price: json["price"],
        intlPrice: json["intl_price"],
        yearlyPrice: json["yearly_price"],
        intlYearlyPrice: json["intl_yearly_price"],
        intlYearlyDiscount: json["intl_yearly_discount"],
        intlMonthlyPrice: json["intl_monthly_price"],
        intlMonthlyDiscount: json["intl_monthly_discount"],
        monthlyDiscount: json["monthly_discount"],
        monthlyPrice: json["monthly_price"],
        yearlyDiscount: json["yearly_discount"],
        deletedAt: json["deleted_at"],
        duration: json["duration"],
        logBrain: json["log_brain"] == null
            ? null
            : LogBrain.fromJson(json["log_brain"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "upload": upload,
        "status": status,
        "price": price,
        "intl_price": intlPrice,
        "yearly_price": yearlyPrice,
        "intl_yearly_price": intlYearlyPrice,
        "intl_yearly_discount": intlYearlyDiscount,
        "intl_monthly_price": intlMonthlyPrice,
        "intl_monthly_discount": intlMonthlyDiscount,
        "monthly_discount": monthlyDiscount,
        "monthly_price": monthlyPrice,
        "yearly_discount": yearlyDiscount,
        "deleted_at": deletedAt,
        "duration": duration,
        "log_brain": logBrain?.toJson(),
      };
}

class LogBrain {
  int? id;
  dynamic idBrainActivations;
  dynamic idUser;
  dynamic idLogProfiling;
  DateTime? expDate;
  dynamic dailyCount;
  dynamic totalAccess;
  dynamic lastAccessTime;
  dynamic status;

  LogBrain({
    this.id,
    this.idBrainActivations,
    this.idUser,
    this.idLogProfiling,
    this.expDate,
    this.dailyCount,
    this.totalAccess,
    this.lastAccessTime,
    this.status,
  });

  factory LogBrain.fromJson(Map<String, dynamic> json) => LogBrain(
        id: json["id"],
        idBrainActivations: json["id_brain_activations"],
        idUser: json["id_user"],
        idLogProfiling: json["id_log_profiling"],
        expDate:
            json["exp_date"] == null ? null : DateTime.parse(json["exp_date"]),
        dailyCount: json["daily_count"],
        totalAccess: json["total_access"],
        lastAccessTime: json["last_access_time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_brain_activations": idBrainActivations,
        "id_user": idUser,
        "id_log_profiling": idLogProfiling,
        "exp_date": expDate?.toIso8601String(),
        "daily_count": dailyCount,
        "total_access": totalAccess,
        "last_access_time": lastAccessTime,
        "status": status,
      };
}
