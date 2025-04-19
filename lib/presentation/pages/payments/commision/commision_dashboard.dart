import 'dart:async';
import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_promotion.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/pages/payments/commision/popup.dart';
import 'package:coolappflutter/presentation/pages/payments/commision/withdrawal_commision.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/apps/app_sizes.dart';

class CommisionDashboard extends StatefulWidget {
  const CommisionDashboard({super.key});

  @override
  State<CommisionDashboard> createState() => _CommisionDashboardState();
}

class _CommisionDashboardState extends State<CommisionDashboard> {
  String selectedCategory = "all";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPromoDialog();
      context.read<PromotionProvider>().fetchListPromotion();
    });
  }

  Future<void> _refreshData() async {
    await context.read<PromotionProvider>().fetchListPromotion();
  }

  void _showPromoDialog() async {
    await Future.delayed(Duration(seconds: 2));
    var cek = await PreferenceHandler.retrieveCekDialogKonsultan();
    if (cek.toString() != "1") {
      if (!mounted) return; // pastikan context masih valid
      showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(child: PopupCommision()),
      );
      await PreferenceHandler.storingCekDialogKonsultan("1");
    }
  }

  void _showMinWdDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Minimum Withdrawal"),
          content: Text(S.of(context).minimumWdCommision +
              "(${formatMinimumWd(dataGlobal.dataPromotion?.minimumWd ?? "IDR 0")})"),
          actions: [
            GlobalButton(
                onPressed: () {
                  Nav.back();
                },
                color: primaryColor,
                text: S.of(context).I_Understand)
          ],
        );
      },
    );
  }

  String formatMinimumWd(String raw) {
    try {
      raw = raw.trim();
      if (!raw.startsWith("IDR ")) return raw;
      String valueOnly = raw.replaceFirst("IDR ", "").split(",")[0];
      final number = int.parse(valueOnly.replaceAll(".", ""));
      final formatter =
          NumberFormat.currency(locale: 'id', symbol: 'IDR ', decimalDigits: 0);
      return formatter.format(number);
    } catch (e) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterdata = dataGlobal.dataPromotion?.data ?? [];
    final filteredData = filterdata.where((item) {
      if (selectedCategory == "all") return true; // Tampilkan semua data
      return item.category?.toLowerCase() == selectedCategory.toLowerCase();
    }).toList();
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Commision',
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.white), // Ikon tombol kembali
            onPressed: () {
              Nav.toAll(
                  NavMenuScreen()); // Aksi untuk kembali ke halaman sebelumnya
            },
          ),
        ),
        body: Consumer<PromotionProvider>(builder: (context, promoProvider, _) {
          return promoProvider.isLoadingPromotion
              ? Column(
                  children: [
                    gapH32,
                    shimmerContainer(height: 250, width: double.infinity),
                    gapH20,
                    gapH32,
                    Expanded(
                        child: shimmerContainer(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity)),
                  ],
                )
              : RefreshIndicator(
                  onRefresh: _refreshData,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFEFDCD),
                          primaryColor,
                        ],
                        stops: [0.01, 0.3],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 0, right: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFEFDCD),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 15,
                                              bottom: 8,
                                              top: 8),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                AppAsset.icRealMoney,
                                              ),
                                              gapW10,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'My Commision',
                                                    style: TextStyle(
                                                      color: DarkYellow,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${(dataGlobal.dataPromotion?.totalComission == null || dataGlobal.dataPromotion?.totalComission.toString().isEmpty == true) ? '0' : dataGlobal.dataPromotion?.totalComission.toString()}",
                                                    style: TextStyle(
                                                      color: DarkYellow,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: IntrinsicHeight(
                                                    child: _popup(),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.qr_code,
                                            color: primaryColor,
                                            size: 50,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    S.of(context).minimumWdCommision +
                                        "(${formatMinimumWd(dataGlobal.dataPromotion?.minimumWd ?? "IDR 0")})",
                                    style: TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 12),
                                  GlobalButton(
                                    onPressed: () {
                                      if (dataGlobal.dataPromotion?.isWd ==
                                          false) {
                                        _showMinWdDialog();
                                        print(dataGlobal
                                            .dataPromotion?.totalComission
                                            .toString());
                                      } else {
                                        Nav.to(WithdrawalCommision());
                                      }
                                    },
                                    color: primaryColor,
                                    text: S.of(context).withdraw,
                                  ),
                                  _buildUrlBox(dataGlobal.dataPromotion?.codeReferal.toString() ?? ""),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Image.asset('images/toplist.png'),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).history,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    DropdownButton(
                                      value: selectedCategory,
                                      items: [
                                        DropdownMenuItem(
                                            child: Text(S.of(context).all),
                                            value: "all"),
                                        DropdownMenuItem(
                                            child: Text(S.of(context).income),
                                            value: "income"),
                                        DropdownMenuItem(
                                            child: Text(S.of(context).withdraw),
                                            value: "withdrawl"),
                                      ],
                                      onChanged: (value) {
                                        if (value != null) {
                                          setState(() {
                                            selectedCategory = value;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // List History
                                Expanded(
                                  child: filteredData.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: filteredData.length,
                                          itemBuilder: (context, index) {
                                            final item = filteredData[index];
                                            return Card(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: ListTile(
                                                title: Text(
                                                  "${item.comissionAmount}",
                                                  style: const TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: Text(
                                                    "${item.profiling}\n${item.nameMember}"),
                                                trailing: Text(item.date ?? ""),
                                              ),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Text(S.of(context).no_data)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }));
  }

  Widget _buildUrlBox(String? code) {
    String url = code ?? "";

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              url,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            child: Image.asset("images/qrcode/sharee.png"),
            onTap: () {
              Share.share(url);
            },
          ),
          gapW4,
          GestureDetector(
            child: Image.asset("images/qrcode/copyy.png"),
            onTap: () {
              Clipboard.setData(ClipboardData(text: url));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).copy)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _popup() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gapH32,
            SvgPicture.network(
              "${ApiEndpoint.qrPromotion}",
              headers: {'Authorization': dataGlobal.token},
              width: 200,
              height: 200,
              placeholderBuilder: (context) {
                return const SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressWidget(),
                );
              },
            ),
            gapH10,
            _buildUrlBox(dataGlobal.dataPromotion?.referalLink.toString() ?? "")
          ],
        ),
      ),
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
