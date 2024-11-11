// To parse this JSON data, do
//
//     final resDetailProfiling = resDetailProfilingFromJson(jsonString);

import 'dart:convert';

ResDetailProfiling resDetailProfilingFromJson(String str) =>
    ResDetailProfiling.fromJson(json.decode(str));

String resDetailProfilingToJson(ResDetailProfiling data) =>
    json.encode(data.toJson());

class ResDetailProfiling {
  bool? success;
  dynamic message;
  DataDetailProfiling? data;

  ResDetailProfiling({
    this.success,
    this.message,
    this.data,
  });

  factory ResDetailProfiling.fromJson(Map<String, dynamic> json) =>
      ResDetailProfiling(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataDetailProfiling.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataDetailProfiling {
  int? id;
  dynamic result;
  dynamic name;
  dynamic title;
  dynamic character;
  Tipe? tipeAura;
  Personality? tipeOtak;
  Tipe? tipeKaya;
  Tipe? tipeDarah;
  Personality? personality;
  dynamic picture;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<PublicFigure>? publicFigure;
  dynamic profilingName;
  dynamic shareCode;

  DataDetailProfiling({
    this.id,
    this.result,
    this.name,
    this.title,
    this.character,
    this.tipeAura,
    this.tipeOtak,
    this.tipeKaya,
    this.tipeDarah,
    this.personality,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.publicFigure,
    this.profilingName,
    this.shareCode,
  });

  factory DataDetailProfiling.fromJson(Map<String, dynamic> json) =>
      DataDetailProfiling(
        id: json["id"],
        result: json["result"],
        name: json["name"],
        title: json["title"],
        character: json["character"],
        tipeAura:
            json["tipe_aura"] == null ? null : Tipe.fromJson(json["tipe_aura"]),
        tipeOtak: json["tipe_otak"] == null
            ? null
            : Personality.fromJson(json["tipe_otak"]),
        tipeKaya:
            json["tipe_kaya"] == null ? null : Tipe.fromJson(json["tipe_kaya"]),
        tipeDarah: json["tipe_darah"] == null
            ? null
            : Tipe.fromJson(json["tipe_darah"]),
        personality: json["personality"] == null
            ? null
            : Personality.fromJson(json["personality"]),
        picture: json["picture"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        publicFigure: json["public_figure"] == null
            ? []
            : List<PublicFigure>.from(
                json["public_figure"]!.map((x) => PublicFigure.fromJson(x))),
        profilingName: json["profiling_name"],
        shareCode: json["share_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "result": result,
        "name": name,
        "title": title,
        "character": character,
        "tipe_aura": tipeAura?.toJson(),
        "tipe_otak": tipeOtak?.toJson(),
        "tipe_kaya": tipeKaya?.toJson(),
        "tipe_darah": tipeDarah?.toJson(),
        "personality": personality?.toJson(),
        "picture": picture,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "public_figure": publicFigure == null
            ? []
            : List<dynamic>.from(publicFigure!.map((x) => x.toJson())),
        "profiling_name": profilingName,
        "share_code": shareCode,
      };
}

class Personality {
  dynamic description;
  dynamic picture;

  Personality({
    this.description,
    this.picture,
  });

  factory Personality.fromJson(Map<String, dynamic> json) => Personality(
        description: json["description"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "picture": picture,
      };
}

class Tipe {
  dynamic tipe;
  dynamic description;
  dynamic picture;

  Tipe({
    this.tipe,
    this.description,
    this.picture,
  });

  factory Tipe.fromJson(Map<String, dynamic> json) => Tipe(
        tipe: json["tipe"],
        description: json["description"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "tipe": tipe,
        "description": description,
        "picture": picture,
      };
}

class PublicFigure {
  int? id;
  dynamic name;
  dynamic result;
  dynamic character;
  dynamic description;
  dynamic career;
  dynamic image;

  PublicFigure({
    this.id,
    this.name,
    this.result,
    this.character,
    this.description,
    this.career,
    this.image,
  });

  factory PublicFigure.fromJson(Map<String, dynamic> json) => PublicFigure(
        id: json["id"],
        name: json["name"],
        result: json["result"],
        character: json["character"],
        description: json["description"],
        career: json["career"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "result": result,
        "character": character,
        "description": description,
        "career": career,
        "image": image,
      };
}
