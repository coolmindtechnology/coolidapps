class DurasiUtils {
  static String konversiDurasi(String durasiString) {
    Duration durasi = _parseDurasi(durasiString);
    return _formatDurasiToJamMenit(durasi);
  }

  static Duration _parseDurasi(String durasiString) {
    List<String> bagian = durasiString.split(":");
    int jam = int.parse(bagian[0]);
    int menit = int.parse(bagian[1]);
    int detik = int.parse(bagian[2]);
    return Duration(hours: jam, minutes: menit, seconds: detik);
  }

  static String _formatDurasiToJamMenit(Duration durasi) {
    if (durasi.inHours >= 1) {
      int jam = durasi.inHours;
      int menit = durasi.inMinutes.remainder(60);
      return '$jam h $menit min';
    } else {
      int menit = durasi.inMinutes;

      return '$menit min';
    }
  }
}
