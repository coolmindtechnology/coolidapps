class User {
  int? id;
  dynamic idRole;
  dynamic name;
  dynamic phoneNumber;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic address;
  dynamic image;
  dynamic idCardNumber;
  dynamic otpCode;
  DateTime? otpTime;
  dynamic isProfiling;
  dynamic isVerified;
  dynamic isDeposit;
  dynamic totalDeposit;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  User({
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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        otpTime:
            json["otp_time"] == null ? null : DateTime.parse(json["otp_time"]),
        isProfiling: json["is_profiling"],
        isVerified: json["is_verified"],
        isDeposit: json["is_deposit"],
        totalDeposit: json["total_deposit"],
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
      };
}
