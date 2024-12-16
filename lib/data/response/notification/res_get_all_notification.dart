class NotificationModel {
  final String me;
  final String slug;
  final String title;
  final String message;
  final int isRead;
  final String dateRead;
  final DateTime? creatAt;

  NotificationModel({
    required this.me,
    required this.slug,
    required this.title,
    required this.message,
    required this.isRead,
    required this.dateRead,
    required this.creatAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        me: json['me'],
        slug: json['slug'],
        title: json['title'],
        message: json['message'],
        isRead: json['is_read'],
        dateRead: json['date_read'],
        creatAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        "me": me,
        "slug": slug,
        "title": title,
        "message": message,
        "is_read": isRead,
        "date_read": dateRead,
        "created_at": creatAt?.toIso8601String(),
      };
}
