import 'dart:async';

import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/provider_auth_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_promotion.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/member/anggota_saya.dart';
import 'package:coolappflutter/presentation/pages/afiliate/screen_total_member.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/pages/main/qrcode/qr_code.dart';
import 'package:coolappflutter/presentation/pages/payments/commision/commision_dashboard.dart';
import 'package:coolappflutter/presentation/pages/payments/saldo_aff/detai_saldo_aff.dart';
import 'package:coolappflutter/presentation/pages/payments/top_up_page.dart';
import 'package:coolappflutter/presentation/pages/user/history_brain_activation.dart';
import 'package:coolappflutter/presentation/pages/user/history_ebook.dart';
import 'package:coolappflutter/presentation/pages/user/history_merchandise_payment.dart';
import 'package:coolappflutter/presentation/pages/user/history_topup.dart';
import 'package:coolappflutter/presentation/pages/user/screen_history.dart';
import 'package:coolappflutter/presentation/pages/user/screen_profile.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/setting_Page.dart';
import 'package:coolappflutter/presentation/pages/user/type_brain.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/Container/Container_Follower.dart';

class ScreenSettings extends StatefulWidget {
  final void Function()? onLanguageChanged;
  const ScreenSettings({super.key, this.onLanguageChanged});

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

String tes = "";

class _ScreenSettingsState extends State<ScreenSettings> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      cekSession();
      debugPrint("cek screeen setting state");
      setState(() {
        tes = "oke";
        Provider.of<ProviderUser>(context, listen: false).getUser(context);
        Provider.of<PromotionProvider>(context, listen: false).fetchListPromotion();
      });
    });
    // Timer(const Duration(seconds: 6), () {
    //   debugPrint("cek screeen setting state");
    //   setState(() {
    //     tes = "oke 2";
    //     Provider.of<ProviderUser>(context, listen: false).getUser(context);
    //   });
    // });

    super.initState();
  }

  cekSession() async {
    Prefs().getLocale().then((locale) {
      S.load(Locale(locale)).then((value) {});
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> brainColors = {
      "emotion_in": Colors.green,
      "emotion_out": Colors.green,
      "emotion": Colors.green,
      "action_in": Colors.red,
      "action_out": Colors.red,
      "action": Colors.red,
      "creative_in": Colors.orange,
      "creative_out": Colors.orange,
      "creative": Colors.orange,
      "master": Colors.black,
      "logic_in": Colors.yellow,
      "logic_out": Colors.yellow,
      "logic": Colors.yellow,
    };

    return Consumer<ProviderUser>(builder: (context, value, child) {
      return Consumer<PromotionProvider>(builder: (context, valuep, child) {
        bool isLoading = value.isLoading == true && valuep.isLoadingPromotion == true;
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              S.of(context).setting,
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: CustomMaterialIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              Provider.of<ProviderUser>(context, listen: false)
                  .getUser(context);
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            indicatorBuilder:
                (BuildContext context, IndicatorController controller) {
              return const RefreshIconWidget();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: isLoading
                    ? Column(
                  children: [
                    gapH20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        shimmerCircle(),
                        gapW10,
                        Expanded(child: shimmerContainer(height: 130, width: double.infinity))
                      ],
                    ),
                    gapH20,
                    shimmerContainer(height: 100, width: double.infinity),
                    gapH20,
                    shimmerContainer(height: 80, width: double.infinity),
                    gapH10,
                    shimmerContainer(height: 80, width: double.infinity),
                    gapH32,
                    shimmerButton(),
                    gapH10,
                    shimmerButton(),
                    gapH10,
                    shimmerButton(),
                    gapH10,
                    shimmerButton(),
                    gapH10,
                    shimmerButton(),
                    gapH10,

                  ],
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      color: Colors.white,
                      child: Row(
                        children: [
                         value.dataUser?.image != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: brainColors[dataGlobal
                                                  .dataUser?.typeBrain] ??
                                              Colors.white, // Warna garis tepi
                                          width: 4, // Lebar garis tepi
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${value.dataUser?.image}",
                                          width: 80.sp,
                                          height: 80.sp,
                                          fit: BoxFit.fill,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
// Tampilkan gambar placeholder jika terjadi error
                                            return Image.asset(
                                              'images/default_user.png', // Path ke gambar placeholder lokal
                                              width: 56.sp,
                                              height: 56.sp,
                                              fit: BoxFit.fill,
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        "images/default_user.png",
                                        width: 80.sp,
                                        height: 80.sp,
                                        color: greyColor,
                                      ),
                                    ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  dataGlobal.dataUser?.name == null
                                      ? dataGlobal.dataUser?.phoneNumber != null
                                          ? dataGlobal.dataUser?.phoneNumber
                                              .toString()
                                          : ""
                                      : dataGlobal.dataUser?.name ?? "",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QRCodePage()));
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(color: BlueColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.qrcode_viewfinder,
                                              color: BlueColor,
                                            ),
                                            gapW10,
                                            Text(S.of(context).digitalid,
                                                style: TextStyle(
                                                    color: BlueColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  dataGlobal
                                      .dataUser!.typeBrain.toString().isNotEmpty ? Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                        child: BrainTypeWidget(
                                          typeBrain: dataGlobal
                                              .dataUser!.typeBrain
                                              .toString(),
                                        )),
                                  ) : SizedBox(),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    ContainerFollower(
                      title1: S.of(context).post,
                      subtitle1:
                          dataGlobal.dataUser?.total_post.toString() ?? "0",
                      title2: S.of(context).followers,
                      subtitle2:
                          dataGlobal.dataUser?.total_follower.toString() ?? "0",
                      title3: S.of(context).following,
                      subtitle3:
                          dataGlobal.dataUser?.total_following.toString() ??
                              "0",
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    CustomBalanceCard(
                      title: S.of(context).my_balance,
                      icon: Icon(Icons.wallet,
                          color: BlueColor), // Pakai Icon biasa
                      saldo: dataGlobal.dataUser?.isAffiliate == 1
                          ? "${(dataGlobal.dataAff?.totalSaldoAffiliate?.isEmpty ?? true) ? '0' : dataGlobal.dataAff?.totalSaldoAffiliate ?? '0'}"
                          : "${(dataGlobal.dataUser?.totalDeposit == null || dataGlobal.dataUser?.totalDeposit.toString().isEmpty == true) ? '0' : dataGlobal.dataUser?.totalDeposit.toString()}",
                      bgColor: Colors.lightBlueAccent.shade100,
                      textColor: BlueColor,
                      onTap: () {
                        if (dataGlobal.dataUser?.isAffiliate == 1) {
                          Nav.to(DetailSaldoAff(
                            initialTab: () => 0,
                            tabChanger: (changeTabAffiliate) {},
                          ));
                        } else {
                          Nav.to(const TopUpPage());
                        }
                      },
                    ),
                    gapH20,
                    if (dataGlobal.dataUser?.isAffiliate == 0 &&
                        dataGlobal.isIndonesia == false)
                      CustomBalanceCard(
                        title: S.of(context).komisiKu,
                        icon: Image.asset(AppAsset.icRealMoney,
                            width: 30), // Pakai Gambar
                        saldo:
                            "${(dataGlobal.dataPromotion?.totalComission == null || dataGlobal.dataPromotion?.totalComission.toString().isEmpty == true) ? '0' : dataGlobal.dataPromotion?.totalComission.toString()}",
                        bgColor: const Color(0xFFFEFDCD),
                        textColor: DarkYellow,
                        onTap: () {
                          Nav.to(CommisionDashboard());
                        },
                      ),
                    if (dataGlobal.dataUser?.isAffiliate == 1)
                      InkWell(
                        onTap: () {
                          Nav.to(AnggotaSayaPage());
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.person_2_fill,
                                  color: BlueColor,
                                ),
                                gapW16,
                                Text(S.of(context).Member,
                                    style: TextStyle(
                                        color: BlueColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(S.of(context).other,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),

                    ItemSetting(
                      title: S.of(context).profile,
                      image: "edit_profile.png",
                      onTap: () {
                        Nav.to(ScreenProfile(
                          phone: dataGlobal.dataUser?.phoneNumber,
                        ));
                      },
                    ),
                    DropdownHistory(isExpanded: isExpanded),
                    // ItemSetting(
                    //   title: S.of(context).profiling_results,
                    //   image: "profiling_setting.png",
                    //   onTap: () {},
                    // ),
                    ItemSetting(
                      title: S.of(context).setting,
                      image: "setting_setting.png",
                      onTap: () {
                        Nav.to(Setting_page(onLanguageChanged : () {
                          setState(() {
                            if (widget.onLanguageChanged != null) {
                            }
                          });
                        },));
                      },
                    ),
                    if (dataGlobal.dataUser?.isAffiliate == 0)
                      ItemSetting(
                        title: S.of(context).affiliate,
                        image: "icon_affiliate.png",
                        onTap: () async {
                          await context
                              .read<ProviderAuthAffiliate>()
                              .checkIsAffiliate(context);
                        },
                      ),

                  // DropdownHistory(isExpanded: isExpanded),
                    ItemSetting(
                      title: S.of(context).logout,
                      image: "logout.png",
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                scrollable: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                insetPadding: const EdgeInsets.all(20),
                                title: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Image.asset(
                                      "images/disclaimer.png",
                                      width: 37.5,
                                      height: 37.5,
                                    ),
                                  ),
                                ),
                                content: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        S.of(context).exit_confirmation,
                                        style: const TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 54,
                                              child: ButtonPrimary(
                                                S.of(context).no,
                                                onPress: () {
                                                  Nav.back();
                                                },
                                                negativeColor: true,
                                                border: 1,
                                                radius: 10,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: 54,
                                              child: ButtonPrimary(
                                                S.of(context).yes_exit,
                                                onPress: () async {
                                                  await Prefs().clearSession();
                                                  Nav.toAll(
                                                      const LoginScreen());

                                                  // Provider.of<ProviderAuth>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .logout(context);
                                                },
                                                radius: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (dataGlobal.dataUser?.isAffiliate == 0)
                      InkWell(
                        onTap: () async {
                          await context
                              .read<ProviderAuthAffiliate>()
                              .checkIsAffiliate(context);
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: BlueColor,
                                ),
                                Text(S.of(context).Become_Affiliator,
                                    style: TextStyle(
                                        color: BlueColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}

class DropdownHistory extends StatefulWidget {
  DropdownHistory({super.key, required this.isExpanded});
  bool isExpanded;

  @override
  State<DropdownHistory> createState() => _DropdownHistoryState();
}

class _DropdownHistoryState extends State<DropdownHistory> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(S.of(context).history),
      collapsedShape: const RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      leading: Image.asset(
        "images/menu/history.png",
        width: 24,
        height: 24,
      ),
      trailing: SizedBox(
        width: 24,
        child: Center(
          child: Image.asset(
            widget.isExpanded
                ? "assets/icons/arrow_up.png"
                : "assets/icons/arrow_down.png",
            width: 20,
          ),
        ),
      ),
      onExpansionChanged: (value) {
        setState(() {
          widget.isExpanded = value;
        });
      },
      children: [
        ItemSetting(
          title: S.of(context).profiling,
          onTap: () {
            Nav.to(const ScreenHistory());
            setState(() {});
          },
        ),
        ItemSetting(
          title: S.of(context).top_up,
          onTap: () {
            Nav.to(const HistoryTopup());
            setState(() {});
          },
        ),
        ItemSetting(
          title: S.of(context).ebook,
          onTap: () {
            Nav.to(const HistoryEbook());
            setState(() {});
          },
        ),
        ItemSetting(
          title: S.of(context).brain_activation,
          onTap: () {
            Nav.to(const HistoryBrainActivation());
            setState(() {});
          },
        ),
        ItemSetting(
          title: S.of(context).merchandise_payment,
          onTap: () {
            Nav.to(const HistoryMerchandisePayement());
            setState(() {});
          },
        ),
        // ItemSetting(
        //   title: 'CoolMeet',
        //   onTap: () {
        //     Nav.to(RiwayatMeetingPage());
        //     setState(() {});
        //   },
        // ),
      ],
    );
  }
}

class ItemSetting extends StatelessWidget {
  final String title;
  final String? image;
  final void Function()? onTap;
  const ItemSetting({
    super.key,
    required this.title,
    this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        title: Text(title),
        leading: image != null
            ? Image.asset(
                "images/menu/$image",
                width: 24,
                height: 24,
              )
            : const Text(''),
        trailing: SizedBox(
          width: 24,
          child: Center(
            child: Image.asset(
              "images/menu/arrow.png",
              width: 8,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class CustomBalanceCard extends StatelessWidget {
  final String title;
  final Widget icon; // Bisa Icon atau Image
  final String saldo;
  final Color bgColor;
  final Color textColor;
  final VoidCallback? onTap;

  const CustomBalanceCard({
    Key? key,
    required this.title,
    required this.icon, // Menggunakan Widget agar fleksibel
    required this.saldo,
    required this.bgColor,
    required this.textColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gapH8,
                Row(
                  children: [
                    icon, // Bisa pakai Icon atau Image
                    const SizedBox(width: 10),
                    Text(
                      saldo,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: onTap,
              icon: Icon(Icons.arrow_forward_ios, color: textColor),
            ),
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
Widget shimmerCircle({double height = 120, double width = 120}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
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
        List.generate(4, (index) => shimmerContainer(height: 50, width: 50)),
  );
}
