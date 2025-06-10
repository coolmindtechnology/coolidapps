import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Report/ChatBoxReport.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class DetailReportLog extends StatefulWidget {
  final String ReportId;

  const DetailReportLog({super.key, required this.ReportId});

  @override
  _DetailReportLogState createState() => _DetailReportLogState();
}

class _DetailReportLogState extends State<DetailReportLog> {
  String versionNumber = '';

  @override
  void initState() {
    super.initState();
    _loadNotificationDetail();
  }

  Future<void> _loadNotificationDetail() async {
    final provider = Provider.of<ProviderUser>(context, listen: false);
    await provider.getDetailLogReport(context, widget.ReportId);
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionNumber =
          packageInfo.version; // Set version setelah berhasil diambil
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderUser>(
      builder: (context, provider, child) {
        final isLoading = provider.isLoadingDetailLog;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              S.of(context).detailLogError,
              // "Notification Detail",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.isLoadingDetailLog == true
                  ? Center(child: Text(S.of(context).no_data))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            containercostume(
                                Colors.grey,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          provider.detailLogReportData?.data
                                                  ?.categoryReports?.name ??
                                              "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Spacer(),
                                        Text(
                                          DateFormat('dd MM yyyy').format(
                                              DateTime.parse(provider
                                                      .detailLogReportData
                                                      ?.data
                                                      ?.updatedAt
                                                      ?.toString() ??
                                                  "")),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    gapH10,
                                    statusRow(
                                        S.of(context).status,
                                        provider.detailLogReportData!.data!
                                                .status
                                                .toString() ??
                                            ""),
                                    statusRow(
                                        S.of(context).gambar,
                                        provider.detailLogReportData!.data!
                                                    .media !=
                                                null
                                            ? S.of(context).ada
                                            : S.of(context).tidakAda),
                                    statusRow(
                                        S.of(context).versiAplikasi,
                                        provider.detailLogReportData?.data
                                                ?.appVersion
                                                ?.toString() ??
                                            S.of(context).tidakTersedia),
                                  ],
                                )),
                            const SizedBox(height: 20),
                            containercostume(
                                Colors.grey,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(S.of(context).Supporting_Documents,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    gapH10,
                                    provider!.detailLogReportData!.data!
                                                .media ==
                                            null
                                        ? Text(S
                                            .of(context)
                                            .assetNotAvailable) // Tampilkan teks jika media null atau kosong
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              provider!.detailLogReportData!
                                                  .data!.media
                                                  .toString(),
                                              fit: BoxFit
                                                  .cover, // Opsional, tergantung layout
                                            ),
                                          )
                                  ],
                                )),
                            const SizedBox(height: 20),
                            containercostume(
                                Colors.grey,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).ceritaAnda,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    gapH10,
                                    containercostume(
                                        Colors.grey,
                                        Text(provider.detailLogReportData?.data
                                                ?.body ??
                                            ""))
                                  ],
                                )),
                            const SizedBox(height: 20),
                            if (provider.detailLogReportData?.data?.detailReport
                                    ?.description?.isNotEmpty ??
                                false)
                              containercostume(
                                  Colors.green,
                                  backgroundcolor: Color(0xFFCCFBD3),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).responseDariCool,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      gapH10,
                                      containercostume(
                                        Colors.green,
                                        backgroundcolor: Color(0xFFCCFBD3),
                                        Text(provider.detailLogReportData?.data
                                                ?.detailReport?.description ??
                                            ""),
                                      )
                                    ],
                                  )),
                            gapH32,
                            containercostume(
                              Colors.grey,
                              Center(
                                child: versionNumber.isEmpty
                                    ? CircularProgressIndicator() // Tampilkan loading jika versi belum didapat
                                    : Text(S.of(context).versiAplikasi +
                                        '$versionNumber'), // Tampilkan versi aplikasi
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
          bottomNavigationBar: isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.detailLogReportData?.data?.status !=
                  "Closed"
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: provider.isLoadingCloseMassage
                      ? GlobalButton(
                    onPressed: () async {},
                    color: greyColor,
                    text: S.of(context).tutup_laporan,
                    textStyle: TextStyle(color: Colors.white),
                  )
                      : GlobalButton(
                    onPressed: () async {
                      await provider.closeMassageReportProvider(
                          context,
                          provider.detailLogReportData?.data?.id
                              .toString() ??
                              "0");
                    },
                    color: Colors.white,
                    text: S.of(context).tutup_laporan,
                    textStyle: TextStyle(color: Colors.red),
                  ),
                ),
                gapW10,
                Expanded(
                  child: provider.isLoadingCloseMassage
                      ? GlobalButton(
                    onPressed: () async {},
                    color: greyColor,
                    text: S.of(context).balas,
                    textStyle: TextStyle(color: Colors.white),
                  )
                      : GlobalButton(
                    onPressed: () {
                      Nav.to(ChatBoxReport(
                        name: provider.detailLogReportData?.data
                            ?.categoryReports?.name ??
                            "",
                        status: provider.detailLogReportData?.data?.status
                            .toString(),
                        body: provider.detailLogReportData?.data?.body
                            .toString(),
                        appVersion: provider
                            .detailLogReportData?.data?.appVersion
                            .toString(),
                        media: provider.detailLogReportData?.data?.media
                            .toString(),
                        tanggal: DateFormat('dd MM yyyy').format(
                            DateTime.parse(provider
                                .detailLogReportData?.data?.updatedAt
                                ?.toString() ??
                                "")),
                        id_log:   provider.detailLogReportData?.data?.id
                            .toString() ??
                            "0",
                      ));
                    },
                    color: primaryColor,
                    text:  S.of(context).balas,
                  ),
                )
              ],
            ),
          ) : SizedBox(),
        );
      },
    );
  }

  Widget containercostume(Color colosborder, Widget child,
      {Color? backgroundcolor}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colosborder)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
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
}
