import 'package:coolappflutter/data/response/res_opening_cool.dart';
import 'package:coolappflutter/data/response/user/res_get_location_member.dart';
import 'package:coolappflutter/data/response/user/res_get_user.dart';
import 'package:coolappflutter/data/response/consultant/res_dashboard_consultant.dart'
    as consultant;
import 'package:coolappflutter/data/response/affiliate/res_overview.dart'
    as Aff;
import 'package:flutter/foundation.dart';

class DataGlobal extends ChangeNotifier {
  DataGlobal();
  DataUser? dataUser;
  consultant.Data? dataConsultant;
  Aff.Data? dataAff;
  MemberArea? dataMember;
  DataOpening? dataOpening;
  bool isIndonesia = true;

  String _token = '';

  String get token => _token;

  // Sets the token by combining "Bearer" with the newToken parameter and notifies listeners.
  void setToken(String newToken) {
    _token = 'Bearer $newToken'; // Menggabungkan "Bearer" dengan token
    notifyListeners();
  }
}

final DataGlobal dataGlobal = DataGlobal();
