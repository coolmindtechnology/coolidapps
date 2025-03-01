// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/models/data_checkout_transaction.dart';

import 'package:coolappflutter/data/provider/provider_payment.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';

import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/main.dart';
import 'package:coolappflutter/presentation/pages/afiliate/on_board/onboard_aff1.dart';

import 'package:coolappflutter/presentation/pages/afiliate/screen_total_member.dart';
import 'package:coolappflutter/presentation/pages/ebook/ebook_dashboard.dart';

import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/terma_konsultan.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/home_ebook.dart';
import 'package:coolappflutter/presentation/pages/payments/realmoney_aff/detail_realmoney.dart';
import 'package:coolappflutter/presentation/pages/payments/saldo_aff/detai_saldo_aff.dart';
import 'package:coolappflutter/presentation/pages/profiling/profiling%20dashboard.dart';

import 'package:coolappflutter/presentation/pages/profiling/screen_feature_kepribadian.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_hasil_kepribadian.dart';

import 'package:coolappflutter/presentation/pages/transakction/transaksi_affiliate.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';

import 'package:coolappflutter/presentation/widgets/Container/Continer_profiling.dart';
import 'package:coolappflutter/presentation/widgets/Container/card_homekonsultant.dart';

import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/networks/endpoint/api_endpoint.dart';
import '../../../data/provider/provider_affiliate.dart';
import '../../theme/color_utils.dart';
import '../../utils/circular_progress_widget.dart';
import 'list_ebook_all.dart';

// ignore: must_be_immutable
class HomeKonsultant extends StatefulWidget {
  final Function(int) klickTab;
  const HomeKonsultant({super.key, required this.klickTab});

  @override
  State<HomeKonsultant> createState() => _HomeKonsultantState();
}

class _HomeKonsultantState extends State<HomeKonsultant> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  StreamSubscription? eventBalanceStream;
  TextEditingController codeReferralC = TextEditingController();
  List<bool> tappedStates = List.filled(3, false);

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

  initHome() async {
    await context.read<ProviderAffiliate>().getHomeAff(context);
    await context.read<ProviderProfiling>().getListProfiling(context);
    context.read<ProviderUser>().checkProfile(context);
    context.read<ProviderUser>().getTotalSaldo(context);
  }

  @override
  void dispose() {
    eventBalanceStream?.cancel();
    codeReferralC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderBook>(
      builder: (BuildContext context, value, Widget? child) =>
          Consumer<ProviderProfiling>(
        builder: (BuildContext context, valuePro, Widget? child) =>
            Consumer<ProviderAffiliate>(
          builder: (BuildContext context, valueAffiliate, Widget? child) =>
              Consumer<ProviderUser>(builder:
                  (BuildContext context, valueUser, Widget? child) {
            String? statusApproval =
                valueAffiliate.dataOverview?.statusApprovalConsultant;
            return Scaffold(
              backgroundColor: Colors.white,
              body: Consumer<ProviderPayment>(
                  builder: (BuildContext context, valueDep, Widget? child) {
                eventBalanceStream ??= eventBalance.listen(onChanges: () {
                  Provider.of<ProviderUser>(context, listen: false)
                      .getTotalSaldo(context);
                });
                // valueDep.getAmoutDeposit(context);
                return CustomMaterialIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () {
                    Provider.of<ProviderUser>(context, listen: false)
                        .getUser(context);
                    // Provider.of<ProviderBook>(context, listen: false)
                    //     .getListEbook(context);
                    Provider.of<ProviderAffiliate>(context, listen: false).getHomeAff(context);
                    // Provider.of<ProviderPayment>(context, listen: false)
                    //     .getAmoutDeposit(context);
                    Provider.of<ProviderUser>(context, listen: false)
                        .getTotalSaldo(context);
                    Provider.of<ProviderProfiling>(context, listen: false)
                        .getListProfiling(context);

                    Timer(const Duration(seconds: 1), () {
                      Provider.of<ProviderUser>(context, listen: false)
                          .getTotalSaldo(context);
                    });
                    return Future<void>.delayed(const Duration(seconds: 1));
                  },
                  indicatorBuilder: (BuildContext context,
                      IndicatorController controller) {
                    return const RefreshIconWidget();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          Colors.white,
                        ],
                        stops: [0.2, 0.5],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 40, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  AppAsset.imgNewCoolLogo,
                                  height: 40,
                                  width: 120,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.klickTab(3);
                                  },
                                  child: valueUser.isLoading
                                      ? Shimmer.fromColors(
                                          baseColor:
                                              greyColor.withOpacity(0.2),
                                          highlightColor: whiteColor,
                                          child: Container(
                                            height: 65,
                                            width: 65,
                                            decoration: BoxDecoration(
                                                color: greyColor,
                                                shape: BoxShape.circle),
                                          ))
                                      : valueUser.dataUser?.image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      100),
                                              child: Image.network(
                                                "${valueUser.dataUser?.image}",
                                                width: 65,
                                                height: 65,
                                                fit: BoxFit.fill,
                                                errorBuilder:
                                                    (BuildContext context,
                                                        Object exception,
                                                        StackTrace?
                                                            stackTrace) {
                                                  // Tampilkan gambar placeholder jika terjadi error
                                                  return Image.asset(
                                                    AppAsset
                                                        .imgDefaultProfile, // Path ke gambar placeholder lokal
                                                    width: 65,
                                                    height: 65,
                                                    fit: BoxFit.fill,
                                                  );
                                                },
                                                loadingBuilder: (context,
                                                    child,
                                                    loadingProgress) {
                                                  if (loadingProgress ==
                                                      null) {
                                                    return child;
                                                  }

                                                  return Shimmer.fromColors(
                                                      baseColor: greyColor
                                                          .withOpacity(0.2),
                                                      highlightColor:
                                                          whiteColor,
                                                      child: Container(
                                                        height: 56,
                                                        width: 56,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                greyColor,
                                                            shape: BoxShape
                                                                .circle),
                                                      ));
                                                },
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      100),
                                              child: Image.asset(
                                                AppAsset.imgDefaultProfile,
                                                width: 56,
                                                height: 56,
                                                color: whiteColor,
                                              ),
                                            ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                color: blueSlider,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Text di sebelah kiri
                                  Expanded(
                                    flex: 2, // Atur proporsi teks
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Text(
                                            S.of(context).Invite_Friends,
                                            style: TextStyle(
                                              color: BlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 40,
                                            width: 140,
                                            decoration: BoxDecoration(
                                                color: BlueColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15)),
                                            child: Center(
                                              child: Text(
                                                S.of(context).UndangTeman,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Gambar di sebelah kanan
                                  Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(20),
                                      child: Image.asset(
                                        AppAsset.imgKonsultanHome,
                                        fit: BoxFit.cover,
                                        height: 170,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              S.of(context).Welcome_Affiliator,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              S.of(context).Invite_Friends_Rewards,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            valueAffiliate.isLoading
                                ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                                : Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: LightBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).Cool_Points,
                                      style: TextStyle(
                                          color: BlueColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "${(valueAffiliate.dataOverview?.totalPoint == null || valueAffiliate.dataOverview?.totalPoint == '') ? '0' : valueAffiliate.dataOverview?.totalPoint}"
                                          " " +
                                          S.of(context).Total_Point,
                                      style: TextStyle(
                                          color: BlueColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            if (valueAffiliate.isLoading)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CardHomeKonsultant(
                                    title: S.of(context).Read_Ebook,
                                    subtitle:
                                    "${(valueAffiliate.dataOverview?.totalEbook == null || valueAffiliate.dataOverview?.totalEbook == '') ? '0' : valueAffiliate.dataOverview?.totalEbook} ${S.of(context).ebook}",
                                    imageAsset: AppAsset.icEbook,
                                    containerColor: Color(0xFFF9D904),
                                    onTap: () {
                                      Nav.to(const HomeEbook());
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  CardHomeKonsultant(
                                    title: S.of(context).Total_Members,
                                    titleColor: Colors.white,
                                    subtitleColor: Colors.white,
                                    subtitle:
                                    "${(valueAffiliate.dataOverview?.totalMember == null || valueAffiliate.dataOverview?.totalMember == '') ? '0' : valueAffiliate.dataOverview?.totalMember} ${S.of(context).Member}",
                                    imageAsset: AppAsset.icMember,
                                    containerColor: Color(0xFF4CCBF4),
                                    onTap: () {
                                      Nav.to(const ScreenTotalMember());
                                    },
                                  ),
                                ],
                              ),

                            SizedBox(
                              height: 10,
                            ),
                            if (valueAffiliate.isLoading) // Jika sedang memuat data
                              Column(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 60, // Sesuaikan tinggi dengan aslinya
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 15,
                                                  color: Colors.white, // Placeholder shimmer untuk teks pertama
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                  width: 80,
                                                  height: 15,
                                                  color: Colors.white, // Placeholder shimmer untuk teks kedua
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              color: Colors.white, // Placeholder shimmer untuk icon
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10), // Spasi antara dua shimmer box
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 60, // Sesuaikan tinggi dengan aslinya
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 15,
                                                  color: Colors.white, // Placeholder shimmer untuk teks pertama
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                  width: 80,
                                                  height: 15,
                                                  color: Colors.white, // Placeholder shimmer untuk teks kedua
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              color: Colors.white, // Placeholder shimmer untuk icon
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Nav.to(DetailSaldoAff());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: LightBlue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  S.of(context).Your_Balance,
                                                  style: TextStyle(
                                                    color: BlueColor,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                Text(
                                                  'Rp ${(valueAffiliate.dataOverview?.totalSaldoAffiliate == null || valueAffiliate.dataOverview?.totalSaldoAffiliate == '') ? '0' : valueAffiliate.dataOverview?.totalSaldoAffiliate}',
                                                  style: TextStyle(
                                                    color: BlueColor,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Image.asset(AppAsset.icDompet),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      Nav.to(DetailRealMoneyAff());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEFDCD),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  S.of(context).Real_Money,
                                                  style: TextStyle(
                                                    color: DarkYellow,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                Text(
                                                  'Rp ${(valueAffiliate.dataOverview?.totalRealMoney == null || valueAffiliate.dataOverview?.totalRealMoney == '') ? '0' : valueAffiliate.dataOverview?.totalRealMoney}',
                                                  style: TextStyle(
                                                    color: DarkYellow,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Image.asset(AppAsset.icRealMoney),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            SizedBox(
                              height: 10,
                            ),
                            if(valuePro.listProfiling.isNotEmpty)
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).My_Profiling,
                                  style: TextStyle(
                                      color: BlueColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      Nav.to(
                                          const ProfilingDashboard());
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).see_all,
                                          style: TextStyle(
                                              color: BlueColor,
                                              fontSize: 18),
                                        ),
                                        Icon(
                                          CupertinoIcons.forward,
                                          color: BlueColor,
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            if(valuePro.listProfiling.isNotEmpty)
                            SizedBox(
                              height: 100, // Sesuaikan tinggi widget
                              child: Row(
                                children: [
                                  if (valuePro.isLoading) // Jika sedang memuat data
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal, // ListView horizontal
                                        itemCount: 3, // Jumlah shimmer box yang ditampilkan
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  else if (valuePro.listProfiling
                                      .isNotEmpty) // Jika data tersedia
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis
                                            .horizontal, // ListView horizontal
                                        itemCount:
                                            valuePro.listProfiling.length,
                                        itemBuilder: (context, index) {
                                          DataProfiling data =
                                              valuePro.listProfiling[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (data.status.toString() ==
                                                    "0") {
                                                  NotificationUtils
                                                      .showSimpleDialog2(
                                                      context,
                                                      S
                                                          .of(context)
                                                          .pay_to_see_more,
                                                      textButton1: S
                                                          .of(context)
                                                          .yes_continue,
                                                      textButton2:
                                                      S.of(context).no,
                                                      onPress2: () {
                                                        Nav.back();
                                                      }, onPress1: () async {
                                                    Nav.back();
                                                    await NotificationUtils
                                                        .showSimpleDialog2(
                                                        context,
                                                        S
                                                            .of(context)
                                                            .pay_with_your_cool_balance,
                                                        textButton1: S
                                                            .of(context)
                                                            .yes_continue,
                                                        textButton2: S
                                                            .of(context)
                                                            .other_pay,
                                                        onPress2: () async {
                                                          Nav.back();
                                                          await valuePro.payProfiling(
                                                              context,
                                                              [
                                                                int.tryParse(data
                                                                    .idLogResult
                                                                    .toString() ??
                                                                    "0") ??
                                                                    0
                                                              ],
                                                              "0",
                                                              "transaction_type",
                                                              1,
                                                              onUpdate: () async {
                                                                await valuePro
                                                                    .getListProfiling(
                                                                    context);
                                                              }, fromPage: "profiling");
                                                        }, onPress1: () async {
                                                      Nav.back();
                                                      await valuePro
                                                          .createTransactionProfiling(
                                                          context,
                                                          DataCheckoutTransaction(
                                                              idLogs: [
                                                                int.parse(data
                                                                    .idLogResult
                                                                    .toString() ??
                                                                    "0")
                                                              ],
                                                              discount: "0",
                                                              idItemPayments:
                                                              "1",
                                                              qty: 1,
                                                              gateway:
                                                              "paypal"),
                                                              () async {
                                                            await valuePro
                                                                .getListProfiling(
                                                                context);
                                                          });
                                                    },
                                                        colorButon1:
                                                        primaryColor,
                                                        colorButton2:
                                                        Colors.white);
                                                  },
                                                      colorButon1:
                                                      primaryColor,
                                                      colorButton2:
                                                      Colors.white);
                                                } else {

                                                  // Nav.to(DetailProfiling(
                                                  //     data: data));
                                                  Nav.to(ScreenHasilKepribadian(
                                                      data: data));
                                                }
                                              },
                                              onDoubleTap: () {
                                                if (data.status.toString() ==
                                                    "0") {
                                                  NotificationUtils
                                                      .showSimpleDialog2(
                                                      context,
                                                      S
                                                          .of(context)
                                                          .pay_to_see_more,
                                                      textButton1: S
                                                          .of(context)
                                                          .yes_continue,
                                                      textButton2:
                                                      S.of(context).no,
                                                      onPress2: () {
                                                        Nav.back();
                                                      }, onPress1: () async {
                                                    Nav.back();
                                                    await NotificationUtils
                                                        .showSimpleDialog2(
                                                        context,
                                                        S
                                                            .of(context)
                                                            .pay_with_your_cool_balance,
                                                        textButton1: S
                                                            .of(context)
                                                            .yes_continue,
                                                        textButton2: S
                                                            .of(context)
                                                            .other,
                                                        onPress2: () async {
                                                          await valuePro.payProfiling(
                                                            context,
                                                            [
                                                              int.tryParse(data
                                                                  .idLogResult
                                                                  .toString() ??
                                                                  "0") ??
                                                                  0
                                                            ],
                                                            "0",
                                                            "transaction_type",
                                                            1,
                                                            onUpdate: () async {
                                                              await valuePro
                                                                  .getListProfiling(
                                                                  context);
                                                            },
                                                            fromPage: "profiling",
                                                          );
                                                        }, onPress1: () async {
                                                      Nav.back();
                                                      await valuePro
                                                          .createTransactionProfiling(
                                                          context,
                                                          DataCheckoutTransaction(
                                                            idLogs: [
                                                              int.parse(data
                                                                  .idLogResult
                                                                  .toString() ??
                                                                  "0")
                                                            ],
                                                            discount: "0",
                                                            idItemPayments:
                                                            "1",
                                                            qty: 1,
                                                          ), () async {
                                                        await valuePro
                                                            .getListProfiling(
                                                            context);
                                                      });
                                                    },
                                                        colorButon1:
                                                        primaryColor,
                                                        colorButton2:
                                                        Colors.white);
                                                  },
                                                      colorButon1:
                                                      primaryColor,
                                                      colorButton2:
                                                      Colors.white);
                                                } else {
                                                  Nav.to(ScreenHasilKepribadian(
                                                      data: data));
                                                }
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: BlueColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        data.typeBrain ??
                                                            S
                                                                .of(context)
                                                                .no_data,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            data.profilingName ??
                                                                "Data tidak ditemukan",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Icon(
                                                            CupertinoIcons
                                                                .heart_fill,
                                                            color:
                                                                Colors.white,
                                                            size: 18,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  else // Jika tidak ada data dan tidak sedang memuat
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          S.of(context).no_data,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ContainerProfiling(
                                    isCenter: true,
                                    height: 75,
                                    leading: Image.asset(
                                      AppAsset.icShare,
                                    ),
                                    backgroundColor: Color(0xFF01327B),
                                    borderColor: Color(0xFF01327B),
                                    title: S.of(context).Share_Link,
                                    textColor: Colors.white,
                                    useGradient: false,
                                    onTap: () {
                                      _showReferralPopup(
                                          context,
                                          valueAffiliate.dataOverview
                                                  ?.linkRefferalCode ??
                                              "kesalahann teknis harap coba lagi");
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  if (statusApproval == "approve")
                                    ContainerProfiling(
                                      height: 75,
                                      leading: Image.asset(
                                        AppAsset.icKonsult,
                                      ),
                                      backgroundColor: Color(0xFF01327B),
                                      borderColor: Color(0xFF01327B),
                                      title: S.of(context).Consultation,
                                      textColor: Colors.white,
                                      useGradient: false,
                                      onTap: () async {
                                        await context
                                            .read<ProviderAffiliate>()
                                            .checkConsultantStatus(context);
                                      },
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                Nav.to(
                                    // OnboardAff1()
                                    TermaKonsultant(
                                  isCheck: false,
                                ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(AppAsset.icMark),
                                  Text(S.of(context).Terms_and_Conditions)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }

  void _showReferralPopup(BuildContext context, String linkReferralCode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(S.of(context).yourReferralCode),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                linkReferralCode,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                maxLines: 5,
              ),
            ),
            gapH20,
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: linkReferralCode))
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).referralLinkCopied)),
                  );
                });
              },
              icon: const Icon(Icons.copy, color: Colors.white), // Warna ikon
              label: Text(
                S.of(context).copy,
                style: TextStyle(color: Colors.white), // Warna teks
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: BlueColor, // Warna latar belakang tombol
                foregroundColor: Colors.white, // Warna teks dan ikon
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8), // Membuat sudut tombol melengkung
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 16), // Padding tombol
                elevation: 5, // Efek bayangan tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}
