import 'package:coolappflutter/data/provider/proviider_notification.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/notification/notification_detail.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// Import screen detail

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final provider =
          Provider.of<NotificationProvider>(context, listen: false);
      provider.loadMoreNotifications(); // Memuat halaman berikutnya
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).notification,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              int unreadCount = provider.notifications
                  .where((notification) => notification.isRead == 0)
                  .length;
              return IconButton(
                onPressed: () async {
                  await provider.fetchNotifications(isRefresh: true);
                  setState(() {});
                },
                icon: Badge.count(
                  count: provider.totalNotif,
                  child: const Icon(Icons.notifications),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
              onRefresh: () async {
                // Memanggil fetchNotifications dengan isRefresh true untuk pull-to-refresh
                await provider.fetchNotifications(isRefresh: true);
              },
              child: provider.notifications.isNotEmpty
                  ? ListView.builder(
                      controller: _scrollController,
                      itemCount: provider.notifications.length + 1,
                      itemBuilder: (context, index) {
                        if (index == provider.notifications.length) {
                          return provider.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox
                                  .shrink(); // Indikator loading untuk data berikutnya
                        }
                        final notification = provider.notifications[index];
                        return GestureDetector(
                          onTap: () async {
                            final notificationDetail = await provider
                                .fetchNotificationDetail(notification.slug);
                            if (notificationDetail != null &&
                                notificationDetail.isRead == 0) {
                              await provider.markAsRead(notification.slug);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailNotificationScreen(
                                  notificationId: notification.slug,
                                ),
                              ),
                            ).then((_) {
                              // Refresh after returning from detail screen to update read status
                              provider.fetchNotifications(isRefresh: true);
                            });
                          },
                          child: Card(
                            color: notification.isRead == 1
                                ? Colors.grey[300]
                                : Colors.white,
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        DateFormat("dd MMM yyyy").format(
                                            notification.creatAt ??
                                                DateTime.now()),
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  Text(notification.title),
                                ],
                              ),
                              subtitle: Text(notification.message),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Center(
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {});
                                final provider =
                                    Provider.of<NotificationProvider>(context,
                                        listen: false);
                                provider.loadMoreNotifications();
                              },
                              child: Text(S.of(context).no_data))),
                    ));
        },
      ),
    );
  }
}
