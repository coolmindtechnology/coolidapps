class NotificationDetailModel {
  final String title;
  final String message;
  final int isRead;
  final String? dateRead;
  final String asset;

  NotificationDetailModel({
    required this.title,
    required this.message,
    required this.isRead,
    this.dateRead,
    required this.asset,
  });

  factory NotificationDetailModel.fromJson(Map<String, dynamic> json) {
    return NotificationDetailModel(
      title: json['title'] as String,
      message: json['message'] as String,
      isRead: json['is_read'] as int,
      dateRead: json['date_read'] as String?,
      asset: json['asset'] as String,
    );
  }
}
