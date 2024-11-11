// To parse this JSON data, do
//
//     final resGetAffiliateManagement = resGetAffiliateManagementFromJson(jsonString);

import 'dart:convert';

ResGetAffiliateManagement resGetAffiliateManagementFromJson(String str) =>
    ResGetAffiliateManagement.fromJson(json.decode(str));

String resGetAffiliateManagementToJson(ResGetAffiliateManagement data) =>
    json.encode(data.toJson());

class ResGetAffiliateManagement {
  bool? success;
  dynamic message;
  DataAffiliateManagement? data;

  ResGetAffiliateManagement({
    this.success,
    this.message,
    this.data,
  });

  factory ResGetAffiliateManagement.fromJson(Map<String, dynamic> json) =>
      ResGetAffiliateManagement(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DataAffiliateManagement.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataAffiliateManagement {
  int? id;
  dynamic presentaseAffiliator;
  dynamic mininumDeposit;
  dynamic maximumDeposit;
  dynamic withdrawMinimum;
  dynamic withdrawMaximum;
  dynamic feeCommitment;
  dynamic maximumAffiliator;
  dynamic feeAgent;
  dynamic feeMitra;
  dynamic vacumDay;
  dynamic nonActiveDay;
  dynamic maximalDayActive;
  dynamic intlFeeAffiliator;
  dynamic intlMininumDeposit;
  dynamic intlMaximumDeposit;
  dynamic intlFeeCommitment;
  dynamic intlFeeAgent;
  dynamic intlFeeMitra;
  dynamic firstFeeAgent;
  dynamic firstFeeMitra;
  dynamic intlFirstFeeAgent;
  dynamic intlFirstFeeMitra;
  DateTime? createdAt;
  DateTime? updatedAt;

  DataAffiliateManagement({
    this.id,
    this.presentaseAffiliator,
    this.mininumDeposit,
    this.maximumDeposit,
    this.withdrawMinimum,
    this.withdrawMaximum,
    this.feeCommitment,
    this.maximumAffiliator,
    this.feeAgent,
    this.feeMitra,
    this.vacumDay,
    this.nonActiveDay,
    this.maximalDayActive,
    this.intlFeeAffiliator,
    this.intlMininumDeposit,
    this.intlMaximumDeposit,
    this.intlFeeCommitment,
    this.intlFeeAgent,
    this.intlFeeMitra,
    this.firstFeeAgent,
    this.firstFeeMitra,
    this.intlFirstFeeAgent,
    this.intlFirstFeeMitra,
    this.createdAt,
    this.updatedAt,
  });

  factory DataAffiliateManagement.fromJson(Map<String, dynamic> json) =>
      DataAffiliateManagement(
        id: json["id"],
        presentaseAffiliator: json["presentase_affiliator"],
        mininumDeposit: json["mininum_deposit"],
        maximumDeposit: json["maximum_deposit"],
        withdrawMinimum: json["withdraw_minimum"],
        withdrawMaximum: json["withdraw_maximum"],
        feeCommitment: json["fee_commitment"],
        maximumAffiliator: json["maximum_affiliator"],
        feeAgent: json["fee_agent"],
        feeMitra: json["fee_mitra"],
        vacumDay: json["vacum_day"],
        nonActiveDay: json["non_active_day"],
        maximalDayActive: json["maximal_day_active"],
        intlFeeAffiliator: json["intl_fee_affiliator"],
        intlMininumDeposit: json["intl_mininum_deposit"],
        intlMaximumDeposit: json["intl_maximum_deposit"],
        intlFeeCommitment: json["intl_fee_commitment"],
        intlFeeAgent: json["intl_fee_agent"],
        intlFeeMitra: json["intl_fee_mitra"],
        firstFeeAgent: json["first_fee_agent"],
        firstFeeMitra: json["first_fee_mitra"],
        intlFirstFeeAgent: json["intl_first_fee_agent"],
        intlFirstFeeMitra: json["intl_first_fee_mitra"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "presentase_affiliator": presentaseAffiliator,
        "mininum_deposit": mininumDeposit,
        "maximum_deposit": maximumDeposit,
        "withdraw_minimum": withdrawMinimum,
        "withdraw_maximum": withdrawMaximum,
        "fee_commitment": feeCommitment,
        "maximum_affiliator": maximumAffiliator,
        "fee_agent": feeAgent,
        "fee_mitra": feeMitra,
        "vacum_day": vacumDay,
        "non_active_day": nonActiveDay,
        "maximal_day_active": maximalDayActive,
        "intl_fee_affiliator": intlFeeAffiliator,
        "intl_mininum_deposit": intlMininumDeposit,
        "intl_maximum_deposit": intlMaximumDeposit,
        "intl_fee_commitment": intlFeeCommitment,
        "intl_fee_agent": intlFeeAgent,
        "intl_fee_mitra": intlFeeMitra,
        "first_fee_agent": firstFeeAgent,
        "first_fee_mitra": firstFeeMitra,
        "intl_first_fee_agent": intlFirstFeeAgent,
        "intl_first_fee_mitra": intlFirstFeeMitra,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
