import 'dart:async';

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/proviider_notification.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/notification/notification_detail.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
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
    cekSession();
    initLoad();
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

  initLoad() async {
    await context
        .read<NotificationProvider>().fetchNotifications(isRefresh: true);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
    if (ceklanguage == null) {
      Prefs().setLocale('en_US', () {
        setState(() {
          S.load(Locale('en_US'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    } else {
      Prefs().setLocale('$ceklanguage', () {
        setState(() {
          S.load(Locale('$ceklanguage'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        final notifications = provider.notifications;
        final isLoading = provider.isLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).notification,
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () => provider.fetchNotifications(isRefresh: true),
                icon: Badge.count(
                  count: provider.totalNotif,
                  child: const Icon(Icons.notifications),
                ),
              ),
            ],
          ),
          body: Builder(
            builder: (_) {
              if (isLoading && notifications.isEmpty) {
                // Loading saat awal
                return ListView(
                  children: List.generate(6, (_) => Column(
                    children: [gapH10, shimmerButton()],
                  )),
                );
              }

              if (notifications.isEmpty) {
                // Tidak ada notifikasi
                return Center(
                  child: ElevatedButton(
                    onPressed: () => provider.loadMoreNotifications(),
                    child: Text(S.of(context).no_data),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => provider.fetchNotifications(isRefresh: true),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: notifications.length + 1,
                  itemBuilder: (context, index) {
                    if (index == notifications.length) {
                      return isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox.shrink();
                    }

                    final notification = notifications[index];
                    final isRead = notification.isRead == 1;
                    final date = DateFormat("dd MMM yyyy", 'id_ID')
                        .format(notification.creatAt ?? DateTime.now());

                    return GestureDetector(
                      onTap: () async {
                        final detail = await provider.fetchNotificationDetail(notification.slug);
                        if (detail != null && detail.isRead == 0) {
                          await provider.markAsRead(notification.slug);
                        }
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailNotificationScreen(
                              notificationId: notification.slug,
                            ),
                          ),
                        );
                        await provider.fetchNotifications(isRefresh: true);
                      },
                      child: Card(
                        color: isRead ? Colors.grey[300] : Colors.white,
                        child: ListTile(
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    date,
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
                ),
              );
            },
          ),
        );
      },
    );
  }

}
Widget shimmerContainer({double height = 50, double width = double.infinity}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

Widget shimmerButton() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}