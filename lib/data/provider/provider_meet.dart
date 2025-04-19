import 'package:coolappflutter/data/response/meet/res_GetHistoryMeet.dart' as history;
import 'package:coolappflutter/data/response/meet/res_GetHistoryMeet.dart';
import 'package:coolappflutter/data/response/meet/res_GetListMeet.dart';
import 'package:flutter/foundation.dart';
import 'package:coolappflutter/data/repositories/repo_meet.dart';
import 'package:coolappflutter/data/helpers/either.dart';
import 'package:coolappflutter/data/helpers/failure.dart';
import 'package:coolappflutter/data/response/meet/res_GetListMeet.dart' as listmeet;
import 'package:coolappflutter/data/response/meet/res_GetDetailMeet.dart';
import 'package:intl/intl.dart';  // Tambahkan untuk format tanggal

class MeetProvider extends ChangeNotifier {
  // Inisialisasi repository
  final RepoMeet repoMeet = RepoMeet();

  // Variable
  DateTime? selectedDate;

  // State loading
  bool isLoadingListMeet = false;
  bool isLoadingDetailMeet = false;
  bool isLoadingHistoryMeet = false;

  // Data list meeting
  List<listmeet.Datum>? meetList;
  List<listmeet.Datum> get listMeet => meetList ?? [];

  // Data detail meeting
  Data? meetDetail;
  Data? get detailMeet => meetDetail;

  // Data history meeting
  List<history.Datum>? historyMeetList;
  List<history.Datum> filteredHistoryList = []; // ✅ Tambahkan variabel ini
  List<history.Datum> get listHistoryMeet =>
      selectedDate == null ? (historyMeetList ?? []) : filteredHistoryList;

  //=================================================func===============/

  /// **Get List Meeting**
  Future<void> fetchListMeet() async {
    isLoadingListMeet = true;
    notifyListeners();

    Either<Failure, ResGetListMeet> response = await repoMeet.getlistMeet();

    isLoadingListMeet = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("Error fetching meeting list: ${failure.message}");
      },
      success: (res) {
        if (res.success == true) {
          meetList = res.data;
          debugPrint("Meeting list fetched successfully");
        } else {
          debugPrint("Failed to fetch meeting list");
        }
        notifyListeners();
      },
    );
  }

  /// **Get Detail Meeting**
  Future<void> fetchDetailMeet(String id) async {
    isLoadingDetailMeet = true;
    notifyListeners();

    Either<Failure, ResGetDetailMeet> response =
    await repoMeet.GetDetailMeet(id: id);

    isLoadingDetailMeet = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("Error fetching meeting detail: ${failure.message}");
      },
      success: (res) {
        if (res.success == true) {
          meetDetail = res.data;
          debugPrint("Meeting detail fetched successfully");
        } else {
          debugPrint("Failed to fetch meeting detail");
        }
        notifyListeners();
      },
    );
  }

  /// **Get History Meeting**
  Future<void> fetchListHistoryMeet() async {
    isLoadingHistoryMeet = true;
    notifyListeners();

    Either<Failure, ResGetHistoryMeet> response = await repoMeet.getHistoryMeet();

    isLoadingHistoryMeet = false;
    notifyListeners();

    response.when(
      error: (failure) {
        debugPrint("Error fetching meeting history: ${failure.message}");
      },
      success: (res) {
        if (res.success == true) {
          historyMeetList = res.data;
          filteredHistoryList = historyMeetList ?? [];
          debugPrint("Meeting history fetched successfully");
        } else {
          debugPrint("Failed to fetch meeting history");
        }
        notifyListeners();
      },
    );
  }

  /// **Set Filter Tanggal**
  void setFilterDate(DateTime? date) {
    selectedDate = date;

    if (selectedDate != null) {
      // Format selectedDate ke format "yyyy-MM-dd"
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

      // Filter history berdasarkan dateMeet yang sesuai dengan formattedDate
      filteredHistoryList = historyMeetList
          ?.where((meet) => meet.dateMeet == formattedDate)
          .toList() ?? [];

    } else {
      // Jika tidak ada tanggal yang dipilih, tampilkan semua data
      filteredHistoryList = historyMeetList ?? [];
    }

    // Memastikan UI terupdate
    notifyListeners();
  }
}


class ZegoConfig {
  static const int appId = 887326473; //changes with your apiID
  static const String appSign =
      '26b1a545fe82993620a91ec109b8ae22e4bcc4ab9ea5459069f37523a97ae270'; //changes with your appSign
}