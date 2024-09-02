import 'package:cool_app/data/response/res_opening_cool.dart';
import 'package:cool_app/data/response/user/res_get_location_member.dart';
import 'package:cool_app/data/response/user/res_get_user.dart';
import 'package:flutter/foundation.dart';

class DataGlobal extends ChangeNotifier {
  DataGlobal();
  DataUser? dataUser;
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
