// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:coolappflutter/data/provider/provider_auth_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_payment.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/response/res_list_ebook.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/main.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/card_book.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/networks/endpoint/api_endpoint.dart';
import '../../../data/provider/provider_affiliate.dart';
import '../../theme/color_utils.dart';
import '../../utils/circular_progress_widget.dart';
import 'list_ebook_all.dart';

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

  StreamSubscription? eventBalanceStream;
  TextEditingController codeReferralC = TextEditingController();
  List<bool> tappedStates = List.filled(3, false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProviderUser>().checkProfile(context);
      context.read<ProviderUser>().getTotalSaldo(context);

      // // _pengecekanIsAffiliate();
      // context.read<ProviderPayment>().getAmoutDeposit(context);
    });
  }

  initHome() async {
    await context.read<ProviderAffiliate>().getHomeAff(context);
  }

  @override
  void dispose() {
    eventBalanceStream?.cancel();
    codeReferralC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ProviderBook.initHomeBook(context)),
          ChangeNotifierProvider(create: (context) => ProviderProfiling()),
        ],
        child: Consumer<ProviderBook>(
          builder: (BuildContext context, value, Widget? child) =>
              Consumer<ProviderProfiling>(
            builder: (BuildContext context, valuePro, Widget? child) =>
                Consumer<ProviderAffiliate>(
              builder: (BuildContext context, valueAffiliate, Widget? child) =>
                  Consumer<ProviderUser>(builder:
                      (BuildContext context, valueUser, Widget? child) {
                return Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(75.0),
                    child: AppBar(
                      backgroundColor: primaryColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "images/logo_coolapp_new.png",
                            height: 40,
                            width: 129,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.klickTab(3);
                            },
                            child: valueUser.isLoading
                                ? Shimmer.fromColors(
                                    baseColor: greyColor.withOpacity(0.2),
                                    highlightColor: whiteColor,
                                    child: Container(
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                          color: greyColor,
                                          shape: BoxShape.circle),
                                    ))
                                : valueUser.dataUser?.image != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${valueUser.dataUser?.image}",
                                          width: 56,
                                          height: 56,
                                          fit: BoxFit.fill,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            // Tampilkan gambar placeholder jika terjadi error
                                            return Image.asset(
                                              'images/default_user.png', // Path ke gambar placeholder lokal
                                              width: 56,
                                              height: 56,
                                              fit: BoxFit.fill,
                                            );
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }

                                            return Shimmer.fromColors(
                                                baseColor:
                                                    greyColor.withOpacity(0.2),
                                                highlightColor: whiteColor,
                                                child: Container(
                                                  height: 56,
                                                  width: 56,
                                                  decoration: BoxDecoration(
                                                      color: greyColor,
                                                      shape: BoxShape.circle),
                                                ));
                                          },
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                          "images/default_user.png",
                                          width: 56,
                                          height: 56,
                                          color: whiteColor,
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
                        Provider.of<ProviderBook>(context, listen: false)
                            .getListEbook(context);
                        // Provider.of<ProviderPayment>(context, listen: false)
                        //     .getAmoutDeposit(context);
                        Provider.of<ProviderUser>(context, listen: false)
                            .getTotalSaldo(context);
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
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 71 / 2,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 71,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Card(
                                              elevation: 5,
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .my_balance,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        Provider.of<ProviderPayment>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isLoading
                                                            ? const ShimmerLoadingWidget(
                                                                height: 24,
                                                                width: 100,
                                                              )
                                                            : Text(
                                                                valueUser
                                                                    .totalDeposit,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              )
                                                      ],
                                                    ),
                                                    Consumer<ProviderUser>(
                                                        builder: (context,
                                                            stateUser, __) {
                                                      return MaterialButton(
                                                        minWidth: 91,
                                                        height: 34,
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        onPressed: () async {
                                                          if (stateUser.dataUser
                                                                  ?.isAffiliate
                                                                  .toString() ==
                                                              "1") {
                                                            debugPrint(
                                                                "tes topup1");
                                                            NotificationUtils
                                                                .showDialogError(
                                                                    context,
                                                                    () {
                                                              Nav.back();
                                                            },
                                                                    widget:
                                                                        Text(
                                                                      S
                                                                          .of(context)
                                                                          .feature_unavailable_affiliate,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ));
                                                          } else {
                                                            //
                                                            debugPrint(
                                                                "tes topup2");

                                                            context
                                                                .read<
                                                                    ProviderPayment>()
                                                                .getListTopUp(
                                                                    context);

                                                            // Provider.of<ProviderPayment>(
                                                            //         context,
                                                            //         listen: true)
                                                            //     .getListTopUp(
                                                            //         context);
                                                          }
                                                        },
                                                        textColor: Colors.white,
                                                        color: primaryColor,
                                                        child: Text(
                                                          S.of(context).top_up,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12),
                                                        ),
                                                      );
                                                    }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 216,
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      padding: const EdgeInsets.all(16),
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Listener(
                                            onPointerDown: (event) =>
                                                setState(() {
                                              tappedStates[0] = true;
                                            }),
                                            onPointerUp: (event) =>
                                                setState(() {
                                              tappedStates[0] = false;
                                            }),
                                            child: ItemMenuHome(
                                                "images/thinking.png",
                                                S.of(context).profiling,
                                                S
                                                    .of(context)
                                                    .self_surgery_solution_surgery,
                                                () async {
                                              await valuePro
                                                  .cekAvailableProfiling(
                                                      context, codeReferralC);
                                              codeReferralC.clear();

                                              ///ubah jangan lupa
                                              // Nav.to(
                                              //     const ScreenFeatureKepribadian());
                                            }, tappedStates[0],
                                                isLoading:
                                                    valuePro.isCekAvailable),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Listener(
                                            onPointerDown: (event) =>
                                                setState(() {
                                              tappedStates[1] = true;
                                            }),
                                            onPointerUp: (event) =>
                                                setState(() {
                                              tappedStates[1] = false;
                                            }),
                                            child: ItemMenuHome(
                                                "images/agenda.png",
                                                S.of(context).ebook,
                                                S.of(context).read_ebook_online,
                                                () {
                                              Nav.to(const ListEbookAll());
                                            }, tappedStates[1]),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Listener(
                                            onPointerDown: (event) =>
                                                setState(() {
                                              tappedStates[2] = true;
                                            }),
                                            onPointerUp: (event) =>
                                                setState(() {
                                              tappedStates[2] = false;
                                            }),
                                            child: ItemMenuHome(
                                              "assets/icons/affiliate_icons.png",
                                              S.of(context).affiliate,
                                              S
                                                  .of(context)
                                                  .sharing_opportunities_sharing_profits,
                                              () async {
                                                initHome();
                                                debugPrint(
                                                    "apa disini? ${valueAffiliate.resCheckTopupAffiliate?.data?.notif}");
                                                if (valueAffiliate
                                                        .resCheckTopupAffiliate
                                                        ?.data
                                                        ?.notif !=
                                                    5) {
                                                  debugPrint(
                                                      "apa disiniii? ${valueAffiliate.resCheckTopupAffiliate?.data?.notif}");
                                                  await context
                                                      .read<
                                                          ProviderAuthAffiliate>()
                                                      .checkIsAffiliate(
                                                          context);
                                                  valueAffiliate
                                                      .notifyListeners();
                                                }
                                              },
                                              tappedStates[2],
                                              isLoading: Provider.of<
                                                          ProviderAuthAffiliate>(
                                                      context,
                                                      listen: true)
                                                  .isCheckAffiliate,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (valueAffiliate
                                    .resCheckTopupAffiliate?.data?.notif ==
                                2) ...[
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffFFF3cd),
                                    border: Border.all(
                                        color: const Color(0x00ffeeba),
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10)),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                                valueAffiliate
                                                        .resCheckTopupAffiliate
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
                                        valueAffiliate.resCheckTopupAffiliate =
                                            null;
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
                            Column(
                              children: [
                                const Divider(
                                  thickness: 4,
                                  color: Color(0xFFF2F2F2),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            S.of(context).latest_book,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Nav.to(const ListEbookAll());
                                            },
                                            child: Text(
                                              S.of(context).see_all,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      if (value.isListEbook) ...[
                                        ShimmerLoadingWidget(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        ShimmerLoadingWidget(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        ShimmerLoadingWidget(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                        const SizedBox(
                                          height: 16,
                                        )
                                      ] else ...[
                                        ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: value.listEbook.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            DataBook data =
                                                value.listEbook[index];
                                            return CardBook(
                                              data: data,
                                              provider: value,
                                              onUpdate: () {
                                                value.getListEbook(context);
                                                value.getAllBook(context);
                                              },
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 16));
                                          },
                                        )
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
        ));
  }
}

class ItemMenuHome extends StatefulWidget {
  final Function()? onTap;
  final String? image, title, description;
  bool isTapped = false;
  bool isLoading = false;
  ItemMenuHome(
      this.image, this.title, this.description, this.onTap, this.isTapped,
      {super.key, this.isLoading = false});

  @override
  State<ItemMenuHome> createState() => _ItemMenuHomeState();
}

class _ItemMenuHomeState extends State<ItemMenuHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 145,
        constraints: const BoxConstraints(minHeight: 175),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: greyColor.withOpacity(0.1)),
          color: widget.isTapped ? primaryColor : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.isLoading
              ? CircularProgressWidget(
                  color: primaryColor,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Image.asset(
                      widget.image ?? "",
                      width: 50,
                      height: 50,
                      color: widget.isTapped ? whiteColor : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.title ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: widget.isTapped ? whiteColor : null,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.description ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.isTapped ? whiteColor : null,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
