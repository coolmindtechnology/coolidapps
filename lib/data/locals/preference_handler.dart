import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static Future<void> storingId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id_bahasa", id);
  }

  static Future<String?> retrieveId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? result = preferences.getString("id_bahasa");
    return result;
  }

  static Future<void> removeId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("id_bahasa");
  }

  static Future<void> storingIdLanguage(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", id);
  }

  static Future<String?> retrieveIdLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? result = preferences.getString("id");
    return result;
  }

  static Future<void> removeIdLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("id");
  }

  static Future<void> storingIdUser(String idUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("idUser", idUser);
  }

  static Future<String?> retrieveIdUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? result = preferences.getString("idUser");
    return result;
  }
}
