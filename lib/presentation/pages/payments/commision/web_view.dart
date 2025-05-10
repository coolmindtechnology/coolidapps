import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/payments/commision/commision_dashboard.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:async';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late InAppWebViewController webViewController;
  bool isPageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))), // Pastikan URL benar
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onTitleChanged: (controller, title) {
                if (title?.trim() == 'Successfully Withdrawal Process') {
                  setState(() {
                    isPageLoaded = true;
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GlobalButton(
              onPressed: isPageLoaded
                  ? () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CommisionDashboard()),
                );
              } : null,
              color: isPageLoaded ? primaryColor : Colors.grey,
              text: S.of(context).next,
            ),
          ),
        ],
      ),
    );
  }
}
