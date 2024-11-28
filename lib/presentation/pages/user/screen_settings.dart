// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:async';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/pages/user/change_language.dart';
import 'package:coolappflutter/presentation/pages/user/delete_account.dart';
import 'package:coolappflutter/presentation/pages/user/history_brain_activation.dart';
import 'package:coolappflutter/presentation/pages/user/history_ebook.dart';
import 'package:coolappflutter/presentation/pages/user/history_merchandise_payment.dart';
import 'package:coolappflutter/presentation/pages/user/history_topup.dart';
import 'package:coolappflutter/presentation/pages/user/screen_history.dart';
import 'package:coolappflutter/presentation/pages/user/screen_profile.dart';
import 'package:coolappflutter/presentation/pages/user/screen_qr.dart';
import 'package:coolappflutter/presentation/pages/user/update_password.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 32),
                    color: Colors.white,
                    child: Row(
                      children: [
                        value.isLoading
                            ? Shimmer.fromColors(
                                baseColor: greyColor.withOpacity(0.2),
                                highlightColor: whiteColor,
                                child: Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                      color: greyColor, shape: BoxShape.circle),
                                ))
                            : value.dataUser?.image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      "${value.dataUser?.image}",
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
                                    ))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      "images/default_user.png",
                                      width: 56,
                                      height: 56,
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
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "${dataGlobal.dataUser?.phoneNumber ?? ""}",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: greyColor.withOpacity(0.5)),
                            ),
                            // value.isMemberArea
                            //     ? const ShimmerLoadingWidget(
                            //         height: 16,
                            //         width: 100,
                            //         borderRadius: 6,
                            //       )
                            //     : Text(
                            //         "${value.memberArea?.country}",
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             color: greyColor.withOpacity(0.5)),
                            //       ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                    color: Color(0xFFF2F2F2),
                  ),
                  ItemSetting(
                    title: S.of(context).profile,
                    image: "profile.png",
                    onTap: () {
                      Nav.to(const ScreenProfile());
                    },
                  ),
                  // ItemSetting(
                  //   title: S.of(context).affiliate,
                  //   image: "icon_affiliate.png",
                  //   onTap: () async {
                  //     await context
                  //         .read<ProviderAuthAffiliate>()
                  //         .checkIsAffiliate(context);
                  //   },
                  // ),
                  ItemSetting(
                    title: S.of(context).qr_code,
                    image: "qris.png",
                    onTap: () async {
                      Nav.to(const ScreenQr());
                    },
                  ),
                  ItemSetting(
                    title: S.of(context).language,
                    image: "bahasa.png",
                    onTap: () {
                      Nav.to(ChangeLanguange(
                        onChanged: () {
                          setState(() {
                            widget.onLanguageChanged!();
                          });
                        },
                      ));
                    },
                  ),
                  ItemSetting(
                    title: S.of(context).change_password,
                    image: "password.png",
                    onTap: () {
                      Nav.to(const UpdatePassword());
                      setState(() {});
                    },
                  ),

                  DropdownHistory(isExpanded: isExpanded),
                  ItemSetting(
                    title: S.of(context).delete_account,
                    image: "disclaimer.png",
                    onTap: () {
                      Nav.to(const DeletedAccount());
                      setState(() {});
                    },
                  ),
                  ItemSetting(
                    title: S.of(context).setting,
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
                                                Nav.toAll(const LoginScreen());

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
                ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ExpansionTile(
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
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
