import 'package:coolappflutter/data/data_global.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

void getCountryCode() {
  String phoneNumber = dataGlobal.dataUser?.phoneNumber.toString() ?? "";
  Country country = PhoneNumber.getCountry(phoneNumber.toString());
  dataGlobal.isIndonesia = country.code == "ID";
}
