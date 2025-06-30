class ResCheckPrice {
  final bool success;
  final String message;
  final CheckPriceData data;

  ResCheckPrice({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResCheckPrice.fromJson(Map<String, dynamic> json) {
    return ResCheckPrice(
      success: json['success'],
      message: json['message'],
      data: CheckPriceData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CheckPriceData {
  final int count;
  final bool limitExceeded;
  final dynamic price;

  CheckPriceData({
    required this.count,
    required this.limitExceeded,
    required this.price,
  });

  factory CheckPriceData.fromJson(Map<String, dynamic> json) {
    return CheckPriceData(
      count: json['count'],
      limitExceeded: json['limit_exceeded'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'limit_exceeded': limitExceeded,
      'price': price,
    };
  }
}
