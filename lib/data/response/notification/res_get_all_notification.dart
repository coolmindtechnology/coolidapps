class NotificationModel {
  final String me;
  final String slug;
  final String title;
  final String message;
  final int isRead;
  final String dateRead;

  NotificationModel({
    required this.me,
    required this.slug,
    required this.title,
    required this.message,
    required this.isRead,
    required this.dateRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      me: json['me'],
      slug: json['slug'],
      title: json['title'],
      message: json['message'],
      isRead: json['is_read'],
      dateRead: json['date_read'],
    );
  }
}
