// // ignore_for_file: use_build_context_synchronously, must_be_immutable

// import 'dart:async';

// import 'package:coolappflutter/data/data_global.dart';
// import 'package:coolappflutter/data/locals/preference_handler.dart';
// import 'package:coolappflutter/data/locals/shared_pref.dart';
// import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
// import 'package:coolappflutter/data/provider/provider_user.dart';
// import 'package:coolappflutter/generated/l10n.dart';
// import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
// import 'package:coolappflutter/presentation/pages/user/change_language.dart';
// import 'package:coolappflutter/presentation/pages/user/delete_account.dart';
// import 'package:coolappflutter/presentation/pages/user/history_brain_activation.dart';
// import 'package:coolappflutter/presentation/pages/user/history_ebook.dart';
// import 'package:coolappflutter/presentation/pages/user/history_merchandise_payment.dart';
// import 'package:coolappflutter/presentation/pages/user/history_topup.dart';
// import 'package:coolappflutter/presentation/pages/user/screen_history.dart';
// import 'package:coolappflutter/presentation/pages/user/screen_profile.dart';
// import 'package:coolappflutter/presentation/pages/user/screen_qr.dart';
// import 'package:coolappflutter/presentation/pages/user/update_password.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/utils/nav_utils.dart';
// import 'package:coolappflutter/presentation/widgets/button_primary.dart';
// import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
// import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';

// class ScreenSettings extends StatefulWidget {
//   final void Function()? onLanguageChanged;
//   const ScreenSettings({super.key, this.onLanguageChanged});

//   @override
//   State<ScreenSettings> createState() => _ScreenSettingsState();
// }

// String tes = "";

// class _ScreenSettingsState extends State<ScreenSettings> {
//   @override
//   void initState() {
//     Timer(const Duration(seconds: 3), () {
//       debugPrint("cek screeen setting state");
//       setState(() {
//         tes = "oke";
//         Provider.of<ProviderUser>(context, listen: false).getUser(context);
//       });
//     });
//     Timer(const Duration(seconds: 6), () {
//       debugPrint("cek screeen setting state");
//       setState(() {
//         tes = "oke 2";
//         Provider.of<ProviderUser>(context, listen: false).getUser(context);
//       });
//     });

//     super.initState();
//   }

//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (BuildContext context) {
//         return ProviderUser.initMemberArea(context);
//       },
//       child: Consumer<ProviderUser>(builder: (context, value, child) {
//         return Scaffold(
//           appBar: AppBar(
//             centerTitle: false,
//             title: Text(
//               S.of(context).setting,
//               style: const TextStyle(color: Colors.white),
//             ),
//             iconTheme: const IconThemeData(color: Colors.white),
//             backgroundColor: primaryColor,
//           ),
//           body: CustomMaterialIndicator(
//             key: _refreshIndicatorKey,
//             onRefresh: () {
//               Provider.of<ProviderUser>(context, listen: false)
//                   .getUser(context);
//               return Future<void>.delayed(const Duration(seconds: 1));
//             },
//             indicatorBuilder:
//                 (BuildContext context, IndicatorController controller) {
//               return const RefreshIconWidget();
//             },
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 32),
//                     color: Colors.white,
//                     child: Row(
//                       children: [
//                         value.isLoading
//                             ? Shimmer.fromColors(
//                                 baseColor: greyColor.withOpacity(0.2),
//                                 highlightColor: whiteColor,
//                                 child: Container(
//                                   height: 56,
//                                   width: 56,
//                                   decoration: BoxDecoration(
//                                       color: greyColor, shape: BoxShape.circle),
//                                 ))
//                             : value.dataUser?.image != null
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(100),
//                                     child: Image.network(
//                                       "${value.dataUser?.image}",
//                                       width: 56,
//                                       height: 56,
//                                       fit: BoxFit.fill,
//                                       errorBuilder: (BuildContext context,
//                                           Object exception,
//                                           StackTrace? stackTrace) {
//                                         // Tampilkan gambar placeholder jika terjadi error
//                                         return Image.asset(
//                                           'images/default_user.png', // Path ke gambar placeholder lokal
//                                           width: 56,
//                                           height: 56,
//                                           fit: BoxFit.fill,
//                                         );
//                                       },
//                                     ))
//                                 : ClipRRect(
//                                     borderRadius: BorderRadius.circular(100),
//                                     child: Image.asset(
//                                       "images/default_user.png",
//                                       width: 56,
//                                       height: 56,
//                                       color: greyColor,
//                                     ),
//                                   ),
//                         const SizedBox(
//                           width: 16,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               dataGlobal.dataUser?.name == null
//                                   ? dataGlobal.dataUser?.phoneNumber != null
//                                       ? dataGlobal.dataUser?.phoneNumber
//                                           .toString()
//                                       : ""
//                                   : dataGlobal.dataUser?.name ?? "",
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             Text(
//                               "${dataGlobal.dataUser?.phoneNumber ?? ""}",
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   color: greyColor.withOpacity(0.5)),
//                             ),
//                             // value.isMemberArea
//                             //     ? const ShimmerLoadingWidget(
//                             //         height: 16,
//                             //         width: 100,
//                             //         borderRadius: 6,
//                             //       )
//                             //     : Text(
//                             //         "${value.memberArea?.country}",
//                             //         style: TextStyle(
//                             //             fontSize: 12,
//                             //             color: greyColor.withOpacity(0.5)),
//                             //       ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 3,
//                     color: Color(0xFFF2F2F2),
//                   ),
//                   ItemSetting(
//                     title: S.of(context).profile,
//                     image: "profile.png",
//                     onTap: () {
//                       Nav.to(ScreenProfile(
//                         phone: dataGlobal.dataUser?.phoneNumber,
//                       ));
//                     },
//                   ),
//                   // ItemSetting(
//                   //   title: S.of(context).affiliate,
//                   //   image: "icon_affiliate.png",
//                   //   onTap: () async {
//                   //     await context
//                   //         .read<ProviderAuthAffiliate>()
//                   //         .checkIsAffiliate(context);
//                   //   },
//                   // ),
//                   ItemSetting(
//                     title: S.of(context).qr_code,
//                     image: "qris.png",
//                     onTap: () async {
//                       Nav.to(const ScreenQr());
//                     },
//                   ),
//                   ItemSetting(
//                     title: S.of(context).language,
//                     image: "bahasa.png",
//                     onTap: () {
//                       Nav.to(ChangeLanguange(
//                         onChanged: () {
//                           setState(() {
//                             widget.onLanguageChanged!();
//                           });
//                         },
//                       ));
//                     },
//                   ),
//                   ItemSetting(
//                     title: S.of(context).change_password,
//                     image: "password.png",
//                     onTap: () {
//                       Nav.to(const UpdatePassword());
//                       setState(() {});
//                     },
//                   ),

//                   DropdownHistory(isExpanded: isExpanded),
//                   ItemSetting(
//                     title: S.of(context).delete_account,
//                     image: "disclaimer.png",
//                     onTap: () {
//                       Nav.to(const DeletedAccount());
//                       setState(() {});
//                     },
//                   ),
//                   ItemSetting(
//                     title: S.of(context).logout,
//                     image: "logout.png",
//                     onTap: () {
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               scrollable: true,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15)),
//                               insetPadding: const EdgeInsets.all(20),
//                               title: SizedBox(
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Center(
//                                   child: Image.asset(
//                                     "images/disclaimer.png",
//                                     width: 37.5,
//                                     height: 37.5,
//                                   ),
//                                 ),
//                               ),
//                               content: Center(
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       S.of(context).exit_confirmation,
//                                       style: const TextStyle(fontSize: 16),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     const SizedBox(
//                                       height: 25,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: SizedBox(
//                                             height: 54,
//                                             child: ButtonPrimary(
//                                               S.of(context).no,
//                                               onPress: () {
//                                                 Nav.back();
//                                               },
//                                               negativeColor: true,
//                                               border: 1,
//                                               radius: 10,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 16,
//                                         ),
//                                         Expanded(
//                                           child: SizedBox(
//                                             height: 54,
//                                             child: ButtonPrimary(
//                                               S.of(context).yes_exit,
//                                               onPress: () async {
//                                                 await Prefs().clearSession();
//                                                 Nav.toAll(const LoginScreen());

//                                                 // Provider.of<ProviderAuth>(
//                                                 //         context,
//                                                 //         listen: false)
//                                                 //     .logout(context);
//                                               },
//                                               radius: 10,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// class DropdownHistory extends StatefulWidget {
//   DropdownHistory({super.key, required this.isExpanded});
//   bool isExpanded;

//   @override
//   State<DropdownHistory> createState() => _DropdownHistoryState();
// }

// class _DropdownHistoryState extends State<DropdownHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: ExpansionTile(
//         title: Text(S.of(context).history),
//         collapsedShape: const RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         shape: const RoundedRectangleBorder(
//           side: BorderSide.none,
//         ),
//         leading: Image.asset(
//           "images/menu/history.png",
//           width: 24,
//           height: 24,
//         ),
//         trailing: SizedBox(
//           width: 24,
//           child: Center(
//             child: Image.asset(
//               widget.isExpanded
//                   ? "assets/icons/arrow_up.png"
//                   : "assets/icons/arrow_down.png",
//               width: 20,
//             ),
//           ),
//         ),
//         onExpansionChanged: (value) {
//           setState(() {
//             widget.isExpanded = value;
//           });
//         },
//         children: [
//           ItemSetting(
//             title: S.of(context).profiling,
//             onTap: () {
//               Nav.to(const ScreenHistory());
//               setState(() {});
//             },
//           ),
//           ItemSetting(
//             title: S.of(context).top_up,
//             onTap: () {
//               Nav.to(const HistoryTopup());
//               setState(() {});
//             },
//           ),
//           ItemSetting(
//             title: S.of(context).ebook,
//             onTap: () {
//               Nav.to(const HistoryEbook());
//               setState(() {});
//             },
//           ),
//           ItemSetting(
//             title: S.of(context).brain_activation,
//             onTap: () {
//               Nav.to(const HistoryBrainActivation());
//               setState(() {});
//             },
//           ),
//           ItemSetting(
//             title: S.of(context).merchandise_payment,
//             onTap: () {
//               Nav.to(const HistoryMerchandisePayement());
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ItemSetting extends StatelessWidget {
//   final String title;
//   final String? image;
//   final void Function()? onTap;
//   const ItemSetting({
//     super.key,
//     required this.title,
//     this.image,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: ListTile(
//         title: Text(title),
//         leading: image != null
//             ? Image.asset(
//                 "images/menu/$image",
//                 width: 24,
//                 height: 24,
//               )
//             : const Text(''),
//         trailing: SizedBox(
//           width: 24,
//           child: Center(
//             child: Image.asset(
//               "images/menu/arrow.png",
//               width: 8,
//             ),
//           ),
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:async';

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_auth_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/screen_total_member.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/pages/main/qrcode/qr_code.dart';
import 'package:coolappflutter/presentation/pages/payments/top_up_page.dart';
import 'package:coolappflutter/presentation/pages/transakction/transaksi_affiliate.dart';
import 'package:coolappflutter/presentation/pages/user/change_language.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Delete_Account/delete_account.dart';
import 'package:coolappflutter/presentation/pages/user/history_brain_activation.dart';
import 'package:coolappflutter/presentation/pages/user/history_ebook.dart';
import 'package:coolappflutter/presentation/pages/user/history_merchandise_payment.dart';
import 'package:coolappflutter/presentation/pages/user/history_topup.dart';
import 'package:coolappflutter/presentation/pages/user/screen_history.dart';
import 'package:coolappflutter/presentation/pages/user/screen_profile.dart';
import 'package:coolappflutter/presentation/pages/user/screen_qr.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/setting_Page.dart';
import 'package:coolappflutter/presentation/pages/user/type_brain.dart';
import 'package:coolappflutter/presentation/pages/user/update_password.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      });
    });
    Timer(const Duration(seconds: 6), () {
      debugPrint("cek screeen setting state");
      setState(() {
        tes = "oke 2";
        Provider.of<ProviderUser>(context, listen: false).getUser(context);
      });
    });

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

    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderUser.initMemberArea(context);
      },
      child: Consumer<ProviderUser>(builder: (context, value, child) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      color: Colors.white,
                      child: Row(
                        children: [
                          value.isLoading
                              ? Shimmer.fromColors(
                              baseColor: greyColor.withOpacity(0.2),
                              highlightColor: whiteColor,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: greyColor,
                                    shape: BoxShape.circle),
                              ))
                              : value.dataUser?.image != null
                              ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                brainColors[dataGlobal.dataUser?.typeBrain] ?? Colors.white, // Warna garis tepi
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
                                width: 80,
                                height: 80,
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
                              ),
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "images/default_user.png",
                              width: 80,
                              height: 80,
                              color: greyColor,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataGlobal.dataUser?.name == null
                                    ? dataGlobal.dataUser?.phoneNumber != null
                                    ? dataGlobal.dataUser?.phoneNumber
                                    .toString()
                                    : ""
                                    : dataGlobal.dataUser?.name ?? "",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // if (dataGlobal.dataUser!.typeBrain == null || dataGlobal.dataUser!.typeBrain.isEmpty)
                              BrainTypeWidget(typeBrain:  dataGlobal.dataUser!.typeBrain.toString(),)
                            ],
                          )
                        ],
                      ),
                    ),
                    ContainerFollower(
                      title1: S.of(context).Post,
                      subtitle1: '0',
                      title2: S.of(context).Follower,
                      subtitle2: '0',
                      title3: S.of(context).following,
                      subtitle3: '0',
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        if(dataGlobal.dataUser?.isAffiliate == 1){
                          Nav.to(TransaksiAffiliatePage(
                            initialTab: () =>
                            0, // Menentukan tab kedua sebagai tab awal
                            tabChanger: (changeTabAffiliate) {
                              // Dapat digunakan untuk mengubah tab dari luar
                            },
                          ));
                        } else {
                          Nav.to(const TopUpPage());
                        }

                      },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    S.of(context).my_balance,
                                    style: TextStyle(
                                        color: BlueColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.wallet,
                                        color: BlueColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          'IDR ${(dataGlobal.dataAff?.totalSaldoAffiliate == null || dataGlobal.dataAff?.totalSaldoAffiliate == '') ? "0" : dataGlobal.dataAff?.totalSaldoAffiliate}',
                                          style: TextStyle(
                                              color: BlueColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Nav.to(TransaksiAffiliatePage(
                                    initialTab: () =>
                                    0, // Menentukan tab kedua sebagai tab awal
                                    tabChanger: (changeTabAffiliate) {
                                      // Dapat digunakan untuk mengubah tab dari luar
                                    },
                                  ));
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: BlueColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (dataGlobal.dataUser?.isAffiliate == 1)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: InkWell(
                              onTap: () {
                                Nav.to(const ScreenTotalMember());
                              },
                              child: Container(
                                height: 60,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        CupertinoIcons.person_2_fill,
                                        color: BlueColor,
                                      ),
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
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      QRCodePage()));
                            },
                            child: Container(
                              height: 60,
                              width: 175,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.qrcode_viewfinder,
                                      color: BlueColor,
                                    ),
                                    gapW10,
                                    Text(S.of(context).digital_ID,
                                        style: TextStyle(
                                            color: BlueColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(S.of(context).Others,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),

                    ItemSetting(
                      title: S.of(context).Edit_profile,
                      image: "edit_profile.png",
                      onTap: () {
                        Nav.to(ScreenProfile(
                          phone: dataGlobal.dataUser?.phoneNumber,
                        ));
                      },
                    ),
                    // ItemSetting(
                    //   title: S.of(context).profiling_results,
                    //   image: "profiling_setting.png",
                    //   onTap: () {},
                    // ),
                    ItemSetting(
                      title: S.of(context).setting,
                      image: "setting_setting.png",
                      onTap: () {
                        Nav.to(Setting_page());
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
      }),
    );
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