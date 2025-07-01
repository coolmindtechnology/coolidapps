import 'dart:developer';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_brain_activation.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/pages/payments/payment_failed_page.dart';
import 'package:coolappflutter/presentation/pages/payments/payment_success_page.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../generated/l10n.dart';

class MidtransScreen extends StatefulWidget {
  final Function? onUpdate;
  final String? snapToken, codeOrder, typePayment;
  final String? fromPage;
  final bool isMultiple;
  const MidtransScreen({
    super.key,
    this.snapToken,
    this.onUpdate,
    this.codeOrder,
    this.typePayment,
    this.fromPage,
    this.isMultiple = false,
  });

  @override
  State<MidtransScreen> createState() => _MidtransScreenState();
}

class _MidtransScreenState extends State<MidtransScreen> {
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();
  String url = "";
  double progress = 0;

  PullToRefreshController? pullToRefreshController;
  @override
  void initState() {
    super.initState();

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            options: PullToRefreshOptions(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderBrainActivation();
      },
      child: Consumer<ProviderBrainActivation>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).payment,
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
          ),
          body: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(
              url: WebUri("${ApiEndpoint.payPreference}${widget.snapToken}"),
              headers: {
                'Authorization': dataGlobal.token,
              },
            ),
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                    verticalScrollBarEnabled: false,
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: false,
                    javaScriptEnabled: true,
                    javaScriptCanOpenWindowsAutomatically: true),
                android: AndroidInAppWebViewOptions(
                  overScrollMode: AndroidOverScrollMode.OVER_SCROLL_NEVER,
                  useHybridComposition: true,
                ),
                ios: IOSInAppWebViewOptions(
                    allowsInlineMediaPlayback: true, scrollsToTop: false)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url1) {
              setState(() {
                url = "${Uri.parse(url1.toString())}";
              });

              if (kDebugMode) {
                print("ON LOAD Start $url");
              }
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;
              if (kDebugMode) {
                print(uri);
              }

              if (![
                "http",
                "https",
                "file",
                "chrome",
                "data",
                "javascript",
                "about"
              ].contains(uri.scheme)) {
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(
                    url,
                  );
                  webViewController?.goBack();
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              pullToRefreshController?.endRefreshing();
              setState(() {
                this.url = url.toString();
              });
              if (kDebugMode) {
                log("ONLOADSTOP $url");
              }

              if (url != null) {
                // payment gopay
                // if (url.toString().startsWith("https://gopay.co.id")) {
                //   await launchUrl(url);
                //   Nav.replace(MidtransScreen(
                //     snapToken: widget.snapToken,
                //   ));
                // }
                // payment gojek
                // if (url.toString().startsWith("https://gojek.link")) {
                //   await launchUrl(url);
                //   Nav.replace(MidtransScreen(
                //     snapToken: widget.snapToken,
                //   ));
                // }

                // payment shopee
                // if (url.toString().startsWith("https://shopee.co.id")) {
                //   await launchUrl(url);
                //   Nav.replace(MidtransScreen(
                //     snapToken: widget.snapToken,
                //   ));
                // }

                if (url.toString().startsWith("https://play.google.com")) {
                  webViewController?.goBack();
                }
                //success payment
                if (url.toString().contains(
                        'status_code=200&transaction_status=settlement') ||
                    url.toString().contains(
                        'status_code=200&transaction_status=capture')) {
                  if (widget.fromPage == "profiling") {
                    widget.onUpdate!();
                    Nav.toAll(const NavMenuScreen());
                  } else if (widget.fromPage == "register_affiliate") {
                    Nav.back(data: "affiliate");
                  } else if (widget.fromPage == "topup_affiliate") {
                    Nav.back();
                    Nav.back();
                    Nav.back(data: "topup_affiliate");
                  } else {
                    Nav.to(const PaymentSuccessPage());
                  }
                }

                //failed payment
                if (url
                    .toString()
                    .contains('status_code=202&transaction_status=deny')) {
                  if (widget.fromPage == "profiling") {
                    Nav.back();
                    if (widget.isMultiple) {
                      Nav.back();
                    }
                  } else {
                    Nav.to(const PaymentFailedPage());
                  }
                }
                // close midtrans

                if (url.toString().contains('midtrans-on-close')) {
                  Nav.toAll(NavMenuScreen());
                }
              } else {
                Nav.back();
              }
            },
          ),
        ),
      ),
    );
  }
}
