import 'package:coolappflutter/data/provider/provider_meet.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // ✅ Tambahkan library intl

class RiwayatMeetingPage extends StatefulWidget {
  @override
  State<RiwayatMeetingPage> createState() => _RiwayatMeetingPageState();
}

class _RiwayatMeetingPageState extends State<RiwayatMeetingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MeetProvider>().fetchListHistoryMeet());
  }

  /// **Fungsi untuk menampilkan date picker dan filter data berdasarkan tanggal**
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      context.read<MeetProvider>().setFilterDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Riwayat CoolMeet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Filter berdasarkan tanggal**
            GestureDetector(
              onTap: () => _selectDate(context), // ✅ Tambahkan fungsi filter tanggal
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200], // ✅ Tambahkan warna biar lebih jelas
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(width: 10),
                    const Text(
                      'Filter berdasarkan tanggal',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'CoolMeet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            /// **Consumer untuk mengambil data dari provider**
            Expanded(
              child: Consumer<MeetProvider>(
                builder: (context, meetProvider, child) {
                  if (meetProvider.isLoadingHistoryMeet) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (meetProvider.listHistoryMeet.isEmpty) {
                    return const Center(
                      child: Text("Tidak ada riwayat meeting."),
                    );
                  }

                  return ListView.builder(
                    itemCount: meetProvider.listHistoryMeet.length,
                    itemBuilder: (context, index) {
                      final history = meetProvider.listHistoryMeet[index];

                      /// **Format ulang tanggal dari String ke `DateTime`**
                      String formattedDate = "Tanggal tidak tersedia";
                      if (history.dateMeet != null) {
                        try {
                          DateTime parsedDate = history.dateMeet!; // Langsung pakai tanpa parse
                          formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);
                        } catch (e) {
                          debugPrint("Error parsing date: $e");
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    history.title ?? 'Meeting Tanpa Judul',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis, // ✅ Tambahkan biar nggak kepanjangan
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  formattedDate,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  history.category ?? 'Kategori tidak diketahui',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const Spacer(),
                                Text(
                                  history.time ?? 'Waktu tidak tersedia',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
