// To parse this JSON data, do
//
//     final resListProfiling = resListProfilingFromJson(jsonString);

import 'dart:convert';

class ProfilingResponseFalse {
  final bool success;
  final String message;
  final List<ProfilingData> data;

  ProfilingResponseFalse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfilingResponseFalse.fromJson(Map<String, dynamic> json) {
    return ProfilingResponseFalse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => ProfilingData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class ProfilingData {
  final String idMultiple;
  final bool isPaid;
  final int totalProfiling;
  final String createdAt;
  final String time;
  final List<ProfilingResult> result;

  ProfilingData({
    required this.idMultiple,
    required this.isPaid,
    required this.totalProfiling,
    required this.createdAt,
    required this.time,
    required this.result,
  });

  factory ProfilingData.fromJson(Map<String, dynamic> json) {
    return ProfilingData(
      idMultiple: json['id_multiple'],
      isPaid: json['is_paid'],
      totalProfiling: json['total_profiling'],
      createdAt: json['created_at'],
      time: json['time'],
      result: (json['result'] as List)
          .map((item) => ProfilingResult.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_multiple': idMultiple,
      'is_paid': isPaid,
      'total_profiling': totalProfiling,
      'created_at': createdAt,
      'time': time,
      'result': result.map((item) => item.toJson()).toList(),
    };
  }
}

class ProfilingResult {
  final String id;
  final String idLogResult;
  final String status;
  final String result;
  final String bloodType;
  final String profilingName;
  final String domicile;
  final String yearDate;
  final String monthDate;
  final String birthDate;
  final String idMultiple;
  final String createdAt;
  final String typeBrain;
  final bool isAboveSeventeen;

  ProfilingResult({
    required this.id,
    required this.idLogResult,
    required this.status,
    required this.result,
    required this.bloodType,
    required this.profilingName,
    required this.domicile,
    required this.yearDate,
    required this.monthDate,
    required this.birthDate,
    required this.idMultiple,
    required this.createdAt,
    required this.typeBrain,
    required this.isAboveSeventeen,
  });

  factory ProfilingResult.fromJson(Map<String, dynamic> json) {
    return ProfilingResult(
      id: json['id'],
      idLogResult: json['id_log_result'],
      status: json['status'],
      result: json['result'],
      bloodType: json['blood_type'],
      profilingName: json['profiling_name'],
      domicile: json['domicile'],
      yearDate: json['year_date'],
      monthDate: json['month_date'],
      birthDate: json['birth_date'],
      idMultiple: json['id_multiple'],
      createdAt: json['created_at'],
      typeBrain: json['type_brain'],
      isAboveSeventeen: json['is_above_seventeen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_log_result': idLogResult,
      'status': status,
      'result': result,
      'blood_type': bloodType,
      'profiling_name': profilingName,
      'domicile': domicile,
      'year_date': yearDate,
      'month_date': monthDate,
      'birth_date': birthDate,
      'id_multiple': idMultiple,
      'created_at': createdAt,
      'type_brain': typeBrain,
      'is_above_seventeen': isAboveSeventeen,
    };
  }
}
