// To parse this JSON data, do
//
//     final resHistorySaldoReduction = resHistorySaldoReductionFromJson(jsonString);

import 'dart:convert';

ResHistorySaldoReduction resHistorySaldoReductionFromJson(String str) =>
    ResHistorySaldoReduction.fromJson(json.decode(str));

String resHistorySaldoReductionToJson(ResHistorySaldoReduction data) =>
    json.encode(data.toJson());

class ResHistorySaldoReduction {
  bool? success;
  String? message;
  DataPaginationSaldoReduction? data;

  ResHistorySaldoReduction({
    this.success,
    this.message,
    this.data,
  });

  factory ResHistorySaldoReduction.fromJson(Map<String, dynamic> json) =>
      ResHistorySaldoReduction(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataPaginationSaldoReduction.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataPaginationSaldoReduction {
  int? currentPage;
  List<DataHistorySaldoReduction>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  DataPaginationSaldoReduction({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory DataPaginationSaldoReduction.fromJson(Map<String, dynamic> json) =>
      DataPaginationSaldoReduction(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<DataHistorySaldoReduction>.from(json["data"]!
                .map((x) => DataHistorySaldoReduction.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class DataHistorySaldoReduction {
  String? id;
  String? idUser;
  String? idAffiliate;
  String? orderId;
  String? amount;
  String? transactionType;
  String? source;
  dynamic useByMember;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  DataHistorySaldoReduction({
    this.id,
    this.idUser,
    this.idAffiliate,
    this.orderId,
    this.amount,
    this.transactionType,
    this.source,
    this.useByMember,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory DataHistorySaldoReduction.fromJson(Map<String, dynamic> json) =>
      DataHistorySaldoReduction(
        id: json["id"],
        idUser: json["id_user"],
        idAffiliate: json["id_affiliate"],
        orderId: json["order_id"],
        amount: json["amount"],
        transactionType: json["transaction_type"],
        source: json["source"],
        useByMember: json["use_by_member"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_affiliate": idAffiliate,
        "order_id": orderId,
        "amount": amount,
        "transaction_type": transactionType,
        "source": source,
        "use_by_member": useByMember,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
