import 'dart:convert';

ResponseListConsultation responseListConsultationFromJson(String str) =>
    ResponseListConsultation.fromJson(json.decode(str));

String responseListConsultationToJson(ResponseListConsultation data) =>
    json.encode(data.toJson());

class ResponseListConsultation {
  bool? success;
  String? message;
  Datas? datas;

  ResponseListConsultation({this.success, this.message, this.datas});

  ResponseListConsultation.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    datas = json['data'] != null ? Datas.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (datas != null) {
      data['data'] = datas!.toJson();
    }
    return data;
  }
}

class Datas {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Datas(
      {this.currentPage,
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
        this.total});

  Datas.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  int? consultantId;
  String? consultantImage;
  String? consultantName;
  String? consultantBloodType;
  String? consultantTypeBrain;
  String? consultantAddress;
  String? sessionStatus;
  double? rating;
  int? remainingMinutes;
  String? sessionStart;
  String? sessionEnd;
  String? timeSelected;
  bool? status;
  String? theme;
  String? explanation;
  String? price;
  FirebaseConf? firebaseConf;

  Data(
      {this.id,
        this.consultantId,
        this.consultantImage,
        this.consultantName,
        this.consultantBloodType,
        this.consultantTypeBrain,
        this.consultantAddress,
        this.sessionStatus,
        this.rating,
        this.remainingMinutes,
        this.sessionStart,
        this.sessionEnd,
        this.timeSelected,
        this.status,
        this.theme,
        this.explanation,
        this.price,
        this.firebaseConf});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consultantId = json['consultant_id'];
    consultantImage = json['consultant_image'];
    consultantName = json['consultant_name'];
    consultantBloodType = json['consultant_blood_type'];
    consultantTypeBrain = json['consultant_type_brain'];
    consultantAddress = json['consultant_address'];
    sessionStatus = json['session_status'];
    rating = (json['rating'] ?? 0).toDouble();
    remainingMinutes = json['remaining_minutes'];
    sessionStart = json['session_start'];
    sessionEnd = json['session_end'];
    timeSelected = json['time_selected'];
    status = json['status'];
    theme = json['theme'];
    explanation = json['explanation'];
    price = json['price'];
    firebaseConf = json['firebase_conf'] != null
        ? FirebaseConf.fromJson(json['firebase_conf'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['consultant_id'] = consultantId;
    data['consultant_image'] = consultantImage;
    data['consultant_name'] = consultantName;
    data['consultant_blood_type'] = consultantBloodType;
    data['consultant_type_brain'] = consultantTypeBrain;
    data['consultant_address'] = consultantAddress;
    data['session_status'] = sessionStatus;
    data['rating'] = rating;
    data['remaining_minutes'] = remainingMinutes;
    data['session_start'] = sessionStart;
    data['session_end'] = sessionEnd;
    data['time_selected'] = timeSelected;
    data['status'] = status;
    data['theme'] = theme;
    data['explanation'] = explanation;
    data['price'] = price;
    if (firebaseConf != null) {
      data['firebase_conf'] = firebaseConf!.toJson();
    }
    return data;
  }
}

class FirebaseConf {
  String? participantIds;
  String? consultantIds;
  String? roomIds;

  FirebaseConf({this.participantIds, this.consultantIds, this.roomIds});

  FirebaseConf.fromJson(Map<String, dynamic> json) {
    participantIds = json['participant_ids'];
    consultantIds = json['consultant_ids'];
    roomIds = json['room_ids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['participant_ids'] = participantIds;
    data['consultant_ids'] = consultantIds;
    data['room_ids'] = roomIds;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}