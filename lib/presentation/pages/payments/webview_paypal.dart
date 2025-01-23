import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaypalWebViewScreen extends StatelessWidget {
  final String orderId;
  final String currencyPaypal;
  final String amountPaypal;

  const PaypalWebViewScreen({
    super.key,
    required this.orderId,
    required this.currencyPaypal,
    required this.amountPaypal,
  });

  @override
  Widget build(BuildContext context) {
    // Construct the URL
    final String url =
        "https://coolprojects.sabahloka.com/api/paypal/payment?order_id=$orderId&currency_paypal=$currencyPaypal&amount_paypal=$amountPaypal";

    return Scaffold(
      appBar: AppBar(
        title: const Text('PayPal Payment'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(url), // Convert the String to WebUri
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class PaypalWebViewScreen extends StatelessWidget {
//   final String orderId;
//   final String currencyPaypal;
//   final String amountPaypal;

//   const PaypalWebViewScreen({
//     super.key,
//     required this.orderId,
//     required this.currencyPaypal,
//     required this.amountPaypal,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Construct the URL
//     final String url =
//         "https://coolprojects.sabahloka.com/api/paypal/payment?order_id=$orderId&currency_paypal=$currencyPaypal&amount_paypal=$amountPaypal";

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PayPal Payment'),
//       ),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(
//           url: Uri.parse(url),
//         ),
//         initialOptions: InAppWebViewGroupOptions(
//           crossPlatform: InAppWebViewOptions(
//             javaScriptEnabled: true,
//           ),
//           android: AndroidInAppWebViewOptions(
//             useHybridComposition: true,
//           ),
//         ),
//       ),
//     );
//   }
// }
