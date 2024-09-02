// To parse this JSON data, do
//
//     final resBankAccount = resBankAccountFromJson(jsonString);

import 'dart:convert';

ResBankAccount resBankAccountFromJson(String str) =>
    ResBankAccount.fromJson(json.decode(str));

String resBankAccountToJson(ResBankAccount data) => json.encode(data.toJson());

class ResBankAccount {
  bool? success;
  String? message;
  BankAccount? data;

  ResBankAccount({
    this.success,
    this.message,
    this.data,
  });

  factory ResBankAccount.fromJson(Map<String, dynamic> json) => ResBankAccount(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : BankAccount.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class BankAccount {
  String? id;
  String? accountNo;
  String? bankName;
  String? accountName;

  BankAccount({
    this.id,
    this.accountNo,
    this.bankName,
    this.accountName,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        id: json["id"],
        accountNo: json["account_no"],
        bankName: json["bank_name"],
        accountName: json["account_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_no": accountNo,
        "bank_name": bankName,
        "account_name": accountName,
      };
}
