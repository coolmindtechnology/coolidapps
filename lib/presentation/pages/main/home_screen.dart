// // ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
import 'package:coolappflutter/data/provider/provider_auth_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/data/provider/provider_payment.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/main.dart';
import 'package:coolappflutter/presentation/pages/main/components/input_code_ref_profilling.dart';
import 'package:coolappflutter/presentation/pages/main/detail_saldo/detail_saldo.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/home_ebook.dart';
import 'package:coolappflutter/presentation/pages/payments/commision/commision_dashboard.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_hasil_kepribadian.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_hasil_kepribadian_dibawah17.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/provider/provider_affiliate.dart';
import '../../on_boarding/on_boarding_isi_foto.dart';
import '../../theme/color_utils.dart';
import '../../widgets/Container/container_list_profiling.dart';
import '../../widgets/Container/container_yellow_home.dart';
import '../../widgets/Container/continer_profiling.dart';
import '../curhat/normal_user/curhart_dashboard.dart';
import '../konsultasi/normal_user/konsultasi_page.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  final Function(int) klickTab;
  const HomeScreen({super.key, required this.klickTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();


  late PageController _pageController;
  int _currentIndex = 0;
  StreamSubscription? eventBalanceStream;
  TextEditingController codeReferralC = TextEditingController();
  List<bool> tappedStates = List.filled(3, false);
  List<String> sliderData = [
    "images/slide_1.png",
    "images/slide_2.png",
    "images/slide_3.png",
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < sliderData.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0; // Kembali ke awal jika di halaman terakhir
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProviderUser>().checkProfile(context);
      context.read<ProviderUser>().getTotalSaldo(context);
      context.read<ProviderPayment>().getListTopUp(context);
      context.read<ProviderAffiliate>().checkTopupAffiliate(context);
      context.read<ConsultantProvider>().checkUserSession(context);
      Provider.of<ProviderProfiling>(context, listen: false)
          .getListProfiling(context);
      // // _pengecekanIsAffiliate();
      // context.read<ProviderPayment>().getAmoutDeposit(context);
    });
  }

  // initHome() async {
  //   await context.read<ProviderAffiliate>().getHomeAff(context);
  // }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    eventBalanceStream?.cancel();
    codeReferralC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formatRupiah(String price) {
      final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatter.format(double.tryParse(price) ?? 0);
    }

    // Tentukan index yang ingin ditampilkan berdasarkan status user Indonesia
    final List<int> visibleSliderIndexes = dataGlobal.isIndonesia
        ? [0, 2] // Jika user dari Indonesia, tampilkan index 1 dan 3
        : [0, 1, 2]; // Jika bukan, tampilkan index 1, 2, dan 3

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProviderBook.initHomeBook(context)),
      ],
      child:
          // Consumer<ProviderBook>(
          //   builder: (BuildContext context, value, Widget? child) =>
          Consumer<ProviderProfiling>(
        builder: (BuildContext context, valuePro, Widget? child) =>
            Consumer<ProviderAffiliate>(
          builder: (BuildContext context, valueAffiliate, Widget? child) =>
              Consumer<ProviderUser>(
                  builder: (BuildContext context, valueUser, Widget? child) {
                    bool loadingscreen = valuePro.isLoading == true || valueAffiliate.isCektopup== true;
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(75.0),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          Colors.white
                        ], // Gradasi biru ke putih
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                         AppAsset.imgNewCoolLogo,
                          height: 50.sp,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 6,bottom: 8,left: 5,top: 8),
                        child: Container(
                            height: 32.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  loadingscreen
                                      ?  ShimmerLoadingWidget(
                                          height: 24.sp,
                                          width: 50.sp,
                                        )
                                      : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailSaldoPage()));
                                    },
                                    child: Text(
                                      valueUser.totalDeposit,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  gapW10,
                                  Consumer<ProviderUser>(
                                      builder: (context, stateUser, __) {
                                    return InkWell(
                                        onTap: () async {
                                          if (stateUser.dataUser?.isAffiliate
                                                  .toString() ==
                                              "1") {
                                            debugPrint("tes topup1");
                                            NotificationUtils.showDialogError(
                                                context, () {
                                              Nav.back();
                                            },
                                                widget: Text(
                                                  S
                                                      .of(context)
                                                      .feature_unavailable_affiliate,
                                                  textAlign: TextAlign.center,
                                                ));
                                          } else {
                                            //
                                            debugPrint("tes topup2");

                                            context
                                                .read<ProviderPayment>()
                                                .cekListTopUp(context);
                                          }
                                        },
                                        child: Icon(
                                          CupertinoIcons.plus_circle_fill,
                                          color: primaryColor,
                                          size: 20.sp,
                                        ));
                                  })
                                ],
                              ),
                            )),
                      ),
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.only(top: 8,bottom: 8,right: 8),
                        child: GestureDetector(
                          onTap: () {
                            widget.klickTab(3);
                          },
                          child: loadingscreen
                              ? Shimmer.fromColors(
                                  baseColor: greyColor.withOpacity(0.2),
                                  highlightColor: whiteColor,
                                  child: Container(
                                    height: 45.sp,
                                    width: 45.sp,
                                    decoration: BoxDecoration(
                                        color: greyColor, shape: BoxShape.circle),
                                  ))
                              : valueUser.dataUser?.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        "${valueUser.dataUser?.image}",
                                        width: 45.sp,
                                        height: 45.sp,
                                        fit: BoxFit.fill,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          // Tampilkan gambar placeholder jika terjadi error
                                          return Image.asset(
                                            'images/default_user.png', // Path ke gambar placeholder lokal
                                            width: 45.sp,
                                            height: 45.sp,
                                            fit: BoxFit.fill,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }

                                          return Shimmer.fromColors(
                                              baseColor:
                                                  greyColor.withOpacity(0.2),
                                              highlightColor: whiteColor,
                                              child: Container(
                                                height: 45.sp,
                                                width: 45.sp,
                                                decoration: BoxDecoration(
                                                    color: greyColor,
                                                    shape: BoxShape.circle),
                                              ));
                                        },
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        "images/default_user.png",
                                        width: 56,
                                        height: 56,
                                        color: whiteColor,
                                      ),
                                    ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body: Consumer<ProviderPayment>(
                  builder: (BuildContext context, valueDep, Widget? child) {
                    bool isLoadingprice = valueDep.isLoadingListPro; // Tambahkan indikator loading

                    final itemQty1 = valueDep.listDataListTopUp
                        ?.firstWhere((item) => item.qty == 1);
                    final nameQty1 = itemQty1?.name ?? "Profiling x1";
                    final priceQty1 = dataGlobal.isIndonesia == true
                        ? (itemQty1?.price?.toString() ?? "250.000")
                        : (itemQty1?.intlPrice?.toString() ?? "365.000");

                    final itemQty10 = valueDep.listDataListTopUp
                        ?.firstWhere((item) => item.qty == 10);
                    final nameQty10 = itemQty10?.name ?? "Profiling x10";
                    final priceQty10 = dataGlobal.isIndonesia == true ?
                    (itemQty10?.price?.toString() ?? "2.500.000"):(itemQty10?.intlPrice?.toString() ?? "3.600.000");

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
                    // Provider.of<ProviderPayment>(context, listen: false)
                    //     .getAmoutDeposit(context);
                    Provider.of<ProviderUser>(context, listen: false)
                        .getTotalSaldo(context);
                    Provider.of<ProviderProfiling>(context, listen: false)
                        .getListProfiling(context);
                    Provider.of<ProviderAffiliate>(context, listen: false)
                        .checkTopupAffiliate(context);

                    Timer(const Duration(seconds: 1), () {
                      Provider.of<ProviderUser>(context, listen: false)
                          .getTotalSaldo(context);
                    });
                    return Future<void>.delayed(const Duration(seconds: 1));
                  },
                  indicatorBuilder:
                      (BuildContext context, IndicatorController controller) {
                    return const RefreshIconWidget();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: loadingscreen
                            ? Column(
                          children: [
                            gapH20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(child: shimmerButton()),
                                gapW10,
                                Expanded(child: shimmerButton()),
                                gapW10,
                                Expanded(child: shimmerButton()),
                              ],
                            ),
                            gapH10,
                            shimmerButton(),
                            gapH10,
                            shimmerContainer(height: 230, width: double.infinity),
                            gapH32,
                            shimmerButton(),
                            gapH10,
                            shimmerIconRow(),
                            gapH20,
                            shimmerButton(),
                            gapH10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(child: shimmerButton()),
                                gapW10,
                                Expanded(child: shimmerButton()),
                              ],
                            ),
                            gapH20,
                            shimmerButton(),
                          ],
                        ) : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ContainerYellowHome(
                                  onTap: () {
                                    Nav.to(CurhatDashboard());
                                  },
                                  icon: AppAsset.icCurhat,
                                  title: S.of(context).Curhat,
                                  iconColor: BlueColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ContainerYellowHome(
                                  onTap: () {
                                    Nav.to(const HomeEbook());
                                  },
                                  icon: AppAsset.icBuku,
                                  title: S.of(context).ebook,
                                  iconColor: BlueColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ContainerYellowHome(
                                  onTap: () {
                                    Nav.to(KonsultasiPage());
                                  },
                                  icon: AppAsset.icKonsultasi,
                                  title: S.of(context).Consultation,
                                  iconColor: BlueColor,
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     ContainerYellowHome(
                            //       onTap: () {
                            //         Nav.to(CurhatDashboard());
                            //       },
                            //       icon: AppAsset.icCurhat,
                            //       title: S.of(context).Curhat,
                            //       iconColor: BlueColor,
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     ContainerYellowHome(
                            //       onTap: () {
                            //         Nav.to(const HomeEbook());
                            //       },
                            //       icon: AppAsset.icBuku,
                            //       title: S.of(context).ebook,
                            //       iconColor: BlueColor,
                            //     ),
                            //   ],
                            // ),
                            // gapH10,
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     ContainerYellowHome(
                            //       onTap: () {
                            //         Nav.to(KonsultasiPage());
                            //       },
                            //       icon: AppAsset.icKonsultasi,
                            //       title: S.of(context).Consultation,
                            //       iconColor: BlueColor,
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     ContainerYellowHome(
                            //       onTap: () {
                            //         Nav.to(MeetingDashboard());
                            //       },
                            //       icon: 'images/icmeet.png',
                            //       title: 'CoolMeet',
                            //       iconColor: BlueColor,
                            //     ),
                            //   ],
                            // ),
                            // gapH20,
                            // Container(
                            //     width: 50,
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         borderRadius: BorderRadius.circular(5)),
                            //     child: InkWell(
                            //       onTap: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     QRCodePage()));
                            //       },
                            //       child: Icon(
                            //         Icons.qr_code_scanner_rounded,
                            //         color: primaryColor,
                            //         size: 23,
                            //       ),
                            //     )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 0),
                              child: Text(
                                S.of(context).News_From_COOL,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 210,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: visibleSliderIndexes.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  int realIndex = visibleSliderIndexes[index];
                                  return InkWell(
                                    onTap: () async {
                                      if (realIndex == 0) {
                                        await valuePro.cekAvailableProfiling(context, codeReferralC, "seeall");
                                        codeReferralC.clear();
                                      } else if (realIndex == 1) {
                                        if (dataGlobal.dataUser?.isAffiliate == 0 &&
                                            dataGlobal.isIndonesia == false) {
                                          Nav.to(CommisionDashboard());
                                        }
                                      } else if (realIndex == 2) {
                                        await valuePro.cekAvailableProfiling(context, codeReferralC, "seeall");
                                        codeReferralC.clear();
                                      }
                                    },
                                    child: Image.asset(
                                      sliderData[realIndex],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(visibleSliderIndexes.length, (index) {
                                bool isActive = _currentIndex == index;

                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: isActive ? 24 : 8,
                                  height: 8,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: isActive ? Colors.blue : Colors.grey,
                                    borderRadius: BorderRadius.circular(isActive ? 4 : 50),
                                  ),
                                );
                              }),
                            ),
                            gapH20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).My_Profiling,
                                  style: TextStyle(
                                      color: BlueColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                // TextButton(
                                //     onPressed: () async {
                                //       Nav.to(const InputCodeRefPofilling(route: 'register',));
                                //     },
                                //     child: Text(
                                //       "bypass",
                                //       style: TextStyle(
                                //           color: BlueColor, fontSize: 18),
                                //     )),
                                TextButton(
                                    onPressed: () async {
                                      await valuePro
                                          .cekAvailableProfiling(
                                          context, codeReferralC,"seeall");
                                      codeReferralC.clear();
                                    },
                                    child: Text(
                                      "${S.of(context).see_all} >",
                                      style: TextStyle(
                                          color: BlueColor, fontSize: 18),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 100, // Sesuaikan tinggi widget
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                   if (valuePro.listProfiling.isNotEmpty)
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
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
                                                  if(data.isAboveseventeen == true){
                                                    Nav.to(ScreenHasilKepribadian(
                                                        data: data));
                                                  }else{
                                                    Nav.to(ScreenHasilKepribadianBawah17(
                                                        data: data));
                                                  }
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
                                                  if(data.isAboveseventeen == true){
                                                    Nav.to(ScreenHasilKepribadian(
                                                        data: data));
                                                  }else{
                                                    Nav.to(ScreenHasilKepribadianBawah17(
                                                        data: data));
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: BlueColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Text(data.status.toString() ==
                                                      "0" ? S.of(context).pending :
                                                        data.typeBrain,
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
                                                          SizedBox(
                                                            width: 50,
                                                            child: Text(
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
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Icon(
                                                            CupertinoIcons
                                                                .heart_fill,
                                                            color: Colors.white,
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
                                    ListProfilingContainer(
                                      leading: Icon(
                                        CupertinoIcons.plus,
                                        color: Colors.white,
                                      ),
                                      title: S.of(context).profiling,
                                      onTap: () async {
                                        await valuePro
                                            .cekAvailableProfiling(
                                            context, codeReferralC,"plus");
                                        codeReferralC.clear();
                                        // Nav.to(AddMultipleProfiling(
                                        //   int.parse('1'),
                                        //   int.parse('10'),
                                        // ));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 20),
                              child: Text(
                                S.of(context).Ayo_kenali_diri_anda,
                                style: TextStyle(
                                    color: BlueColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               ContainerProfiling(
                                  onTap: () async {
                                    await valuePro.cekAvailableProfiling(context, codeReferralC, "profiling1");
                                    codeReferralC.clear();
                                  },
                                  backgroundColor: Colors.lightBlueAccent,
                                  borderColor: Colors.blue,
                                  leading: Image.asset('images/HeadIcon1.png'),
                                  title: nameQty1,
                                  subtitle: formatRupiah(priceQty1),
                                ),
                                SizedBox(width: 15),
                                ContainerProfiling(
                                  onTap: () async {
                                    await valuePro.cekAvailableProfiling(context, codeReferralC, "profiling10");
                                    codeReferralC.clear();
                                  },
                                  backgroundColor: Color(0xFFF8DB1C),
                                  borderColor: YellowColor,
                                  leading: Image.asset('images/HeadIcon2.png'),
                                  title: nameQty10,
                                  subtitle: formatRupiah(priceQty10),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 80,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: BlueColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Consumer<ProviderAuthAffiliate>(
                                builder: (context, provider, child) {
                                  return provider.isCheckAffiliate
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: YellowColor,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () async {
                                            // initHome();
                                            if (valueAffiliate
                                                    .resCheckTopupAffiliate
                                                    ?.data
                                                    ?.notif !=
                                                5) {
                                              await context
                                                  .read<ProviderAuthAffiliate>()
                                                  .checkIsAffiliate(context);
                                            }
                                          },
                                          child: ListTile(
                                            leading: Icon(
                                              CupertinoIcons.person_2_fill,
                                              color: YellowColor,
                                            ),
                                            title: Text(
                                              S.of(context).Become_Affiliator,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              S
                                                  .of(context)
                                                  .Earn_money_by_becoming_an_affiliator,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.5),
                                            ),
                                            trailing: Icon(
                                              CupertinoIcons.forward,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                },
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

Widget shimmerIconRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children:
    List.generate(4, (index) => shimmerContainer(height: 78, width: 78)),
  );
}
