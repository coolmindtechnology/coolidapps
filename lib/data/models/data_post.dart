import 'package:coolappflutter/data/models/profiling.dart';
import 'package:coolappflutter/data/models/user.dart';

import 'multimedia.dart';

class DataPost {
  dynamic id;
  dynamic idUser;
  dynamic title;
  dynamic description;
  dynamic embedUrl;
  dynamic isComment;
  dynamic shareCount;
  dynamic? createdAt;
  dynamic? timeAgo;
  DateTime? updatedAt;
  dynamic likes;
  dynamic comment;
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
    this.timeAgo,
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
        timeAgo: json["time_ago"],
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
        "time_ago": timeAgo,
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
