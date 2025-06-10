import 'dart:async';

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Report/DetailReport.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Report/Report_Page.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../data/locals/shared_pref.dart';

class LogLaporanPage extends StatefulWidget {
  const LogLaporanPage({Key? key}) : super(key: key);

  @override
  State<LogLaporanPage> createState() => _LogLaporanPageState();
}

class _LogLaporanPageState extends State<LogLaporanPage> {
  initLoad() async {
    await context.read<ProviderUser>().getLogReport(context);
  }

  @override
  void initState() {
    initLoad();
    cekSession();
    super.initState();
  }

  Future<void> _refreshData() async {
    await context.read<ProviderUser>().getLogReport(context);
    setState(() {});
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
    return Consumer<ProviderUser>(
      builder: (context, provider, child) {
        final isLoading = provider.isLoadingLogReport;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Nav.to(NavMenuScreen());
                },
                icon: Icon(Icons.arrow_back)),
            centerTitle: false,
            title: Text(
              S.of(context).logLaporan,
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Column(
                    children: [
                      shimmerButton(),
                      gapH10,
                      shimmerButton(),
                      gapH10,
                      shimmerButton(),
                    ],
                  )
                : RefreshIndicator(
                    onRefresh: _refreshData,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: provider.logReportData?.data?.length ??
                                0, // jumlah dummy
                            itemBuilder: (context, index) {
                              final item = provider.logReportData!.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  color: _getColorForContainer(
                                      item?.status.toString() ?? ""),
                                  child: InkWell(
                                    onTap: () {
                                      Nav.to(DetailReportLog(
                                          ReportId: item.id.toString()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16.0,
                                          top: 10,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                item.categoryReports?.name ??
                                                    "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                              Spacer(),
                                              Text(
                                                DateFormat('dd MM yyyy').format(
                                                    DateTime.parse(item
                                                        .updatedAt
                                                        .toString())),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          gapH10,
                                          statusRow(S.of(context).status,
                                              item?.status.toString() ?? ""),
                                          statusRow(
                                              S.of(context).gambar,
                                              item?.media != null
                                                  ? S.of(context).ada
                                                  : S.of(context).tidakAda),
                                          statusRow(
                                              S.of(context).versiAplikasi,
                                              item?.appVersion?.toString() ??
                                                  S.of(context).tidakTersedia),
                                          SizedBox(height: 8),
                                          Text(
                                            item.body.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                          gapH10,
                                          Divider()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: GlobalButton(
                onPressed: () {
                  Nav.to(ReportPage());
                },
                color: primaryColor,
                text: S.of(context).kirimLaporanBaru),
          ),
        );
      },
    );
  }

  Widget statusRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForContainer(String type) {
    switch (type) {
      case 'On Progress':
        return Color(0xFFFCE4D0);
      case 'Done':
        return Color(0xFFCCFBD3);
      case 'Sent To Admin':
        return Colors.white;
      case 'Closed':
        return Colors.red.shade100;
      default:
        return Colors.white; // Warna default jika type tidak cocok
    }
  }

  Widget shimmerButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
