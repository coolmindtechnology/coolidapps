import 'package:cool_app/data/models/profiling.dart';
import 'package:cool_app/data/models/user.dart';

import 'multimedia.dart';

class DataPost {
  int? id;
  String? idUser;
  String? title;
  String? description;
  String? embedUrl;
  String? isComment;
  String? shareCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? likes;
  int? comment;
  List<Multimedia>? multimedia;
  Profiling? profiling;
  User? user;

  DataPost({
    this.id,
    this.idUser,
    this.title,
    this.description,
    this.embedUrl,
    this.isComment,
    this.shareCount,
    this.createdAt,
    this.updatedAt,
    this.likes,
    this.comment,
    this.multimedia,
    this.profiling,
    this.user,
  });

  factory DataPost.fromJson(Map<String, dynamic> json) => DataPost(
        id: json["id"],
        idUser: json["id_user"],
        title: json["title"],
        description: json["description"],
        embedUrl: json["embed_url"],
        isComment: json["is_comment"],
        shareCount: json["share_count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        likes: json["likes"],
        comment: json["comment"],
        multimedia: json["multimedia"] == null
            ? []
            : List<Multimedia>.from(
                json["multimedia"]!.map((x) => Multimedia.fromJson(x))),
        profiling: json["profiling"] == null
            ? null
            : Profiling.fromJson(json["profiling"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "title": title,
        "description": description,
        "embed_url": embedUrl,
        "is_comment": isComment,
        "share_count": shareCount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "likes": likes,
        "comment": comment,
        "multimedia": multimedia == null
            ? []
            : List<dynamic>.from(multimedia!.map((x) => x.toJson())),
        "profiling": profiling?.toJson(),
        "user": user?.toJson(),
      };
}
