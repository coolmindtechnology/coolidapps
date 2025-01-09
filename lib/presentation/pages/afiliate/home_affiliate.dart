// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:clipboard/clipboard.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/components/term_conditions_affiliasi.dart';
import 'package:coolappflutter/presentation/pages/afiliate/screen_total_member.dart';
import 'package:coolappflutter/presentation/pages/afiliate/term_dialog.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../data/data_global.dart';
import '../../../data/networks/endpoint/api_endpoint.dart';
import '../../widgets/refresh_icon_widget.dart';

class HomeAffiliate extends StatefulWidget {
  final Function(int)? klickTabAffiliate;
  const HomeAffiliate({super.key, this.klickTabAffiliate});

  @override
  State<HomeAffiliate> createState() => _HomeAffiliateState();
}

class _HomeAffiliateState extends State<HomeAffiliate> {
  bool isQr = false, isShare = false;
  int minSaldo = 250000;
  List<bool> tappedStates = List.filled(4, false);
  initHome() async {
    await context.read<ProviderAffiliate>().getHomeAff(context);
  }

  String imageUrl = '${ApiEndpoint.getMyAffiliateQR}?size=300&margin=10';
  String token = dataGlobal.token;

  Future<void> _refreshImage() async {
    // Simulate network fetch delay
    // await Future.delayed(Duration(seconds: 2));

    // Refresh the image by updating the state
    setState(() {
      imageUrl =
          '${ApiEndpoint.getMyAffiliateQR}?size=300&margin=10&timestamp=${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  @override
  void initState() {
    debugPrint("tes cek vacum home");
    // Timer(const Duration(seconds: 2), () {
    //   handleDeepLink();
    // });

    Future.microtask(() {
      initHome();
    });
    super.initState();
  }

  logicAffiliate5() {
    Timer(const Duration(seconds: 1), () {
      Nav.back();
    });
  }
  // Future<void> handleDeepLink() async {
  //   // Contoh: jika deeplink URL mengarah ke "/mobile"
  //   PermissionStatus status = await Permission.location.request();

  //   if (status.isDenied) {
  //     showSettingsDialog();
  //   } else if (status.isPermanentlyDenied) {
  //     // Jika izin ditolak permanen, arahkan ke halaman pengaturan
  //     // openAppSettingss();
  //   }
  // }

  // void showSettingsDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Pengaturan Diperlukan"),
  //         content: const Text(
  //             "Untuk mengakses fitur deeplink, silakan izinkan akses Set as default lalu berikan izin pada supported web addresses."),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text("OK"),
  //             onPressed: () {
  //               openAppSettingss();
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void openAppSettingss() {
  //   const AndroidIntent intent = AndroidIntent(
  //     action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
  //     data: 'package:mycool.tech.com', // Sesuaikan dengan package aplikasi kamu
  //   );
  //   intent.launch().catchError((error) {
  //     print("Error membuka pengaturan aplikasi: $error");
  //   });
  // }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAffiliate>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              S.of(context).affiliate,
              style: TextStyle(color: whiteColor),
            ),
            backgroundColor: primaryColor,
          ),
          body: value.isLoading == false
              ? CustomMaterialIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () {
                    _refreshImage();
                    Provider.of<ProviderAffiliate>(context, listen: false)
                        .getHomeAff(context);
                    return Future<void>.delayed(const Duration(seconds: 1));
                  },
                  indicatorBuilder:
                      (BuildContext context, IndicatorController controller) {
                    return const RefreshIconWidget();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    TermsDialog(token: token));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Syarat dan ketentuan Program Affiliasi",
                                  style: TextStyle(color: greyColor),
                                ),
                                Icon(Icons.info_outline_rounded,
                                    color: greyColor)
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            "Overview",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (index == 0) {
                                      widget.klickTabAffiliate!(0);
                                    } else if (index == 1) {
                                      Nav.to(const ScreenTotalMember());
                                    } else if (index == 2) {
                                      widget.klickTabAffiliate!(1);
                                    }
                                  },
                                  child: Listener(
                                    onPointerDown: (event) => setState(() {
                                      tappedStates[index] = true;
                                    }),
                                    onPointerUp: (event) => setState(() {
                                      tappedStates[index] = false;
                                    }),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.all(8),
                                      width: 152,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: tappedStates[index]
                                              ? primaryColor
                                              : whiteColor),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            index == 0
                                                ? S.of(context).total_balance
                                                : index == 1
                                                    ? S.of(context).total_member
                                                    : index == 2
                                                        ? S
                                                            .of(context)
                                                            .total_real_money
                                                        : "Total Point",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: tappedStates[index]
                                                  ? whiteColor
                                                  : greyColor,
                                            ),
                                          ),
                                          Text(
                                            index == 0
                                                ? "${MoneyFormatter.formatMoney(value.dataAffiliasi?.totalSaldoAffiliate == "" ? "0" : value.dataAffiliasi?.totalSaldoAffiliate, true)}"
                                                : index == 1
                                                    ? "${value.dataAffiliasi?.totalMember == "" ? "0" : value.dataAffiliasi?.totalMember}"
                                                    : index == 2
                                                        ? "${MoneyFormatter.formatMoney(value.dataAffiliasi?.totalRealMoney == "" ? "0" : value.dataAffiliasi?.totalRealMoney, true)}"
                                                        : "${value.dataAffiliasi?.totalPoint.toString()}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: tappedStates[index]
                                                    ? whiteColor
                                                    : primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        if ((value.dataAffiliasi?.totalSaldoAffiliate
                                    ?.isNotEmpty ??
                                false) ||
                            (value.dataAffiliasi?.totalSaldoAffiliate
                                    ?.isEmpty ??
                                false)) ...[
                          if ((value.dataAffiliasi?.totalSaldoAffiliate
                                      ?.isEmpty ??
                                  false) ||
                              (int.parse(value
                                          .dataAffiliasi?.totalSaldoAffiliate
                                          .toString() ??
                                      "0") <=
                                  minSaldo)) ...[
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffFFF3cd),
                                border: Border.all(
                                    color: const Color(0x00ffeeba), width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Icon(Icons.warning_outlined,
                                      color: Color(0xFF856404)),
                                  const SizedBox(width: 8),
                                  Text(
                                    S.of(context).topup_first,
                                    style: const TextStyle(
                                        color: Color(0xFF856404)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                        if (value.resCheckTopupAffiliate?.data?.notif == 5)
                          logicAffiliate5(),
                        if (value.resCheckTopupAffiliate?.data?.notif == 2) ...[
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffFFF3cd),
                                border: Border.all(
                                    color: const Color(0x00ffeeba), width: 1.0),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.warning_outlined,
                                        color: Color(0xFF856404)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.resCheckTopupAffiliate
                                                    ?.message ??
                                                "",
                                            style: const TextStyle(
                                                color: Color(0xFF856404)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    value.resCheckTopupAffiliate = null;
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: const Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.close_rounded,
                                      size: 20,
                                      color: Color(0xFF856404),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (value.dataAffiliasi?.totalSaldoAffiliate
                                ?.contains("-") ==
                            true) ...[
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffFFF3cd),
                                border: Border.all(
                                    color: const Color(0x00ffeeba), width: 1.0),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListTileTheme(
                              contentPadding: EdgeInsets
                                  .zero, // this also removes horizontal padding
                              minVerticalPadding: 0.0,
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.zero,
                                childrenPadding: EdgeInsets.zero,
                                trailing: const Icon(
                                  Icons.info_outline_rounded,
                                  color: Color(
                                    0xFF856404,
                                  ),
                                ),
                                title: Text(
                                  S.of(context).what_is_negative_balance,
                                  style: const TextStyle(
                                      color: Color(
                                        0xFF856404,
                                      ),
                                      fontSize: 14),
                                ),
                                collapsedShape: const RoundedRectangleBorder(
                                  side: BorderSide.none,
                                ),
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide.none,
                                ),
                                children: <Widget>[
                                  ListTile(
                                      title: Text(
                                    S.of(context).negative_balance_description,
                                    style: const TextStyle(
                                        color: Color(0xFF856404), fontSize: 14),
                                  )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Divider(
                            color: greyColor.withOpacity(0.1),
                            thickness: 4,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            S.of(context).referral,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: greyColor.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).qr_code,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isQr = !isQr;
                                        });
                                      },
                                      child: Icon(
                                        isQr == false
                                            ? Icons.arrow_forward_ios
                                            : Icons.arrow_forward,
                                        color: greyColor,
                                      ),
                                    )
                                  ],
                                ),
                                isQr == true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24),
                                        child: Divider(
                                          color: greyColor.withOpacity(0.1),
                                          thickness: 1,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                                // isQr == true
                                //     ?

                                Center(
                                  child: Image.network(
                                    imageUrl,
                                    headers: {'Authorization': token},
                                    width: 200,
                                    height: 200,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressWidget(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, exception, stackTrace) {
                                      return Center(
                                          child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/icons/material-symbols-light_error-outline.png",
                                            width: 100,
                                          ),
                                          Text(
                                            S.of(context).failed_load_qr_code,
                                          ),
                                        ],
                                      ));
                                    },
                                    // placeholderBuilder: (context) {
                                    //   return const Center(
                                    //     child: SizedBox(
                                    //       height: 200,
                                    //       width: 200,
                                    //       child: CircularProgressWidget(),
                                    //     ),
                                    //   );
                                    // },
                                  ),
                                ),
                                // : const SizedBox(
                                //     height: 0,
                                //     width: 0,
                                //   ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${S.of(context).your_affiliate_code} : '),
                                    Text(
                                      '${value.dataAffiliasi?.referralCode}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          FlutterClipboard.copy(
                                            value.dataAffiliasi?.referralCode ??
                                                "",
                                          ).then(
                                            (value) {
                                              return ScaffoldMessenger.of(
                                                      context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(S
                                                      .of(context)
                                                      .referral_code_copied),
                                                  backgroundColor: primaryColor,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.copy))
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                // isQr == true
                                //     ?
                                Text(
                                  S.of(context).show_qr_code_to_affiliate,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                // : const SizedBox(
                                //     height: 0,
                                //     width: 0,
                                //   ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: greyColor.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).share_code,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isShare = !isShare;
                                        });
                                      },
                                      child: Icon(
                                        isShare == false
                                            ? Icons.arrow_forward_ios
                                            : Icons.arrow_forward,
                                        color: greyColor,
                                      ),
                                    )
                                  ],
                                ),
                                // isShare == true
                                //     ?
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: Divider(
                                    color: greyColor.withOpacity(0.1),
                                    thickness: 1,
                                  ),
                                ),
                                // : const SizedBox(
                                //     height: 0,
                                //     width: 0,
                                //   ),
                                // isShare == true
                                //     ?
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 54,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: greyColor.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              value.dataAffiliasi
                                                      ?.linkRefferalCode ??
                                                  "",
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        color: primaryColor,
                                        textColor: whiteColor,
                                        onPressed: () {
                                          FlutterClipboard.copy(
                                            value.dataAffiliasi
                                                    ?.linkRefferalCode ??
                                                "",
                                          ).then(
                                            (value) {
                                              return ScaffoldMessenger.of(
                                                      context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(S
                                                      .of(context)
                                                      .referral_code_copied),
                                                  backgroundColor: primaryColor,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(S.of(context).copy),
                                      ),
                                    ],
                                  ),
                                ),
                                // : const SizedBox(
                                //     height: 0,
                                //     width: 0,
                                //   ),
                                const SizedBox(
                                  height: 8,
                                ),
                                isShare == true
                                    ? Text(
                                        S.of(context).share_link,
                                        style: const TextStyle(fontSize: 12),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: Colors.blue,
                ))),
    );
  }
}

class TermsAndConditions {
  final String data;

  TermsAndConditions({required this.data});

  factory TermsAndConditions.fromJson(Map<String, dynamic> json) {
    return TermsAndConditions(data: json['data']['data'] ?? '');
  }
}

class ApiService {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: "${ApiEndpoint.baseUrl}/api/terms-and-condition"));

  Future<TermsAndConditions> fetchTerms(String token) async {
    try {
      // dynamic dataLocale = await PreferenceHandler.retrieveIdLanguage();
      // debugPrint(" ${ApiEndpoint.baseUrl}/api/terms-and-condition");

      final response = await _dio.get(
        "${ApiEndpoint.baseUrl}/api/terms-and-condition",
        options:
            Options(headers: {'Authorization': 'Bearer ${dataGlobal.token}'}),
      );
      if (response.statusCode == 200) {
        return TermsAndConditions.fromJson(response.data);
      } else {
        throw Exception('Failed to load terms and conditions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

////brain term
class BrainTermsAndConditions {
  final String data;

  BrainTermsAndConditions({required this.data});

  factory BrainTermsAndConditions.fromJson(Map<String, dynamic> json) {
    return BrainTermsAndConditions(data: json['data']['data'] ?? '');
  }
}

class BarainApiService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "${ApiEndpoint.baseUrl}/api/terms-and-condition/brain"));

  Future<BrainTermsAndConditions> BrainPostfetchTerms(String token) async {
    try {
      // dynamic dataLocale = await PreferenceHandler.retrieveIdLanguage();
      // debugPrint(" ${ApiEndpoint.baseUrl}/api/terms-and-condition");

      final response = await _dio.get(
        "${ApiEndpoint.baseUrl}/api/terms-and-condition/brain",
        options:
            Options(headers: {'Authorization': 'Bearer ${dataGlobal.token}'}),
      );
      if (response.statusCode == 200) {
        return BrainTermsAndConditions.fromJson(response.data);
      } else {
        throw Exception('Failed to load terms and conditions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
