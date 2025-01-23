// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/locals/preference_handler.dart';
import '../../../data/locals/shared_pref.dart';
import '../../../data/networks/endpoint/api_endpoint.dart';

class PreHomeScreen extends StatefulWidget {
  const PreHomeScreen({super.key});

  @override
  State<PreHomeScreen> createState() => _PreHomeScreenState();
}

class _PreHomeScreenState extends State<PreHomeScreen> {
  ProviderUser? providerUser;

  Future<void> _initializeData() async {
    await providerUser?.getUser(context);
    await providerUser?.getMemberArea(context);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      cekSession();
    });
    cekSession();
    providerUser = Provider.of<ProviderUser>(context, listen: false);

    _initializeData();
  }

  cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Consumer<ProviderBook>(
        builder: (BuildContext context, value, Widget? child) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: value.dataPre?.logo == null
                    ? Container()
                    : Image.network(
                        "${value.dataPre?.logo}",
                        height: 60,
                        width: 194,
                      ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (value.isPreHome) ...[
                    CircularProgressWidget(
                      color: whiteColor,
                    ),
                  ] else ...[
                    Center(
                      child: value.dataPre?.image == null
                          ? Container()
                          : Image.network(
                              "${value.dataPre?.image}",
                              height: 190,
                              width: MediaQuery.of(context).size.width - 100,
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                  ],
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      value.dataPre?.title?.homeTitle ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    // value.dataPre?.greeting?.preHomeGreeting ?? ""
                    S
                        .of(context)
                        .congratulation_you_have_become_a_regular_member,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: MaterialButton(
                      elevation: 0,
                      height: 55,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      textColor: primaryColor,
                      onPressed: () {
                        Nav.toAll(const NavMenuScreen());
                      },
                      child: Text(
                        S.of(context).next,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
