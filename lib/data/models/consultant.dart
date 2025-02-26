class ConsultantRequest {
  String? titleExperience;
  String? descriptionExperience;
  String? document;

  ConsultantRequest({
    this.titleExperience,
    this.descriptionExperience,
    this.document,
  });

  // Fungsi untuk mengkonversi data ke format JSON
  Map<String, dynamic> toJson() => {
    "title_experience": titleExperience,
    "description_experience": descriptionExperience,
    "document": document,
  };
}
