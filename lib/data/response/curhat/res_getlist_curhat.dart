import 'dart:convert';

ResGetListCurhat resGetListCurhatFromJson(String str) =>
    ResGetListCurhat.fromJson(json.decode(str));

String resGetListCurhatToJson(ResGetListCurhat data) =>
    json.encode(data.toJson());

class ResGetListCurhat {
  bool? success;
  String? message;
  Data? data;

  ResGetListCurhat({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetListCurhat.fromJson(Map<String, dynamic> json) =>
      ResGetListCurhat(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? currentPage;
  List<Datum>? data;
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

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null
        ? []
        : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
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

class Datum {
  int? id;
  int? consultantId;
  String? theme;
  String? consultantImage;
  String? consultantName;
  String? consultantBloodType;
  String? consultantTypeBrain;
  String? consultantAddress;
  String? explanation;
  String? sessionStatus;
  int? rating;
  int? remainingMinutes;
  DateTime? sessionStart;
  DateTime? sessionEnd;
  String? timeSelected;
  double? price;
  String? categorySession;
  String? status;
  String? typeSession;
  String? idDocument;
  FirebaseConf? firebaseConf;

  Datum({
    this.id,
    this.consultantId,
    this.theme,
    this.consultantImage,
    this.consultantName,
    this.consultantBloodType,
    this.consultantTypeBrain,
    this.consultantAddress,
    this.explanation,
    this.sessionStatus,
    this.rating,
    this.remainingMinutes,
    this.sessionStart,
    this.sessionEnd,
    this.timeSelected,
    this.price,
    this.categorySession,
    this.status,
    this.typeSession,
    this.idDocument,
    this.firebaseConf,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    consultantId: json["consultant_id"],
    theme: json["theme"],
    consultantImage: json["consultant_image"],
    consultantName: json["consultant_name"],
    consultantBloodType: json["consultant_blood_type"],
    consultantTypeBrain: json["consultant_type_brain"],
    consultantAddress: json["consultant_address"],
    explanation: json["explanation"],
    sessionStatus: json["session_status"],
    rating: json["rating"],
    remainingMinutes: json["remaining_minutes"],
    sessionStart: json["session_start"] == null
        ? null
        : DateTime.parse(json["session_start"]),
    sessionEnd: json["session_end"] == null
        ? null
        : DateTime.parse(json["session_end"]),
    timeSelected: json["time_selected"],
    price: json["price"] != null
        ? double.tryParse(json["price"].toString())
        : null,
    categorySession: json["category_session"],
    status: json["status"],
    typeSession: json["type_session"],
    idDocument: json["id_document"],
    firebaseConf: json["firebase_conf"] == null
        ? null
        : FirebaseConf.fromJson(json["firebase_conf"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "consultant_id": consultantId,
    "theme": theme,
    "consultant_image": consultantImage,
    "consultant_name": consultantName,
    "consultant_blood_type": consultantBloodType,
    "consultant_type_brain": consultantTypeBrain,
    "consultant_address": consultantAddress,
    "explanation": explanation,
    "session_status": sessionStatus,
    "rating": rating,
    "remaining_minutes": remainingMinutes,
    "session_start": sessionStart?.toIso8601String(),
    "session_end": sessionEnd?.toIso8601String(),
    "time_selected": timeSelected,
    "price": price,
    "category_session": categorySession,
    "status": status,
    "type_session": typeSession,
    "id_document": idDocument,
    "firebase_conf": firebaseConf?.toJson(),
  };
}

class FirebaseConf {
  String? participantIds;
  String? consultantIds;

  FirebaseConf({
    this.participantIds,
    this.consultantIds,
  });

  factory FirebaseConf.fromJson(Map<String, dynamic> json) => FirebaseConf(
    participantIds: json["participant_ids"],
    consultantIds: json["consultant_ids"],
  );

  Map<String, dynamic> toJson() => {
    "participant_ids": participantIds,
    "consultant_ids": consultantIds,
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
