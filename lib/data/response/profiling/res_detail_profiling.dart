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
  Personality? karir;
  Personality? polaBahagia;
  Personality? polaInteraksi;
  Personality? family;
  Personality? polaHealing;
  Personality? spiritual;
  dynamic picture;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<PublicFigure>? publicFigure;
  dynamic profilingName;
  dynamic shareCode;
  KeyUnderAge? keyUnderAge;

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
    this.karir,
    this.polaBahagia,
    this.polaInteraksi,
    this.family,
    this.polaHealing,
    this.spiritual,
    this.keyUnderAge,

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
        karir: json["karir"] == null
            ? null
            : Personality.fromJson(json["karir"]),
        polaBahagia: json["pola_bahagia"] == null
            ? null
            : Personality.fromJson(json["pola_bahagia"]),
        polaInteraksi: json["pola_interaksi_sosial"] == null
            ? null
            : Personality.fromJson(json["pola_interaksi_sosial"]),
        family: json["family"] == null
            ? null
            : Personality.fromJson(json["family"]),
         polaHealing: json["pola_healing"] == null
            ? null
            : Personality.fromJson(json["pola_healing"]),
        spiritual: json["spiritual"] == null
            ? null
            : Personality.fromJson(json["spiritual"]),

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
        keyUnderAge: json["key_under_age"] == null
            ? null
            : KeyUnderAge.fromJson(json["key_under_age"]),
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
        "karir": karir?.toJson(),
        "pola_bahagia": polaBahagia?.toJson(),
        "pola_interaksi_sosial": polaInteraksi?.toJson(),
        "family": family?.toJson(),
        "pola_healing": polaHealing?.toJson(),
        "spiritual": spiritual?.toJson(),
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

class KeyUnderAge {
  dynamic motivasi;
  dynamic karakter;
  dynamic kelebihan;
  dynamic kelemahan;
  dynamic polaKomunikasi;
  dynamic relasi;
  dynamic polaPendekatanDanAsuh;
  dynamic polaKesehatan;
  dynamic polaBintang;
  dynamic polaKetahanan;
  dynamic potensiBakatDanMinat;
  dynamic tipeKecerdasan;
  dynamic polaIngatan;
  dynamic polaBelajarMengajar;
  dynamic polaPendekatan;
  dynamic jalurPendidikan;
  dynamic jalurKarir;
  dynamic potensiBisnis;

  KeyUnderAge({
    this.motivasi,
    this.karakter,
    this.kelebihan,
    this.kelemahan,
    this.polaKomunikasi,
    this.relasi,
    this.polaPendekatanDanAsuh,
    this.polaKesehatan,
    this.polaBintang,
    this.polaKetahanan,
    this.potensiBakatDanMinat,
    this.tipeKecerdasan,
    this.polaIngatan,
    this.polaBelajarMengajar,
    this.polaPendekatan,
    this.jalurPendidikan,
    this.jalurKarir,
    this.potensiBisnis,
  });

  factory KeyUnderAge.fromJson(Map<String, dynamic> json) => KeyUnderAge(
    motivasi: json["motivate"],
    karakter: json["character"],
    kelebihan: json["strengths"],
    kelemahan: json["weaknesses"],
    polaKomunikasi: json["pola_komunikasi"],
    relasi: json["relasi"],
    polaPendekatanDanAsuh: json["pola_pendekatan_dan_pola_asuh"],
    polaKesehatan: json["pola_kesehatan"],
    polaBintang: json["pola_bintang"],
    polaKetahanan: json["pola_ketahanan"],
    potensiBakatDanMinat: json["potensi_bakat_dan_minat"],
    tipeKecerdasan: json["tipe_kecerdasan"],
    polaIngatan: json["pola_ingatan"],
    polaBelajarMengajar: json["pola_belajar_mengajar"],
    polaPendekatan: json["pola_pendekatan"],
    jalurPendidikan: json["jalur_pendidikan"],
    jalurKarir: json["jalur_karir"],
    potensiBisnis: json["potensi_bisnis"],
  );

  Map<String, dynamic> toJson() => {
    "motivate": motivasi,
    "character": karakter,
    "strengths": kelebihan,
    "weaknesses": kelemahan,
    "pola_komunikasi": polaKomunikasi,
    "relasi": relasi,
    "pola_pendekatan_dan_pola_asuh": polaPendekatanDanAsuh,
    "pola_kesehatan": polaKesehatan,
    "pola_bintang": polaBintang,
    "pola_ketahanan": polaKetahanan,
    "potensi_bakat_dan_minat": potensiBakatDanMinat,
    "tipe_kecerdasan": tipeKecerdasan,
    "pola_ingatan": polaIngatan,
    "pola_belajar_mengajar": polaBelajarMengajar,
    "pola_pendekatan": polaPendekatan,
    "jalur_pendidikan": jalurPendidikan,
    "jalur_karir": jalurKarir,
    "potensi_bisnis": potensiBisnis,
  };
}
