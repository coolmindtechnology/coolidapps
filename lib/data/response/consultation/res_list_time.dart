class ResponseSessionTimes {
  final bool success;
  final String message;
  final SessionData data;

  ResponseSessionTimes({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseSessionTimes.fromJson(Map<String, dynamic> json) {
    return ResponseSessionTimes(
      success: json['success'],
      message: json['message'],
      data: SessionData.fromJson(json['data']),
    );
  }
}

class SessionData {
  final String day;
  final Map<String, String> times;

  SessionData({
    required this.day,
    required this.times,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) {
    return SessionData(
      day: json['day'],
      times: Map<String, String>.from(json['times']),
    );
  }
}
