class Profiling {
  dynamic idUser;
  dynamic name;
  dynamic birthDate;
  dynamic monthDate;
  dynamic yearDate;
  dynamic bloodType;
  dynamic domicile;
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
