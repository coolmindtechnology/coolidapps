import 'package:cool_app/data/data_global.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

void getCountryCode() {
  String phoneNumber = dataGlobal.dataUser?.phoneNumber ?? "";
  Country country = PhoneNumber.getCountry(phoneNumber);
  dataGlobal.isIndonesia = country.code == "ID";
}
