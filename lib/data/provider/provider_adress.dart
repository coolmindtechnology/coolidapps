import 'package:shared_preferences/shared_preferences.dart';

class AddressPreferences {
  static const String _keyAddress = 'address';

  // Simpan address dalam 1 string: "state,city,district"
  static Future<void> saveAddressString(String state, String city, String district) async {
    final prefs = await SharedPreferences.getInstance();

    String addressString = '$state,$city,$district';
    await prefs.setString(_keyAddress, addressString);
  }

  // Ambil address, parsing ke Map
  static Future<Map<String, String>?> getAddressMap() async {
    final prefs = await SharedPreferences.getInstance();
    String? addressString = prefs.getString(_keyAddress);

    if (addressString == null) return null;

    // Pisah berdasarkan koma
    List<String> parts = addressString.split(',');

    if (parts.length != 3) return null;

    return {
      'state': parts[0],
      'city': parts[1],
      'district': parts[2],
    };
  }

  // Ambil address utuh sebagai string
  static Future<String?> getAddressString() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAddress);
  }

  // Hapus
  static Future<void> clearAddress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAddress);
  }
}
