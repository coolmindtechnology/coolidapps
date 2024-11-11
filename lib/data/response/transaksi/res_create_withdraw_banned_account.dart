import 'dart:convert';

ResCreateWithdrawBanned rescreateWithdrawBannedFromJson(String str) =>
    ResCreateWithdrawBanned.fromJson(json.decode(str));

String rescreateWithdrawBannedToJson(ResCreateWithdrawBanned data) =>
    json.encode(data.toJson());

class ResCreateWithdrawBanned {
  final dynamic success;
  final Message message;
  final dynamic data;

  ResCreateWithdrawBanned({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResCreateWithdrawBanned.fromJson(Map<String, dynamic> json) {
    return ResCreateWithdrawBanned(
      success: json['success'],
      message: Message.fromJson(json['message']),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message.toJson(),
      'data': data,
    };
  }
}

class Message {
  final int transferredAmount;
  final int newDepositBalance;
  final DateTime nonActiveDate;

  Message({
    required this.transferredAmount,
    required this.newDepositBalance,
    required this.nonActiveDate,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      transferredAmount: json['transferred_amount'],
      newDepositBalance: json['new_deposit_balance'],
      nonActiveDate: DateTime.parse(json['non_active_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transferred_amount': transferredAmount,
      'new_deposit_balance': newDepositBalance,
      'non_active_date': nonActiveDate.toIso8601String(),
    };
  }
}
