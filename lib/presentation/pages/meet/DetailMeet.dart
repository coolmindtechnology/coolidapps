import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/provider/provider_meet.dart';
import 'package:coolappflutter/presentation/pages/meet/RoomMeet.dart';
import 'package:coolappflutter/presentation/pages/meet/WaitingApproval.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailMeetingPage extends StatelessWidget {
  final String meetingId;
  final String codemeet;

  const DetailMeetingPage({super.key, required this.meetingId,required this.codemeet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Detail Meeting',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<MeetProvider>(context, listen: false)
            .fetchDetailMeet(meetingId),
        builder: (context, snapshot) {
          final meetProvider = Provider.of<MeetProvider>(context);
          final meeting = meetProvider.detailMeet;

          if (meetProvider.isLoadingDetailMeet) {
            return const Center(child: CircularProgressIndicator());
          }

          if (meeting == null) {
            return const Center(child: Text("Meeting tidak ditemukan"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                   '${meeting.title}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Image.asset('images/Ellipse 20.png', width: 40, height: 40),
                    const SizedBox(width: 5),
                    Text('CoolTeam •  ${meeting.time}'),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBFEFD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      meeting.status ?? 'STATUS UNKNOWN',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    meeting.media ??
                        'https://via.placeholder.com/600x300?text=No+Image',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  meeting.description ?? 'Tidak ada deskripsi tersedia',
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Text(
                  'Detail Meeting',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: BlueColor),
                ),
                const SizedBox(height: 5),
                _buildDetailRow('Tanggal mulai:', meeting.createdAt ?? '-'),
                _buildDetailRow('Waktu mulai:', meeting.time ?? '-'),
                _buildDetailRow('Tempat:', meeting.place ?? '-'),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Nav.to(VideoConferencePage(conferenceID: codemeet,userName: dataGlobal.dataUser!.name.toString(),));
                    },
                    child: const Text(
                      'Ikuti MEETING',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(value),
        ],
      ),
    );
  }
}
