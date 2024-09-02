class DataMemberAffiliate {
  int? id;
  String? idRole;
  String? name;
  String? phoneNumber;
  String? email;
  dynamic emailVerifiedAt;
  String? address;
  String? image;
  String? idCardNumber;
  String? otpCode;
  DateTime? otpTime;
  String? isProfiling;
  String? isVerified;
  String? isDeposit;
  String? totalDeposit;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? idAffiliate;
  dynamic codeReferal;
  dynamic idAgent;
  dynamic idMitra;
  String? isAffiliate;
  dynamic verificationToken;
  String? profilingsCount;
  List<Profiling>? profilings;

  DataMemberAffiliate({
    this.id,
    this.idRole,
    this.name,
    this.phoneNumber,
    this.email,
    this.emailVerifiedAt,
    this.address,
    this.image,
    this.idCardNumber,
    this.otpCode,
    this.otpTime,
    this.isProfiling,
    this.isVerified,
    this.isDeposit,
    this.totalDeposit,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.idAffiliate,
    this.codeReferal,
    this.idAgent,
    this.idMitra,
    this.isAffiliate,
    this.verificationToken,
    this.profilingsCount,
    this.profilings,
  });

  factory DataMemberAffiliate.fromJson(Map<String, dynamic> json) => DataMemberAffiliate(
    id: json["id"],
    idRole: json["id_role"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    address: json["address"],
    image: json["image"],
    idCardNumber: json["id_card_number"],
    otpCode: json["otp_code"],
    otpTime: json["otp_time"] == null ? null : DateTime.parse(json["otp_time"]),
    isProfiling: json["is_profiling"],
    isVerified: json["is_verified"],
    isDeposit: json["is_deposit"],
    totalDeposit: json["total_deposit"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    idAffiliate: json["id_affiliate"],
    codeReferal: json["code_referal"],
    idAgent: json["id_agent"],
    idMitra: json["id_mitra"],
    isAffiliate: json["is_affiliate"],
    verificationToken: json["verification_token"],
    profilingsCount: json["profilings_count"],
    profilings: json["profilings"] == null ? [] : List<Profiling>.from(json["profilings"]!.map((x) => Profiling.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_role": idRole,
    "name": name,
    "phone_number": phoneNumber,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "address": address,
    "image": image,
    "id_card_number": idCardNumber,
    "otp_code": otpCode,
    "otp_time": otpTime?.toIso8601String(),
    "is_profiling": isProfiling,
    "is_verified": isVerified,
    "is_deposit": isDeposit,
    "total_deposit": totalDeposit,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "id_affiliate": idAffiliate,
    "code_referal": codeReferal,
    "id_agent": idAgent,
    "id_mitra": idMitra,
    "is_affiliate": isAffiliate,
    "verification_token": verificationToken,
    "profilings_count": profilingsCount,
    "profilings": profilings == null ? [] : List<dynamic>.from(profilings!.map((x) => x.toJson())),
  };
}

class Profiling {
  String? idUser;
  String? name;
  String? birthDate;
  String? monthDate;
  String? yearDate;
  String? bloodType;
  String? domicile;
  dynamic deletedAt;

  Profiling({
    this.idUser,
    this.name,
    this.birthDate,
    this.monthDate,
    this.yearDate,
    this.bloodType,
    this.domicile,
    this.deletedAt,
  });

  factory Profiling.fromJson(Map<String, dynamic> json) => Profiling(
    idUser: json["id_user"],
    name: json["name"],
    birthDate: json["birth_date"],
    monthDate: json["month_date"],
    yearDate: json["year_date"],
    bloodType: json["blood_type"],
    domicile: json["domicile"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "name": name,
    "birth_date": birthDate,
    "month_date": monthDate,
    "year_date": yearDate,
    "blood_type": bloodType,
    "domicile": domicile,
    "deleted_at": deletedAt,
  };
}
