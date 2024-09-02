import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_app/data/provider/provider_boarding.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/auth/login_screen.dart';
import 'package:cool_app/presentation/pages/auth/register_screen.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObBoarding2 extends StatefulWidget {
  final String? codeReferral;
  const ObBoarding2({super.key, this.codeReferral});

  @override
  State<ObBoarding2> createState() => _ObBoarding2State();
}

class _ObBoarding2State extends State<ObBoarding2> {
  @override
  void initState() {
    context.read<ProviderBoarding>().getSOnBoarding(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Consumer<ProviderBoarding>(builder: (context, state, __) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(state.urlImageOnBoarding ?? ""),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: state.isLoading == true
                        ? Container()
                        : CachedNetworkImage(
                            imageUrl: state.urlLogoOnBoarding ?? "",
                            height: 60,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: whiteColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                                "assets/icons/material-symbols-light_error-outline.png"),
                          ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          state.dataOnBoarding?.greeting?.onBoardingGreeting ??
                              "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          state.dataOnBoarding?.title?.onBoardingTitle ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 55,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.white,
                              textColor: primaryColor,
                              child: Text(
                                S.of(context).sign_in,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Nav.to(const LoginScreen());
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 55,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      width: 1, color: Colors.white)),
                              textColor: Colors.white,
                              child: Text(
                                S.of(context).register,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Nav.to(const RegisterScreen());
                              })
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
