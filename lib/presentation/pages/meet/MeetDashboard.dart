import 'package:coolappflutter/data/provider/provider_meet.dart';
import 'package:coolappflutter/presentation/pages/meet/DetailMeet.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetingDashboard extends StatefulWidget {
  @override
  State<MeetingDashboard> createState() => _MeetingDashboardState();
}

class _MeetingDashboardState extends State<MeetingDashboard> {
  @override
  void initState() {
    super.initState();
    // Fetch data meeting dari API saat halaman dibuka
    Future.microtask(() =>
        Provider.of<MeetProvider>(context, listen: false).fetchListMeet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'CoolMeet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Meeting Tersedia',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<MeetProvider>(
                builder: (context, meetProvider, child) {
                  if (meetProvider.isLoadingListMeet) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (meetProvider.listMeet.isEmpty) {
                    return const Center(
                      child: Text("Tidak ada meeting tersedia"),
                    );
                  }

                  return ListView.builder(
                    itemCount: meetProvider.listMeet.length,
                    itemBuilder: (context, index) {
                      final meeting = meetProvider.listMeet[index];

                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                meeting.title ?? 'No Title',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                meeting.status ?? 'Unknown',
                                style: TextStyle(
                                  color: (meeting.status == 'Sedang berlangsung')
                                      ? primaryColor
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconTextRow(
                                      text: meeting.time ?? 'Unknown Time',
                                      icon: Icons.access_time,
                                    ),
                                    const Spacer(),
                                    IconTextRow(
                                      text: meeting.place ?? 'Unknown Place',
                                      icon: Icons.location_on,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Nav.to(DetailMeetingPage(meetingId: meeting.id.toString(),codemeet: meeting.host.toString(),));
                          },
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

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconTextRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(icon, size: 16), const SizedBox(width: 5), Text(text)],
    );
  }
}
