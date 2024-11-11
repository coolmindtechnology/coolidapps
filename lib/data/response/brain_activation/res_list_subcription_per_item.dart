// To parse this JSON data, do
//
//     final resListSubcriptionPerItem = resListSubcriptionPerItemFromJson(jsonString);

import 'dart:convert';

ResListSubcriptionPerItem resListSubcriptionPerItemFromJson(String str) =>
    ResListSubcriptionPerItem.fromJson(json.decode(str));

String resListSubcriptionPerItemToJson(ResListSubcriptionPerItem data) =>
    json.encode(data.toJson());

class ResListSubcriptionPerItem {
  bool? success;
  String? message;
  DataResponse? data;

  ResListSubcriptionPerItem({
    this.success,
    this.message,
    this.data,
  });

  factory ResListSubcriptionPerItem.fromJson(Map<String, dynamic> json) =>
      ResListSubcriptionPerItem(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : DataResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataResponse {
  List<DataSubcriptionPerItem>? lists;
  bool? allLists;
  String? transactionType;

  DataResponse({this.lists, this.allLists, this.transactionType});

  factory DataResponse.fromJson(Map<String, dynamic> json) => DataResponse(
        lists: json["lists"] == null
            ? []
            : List<DataSubcriptionPerItem>.from(
                json["lists"]!.map((x) => DataSubcriptionPerItem.fromJson(x))),
        allLists: json["all_lists"],
        transactionType: json["transaction_type"],
      );

  Map<String, dynamic> toJson() => {
        "lists": lists == null
            ? []
            : List<dynamic>.from(lists!.map((x) => x.toJson())),
        "all_lists": allLists,
        "transaction_type": transactionType
      };
}

class DataSubcriptionPerItem {
  int? id;
  String? name;
  String? upload;
  dynamic status;
  dynamic price;
  dynamic intlPrice;
  dynamic yearlyPrice;
  dynamic intlYearlyPrice;
  dynamic intlYearlyDiscount;
  dynamic intlMonthlyPrice;
  dynamic intlMonthlyDiscount;
  dynamic monthlyDiscount;
  String? monthlyPrice;
  String? yearlyDiscount;
  dynamic deletedAt;
  dynamic discountedMonthlyPrice;
  dynamic discountedYearlyPrice;

  DataSubcriptionPerItem({
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
    this.discountedMonthlyPrice,
    this.discountedYearlyPrice,
  });

  factory DataSubcriptionPerItem.fromJson(Map<String, dynamic> json) =>
      DataSubcriptionPerItem(
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
        discountedMonthlyPrice: json["discounted_monthly_price"],
        discountedYearlyPrice: json["discounted_yearly_price"],
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
        "discounted_monthly_price": discountedMonthlyPrice,
        "discounted_yearly_price": discountedYearlyPrice,
      };
}
