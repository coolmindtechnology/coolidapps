class LocaleModel {
  final String numbLocale;
  final String name;
  final String locale;

  LocaleModel({
    required this.numbLocale,
    required this.name,
    required this.locale,
  });

  factory LocaleModel.fromJson(Map<String, dynamic> json) {
    return LocaleModel(
      numbLocale: json['numb_locale'],
      name: json['name'],
      locale: json['locale'],
    );
  }
}
