// To parse this JSON data, do
//
//     final resCreatePost = resCreatePostFromJson(jsonString);

import 'dart:convert';

ResCreatePost resCreatePostFromJson(String str) =>
    ResCreatePost.fromJson(json.decode(str));

String resCreatePostToJson(ResCreatePost data) => json.encode(data.toJson());

class ResCreatePost {
  bool? success;
  dynamic message;
  DataCreate? data;

  ResCreatePost({
    this.success,
    this.message,
    this.data,
  });

  factory ResCreatePost.fromJson(Map<String, dynamic> json) => ResCreatePost(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : DataCreate.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataCreate {
  dynamic idUser;
  dynamic title;
  dynamic description;
  dynamic embedUrl;
  dynamic isComment;
  List<Audio>? image;
  List<Audio>? audio;
  List<String>? blockWord;

  DataCreate({
    this.idUser,
    this.title,
    this.description,
    this.embedUrl,
    this.isComment,
    this.image,
    this.audio,
    this.blockWord,
  });

  factory DataCreate.fromJson(Map<String, dynamic> json) => DataCreate(
        idUser: json["id_user"],
        title: json["title"],
        description: json["description"],
        embedUrl: json["embed_url"],
        isComment: json["is_comment"],
        image: json["image"] == null
            ? []
            : List<Audio>.from(json["image"]!.map((x) => Audio.fromJson(x))),
        audio: json["audio"] == null
            ? []
            : List<Audio>.from(json["audio"]!.map((x) => Audio.fromJson(x))),
        blockWord: json["block_word"] == null
            ? []
            : List<String>.from(json["block_word"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "title": title,
        "description": description,
        "embed_url": embedUrl,
        "is_comment": isComment,
        "image": image == null
            ? []
            : List<dynamic>.from(image!.map((x) => x.toJson())),
        "audio": audio == null
            ? []
            : List<dynamic>.from(audio!.map((x) => x.toJson())),
        "block_word": blockWord == null
            ? []
            : List<dynamic>.from(blockWord!.map((x) => x)),
      };
}

class Audio {
  dynamic fileName;
  dynamic path;
  dynamic idPost;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;

  Audio({
    this.fileName,
    this.path,
    this.idPost,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        fileName: json["file_name"],
        path: json["path"],
        idPost: json["id_post"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "file_name": fileName,
        "path": path,
        "id_post": idPost,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
