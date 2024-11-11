class Multimedia {
  int? id;
  dynamic idPost;
  dynamic fileName;
  dynamic path;
  DateTime? createdAt;
  DateTime? updatedAt;

  Multimedia({
    this.id,
    this.idPost,
    this.fileName,
    this.path,
    this.createdAt,
    this.updatedAt,
  });

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
        id: json["id"],
        idPost: json["id_post"],
        fileName: json["file_name"],
        path: json["path"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_post": idPost,
        "file_name": fileName,
        "path": path,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
