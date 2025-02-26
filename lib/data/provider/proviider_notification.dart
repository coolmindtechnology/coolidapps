import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/response/notification/res_detail_notification.dart';
import 'package:coolappflutter/data/response/notification/res_get_all_notification.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> notifications = [];
  int totalNotif = 0;
  bool isLoading = false;
  int page = 1;
  final int pageSize = 10;
  final Dio _dio = Dio();

  NotificationProvider() {
    fetchNotifications();
  }
  Future<void> deleteNotification(String slug) async {
    try {
      final response = await _dio.delete(
        '${ApiEndpoint.baseUrl}/api/notify/delete/$slug',
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Authorization': 'Bearer ${dataGlobal.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Jika sukses, hapus notifikasi dari daftar
        notifications.removeWhere((notification) => notification.slug == slug);
        notifyListeners();
      } else {
        // Tangani error jika respon tidak sukses
        print('Gagal menghapus notifikasi: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error saat menghapus notifikasi: $e');
    }
  }

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    if (isLoading) return;

    // Jika ini adalah pull-to-refresh, reset notifikasi dan halaman ke awal
    if (isRefresh) {
      notifications.clear();
      page = 1;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get(
        '${ApiEndpoint.baseUrl}/api/notify/get',
        queryParameters: {'page': page},
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Authorization': 'Bearer ${dataGlobal.token}',
          },
        ),
      );

      debugPrint("Notif log $response");
      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        totalNotif = response.data['total_notif'];
        final List<NotificationModel> newNotifications =
            data.map((json) => NotificationModel.fromJson(json)).toList();
        notifications.addAll(newNotifications);
        page++; // Tambahkan page untuk pengambilan berikutnya
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Panggil loadMoreNotifications untuk mengambil halaman berikutnya
  void loadMoreNotifications() {
    if (!isLoading) fetchNotifications();
    notifyListeners();
  }

  Future<NotificationDetailModel?> fetchNotificationDetail(
      String notificationId) async {
    try {
      notifyListeners();
      final response = await _dio.get(
        '${ApiEndpoint.baseUrl}/api/notify/detail/$notificationId',
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Authorization': 'Bearer ${dataGlobal.token}',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return NotificationDetailModel.fromJson(response.data['data']);
      }
    } catch (e) {
      notifyListeners();
      print('Error fetching notification detail: $e');
    }
    return null;
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoint.baseUrl}/api/notify/read/$notificationId',
        data: {
          "is_read": 1,
        },
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Authorization': 'Bearer ${dataGlobal.token}',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        // Update notification in local list

        debugPrint('Sukses Baca notif');
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }
}
