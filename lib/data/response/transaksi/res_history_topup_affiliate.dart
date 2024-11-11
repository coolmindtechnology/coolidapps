// To parse this JSON data, do
//
//     final resHistoryTopupAffiliate = resHistoryTopupAffiliateFromJson(jsonString);

import 'dart:convert';

ResHistoryTopupAffiliate resHistoryTopupAffiliateFromJson(String str) =>
    ResHistoryTopupAffiliate.fromJson(json.decode(str));

String resHistoryTopupAffiliateToJson(ResHistoryTopupAffiliate data) =>
    json.encode(data.toJson());

class ResHistoryTopupAffiliate {
  bool? success;
  String? message;
  DataPaginationHistoryTopupSaldo? data;

  ResHistoryTopupAffiliate({
    this.success,
    this.message,
    this.data,
  });

  factory ResHistoryTopupAffiliate.fromJson(Map<String, dynamic> json) =>
      ResHistoryTopupAffiliate(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataPaginationHistoryTopupSaldo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataPaginationHistoryTopupSaldo {
  int? currentPage;
  List<DataHistoryTopupAffiliate>? data;
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

  DataPaginationHistoryTopupSaldo({
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

  factory DataPaginationHistoryTopupSaldo.fromJson(Map<String, dynamic> json) =>
      DataPaginationHistoryTopupSaldo(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<DataHistoryTopupAffiliate>.from(json["data"]!
                .map((x) => DataHistoryTopupAffiliate.fromJson(x))),
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

class DataHistoryTopupAffiliate {
  dynamic id;
  dynamic idUser;
  dynamic idAffiliate;
  dynamic orderId;
  dynamic amount;
  dynamic transactionType;
  dynamic source;
  dynamic useByMember;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  DataHistoryTopupAffiliate({
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

  factory DataHistoryTopupAffiliate.fromJson(Map<String, dynamic> json) =>
      DataHistoryTopupAffiliate(
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
