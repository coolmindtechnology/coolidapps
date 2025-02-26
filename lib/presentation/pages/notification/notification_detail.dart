import 'package:coolappflutter/data/provider/proviider_notification.dart';
import 'package:coolappflutter/data/response/notification/res_detail_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';

class DetailNotificationScreen extends StatefulWidget {
  final String notificationId;

  const DetailNotificationScreen({super.key, required this.notificationId});

  @override
  _DetailNotificationScreenState createState() =>
      _DetailNotificationScreenState();
}

class _DetailNotificationScreenState extends State<DetailNotificationScreen> {
  NotificationDetailModel? notificationDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationDetail();
  }

  Future<void> _loadNotificationDetail() async {
    final provider = Provider.of<NotificationProvider>(context, listen: false);
    notificationDetail =
        await provider.fetchNotificationDetail(widget.notificationId);

    // Mark notification as read if it hasn't been read
    if (notificationDetail != null && notificationDetail!.isRead == 0) {
      await provider.markAsRead(widget.notificationId);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).notification,
          // "Notification Detail",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notificationDetail == null
              ? Center(
                  child: Text(S.of(context).no_data
                      // "Failed to load notification detail."
                      ))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificationDetail!.title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        notificationDetail!.message,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${S.of(context).date}: ${notificationDetail!.dateRead ?? 'Not ${S.of(context).read} yet'}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      // notificationDetail!.asset != "Asset Not Available"
                      //     ? Image.network(notificationDetail!.asset)
                      //     : const Text("No asset available"),
                    ],
                  ),
                ),
    );
  }
}
