// import 'package:cool_app/generated/l10n.dart';
// import 'package:cool_app/presentation/pages/main/nav_home.dart';
// import 'package:cool_app/presentation/pages/user/reusable_invoice_screen.dart';
// import 'package:cool_app/presentation/theme/color_utils.dart';
// import 'package:cool_app/presentation/utils/money_formatter.dart';
// import 'package:cool_app/presentation/utils/nav_utils.dart';
// import 'package:cool_app/presentation/widgets/button_primary.dart';
// import 'package:decimal/decimal.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:midtrans_sdk/midtrans_sdk.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class NewMidtranScreen extends StatefulWidget {
//   final String? snapToken;
//   final String? id;
//   final String? name;
//   final DateTime? date;
//   final String? paymentType;
//   final String? quantity;
//   final String? discount;
//   final String? amount;

//   const NewMidtranScreen(
//       {super.key,
//       this.snapToken,
//       this.id,
//       this.name,
//       this.date,
//       this.paymentType,
//       this.quantity,
//       this.discount,
//       this.amount});

//   @override
//   _NewMidtranScreenState createState() => _NewMidtranScreenState();
// }

// class _NewMidtranScreenState extends State<NewMidtranScreen> {
//   MidtransSDK? _midtrans;

//   @override
//   void initState() {
//     super.initState();

//     initSDK();
//   }

//   void initSDK() async {
//     _midtrans = await MidtransSDK.init(
//       config: MidtransConfig(
//         clientKey: dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
//         merchantBaseUrl: dotenv.env['MIDTRANS_MERCHANT_BASE_URL'] ?? "",
//       ),
//     );
//     _midtrans?.setUIKitCustomSetting(
//       skipCustomerDetailsPages: true,
//     );
//     _midtrans!.callbackStatusTransaction((result) {
//       print(result.toJson());

//       if (result.transactionStatus == TransactionResultStatus.settlement ||
//           result.transactionStatus == TransactionResultStatus.capture) {
//         Nav.toAll(const NavMenuScreen());
//       } else if (result.transactionStatus == TransactionResultStatus.expire ||
//           result.transactionStatus == TransactionResultStatus.cancel) {
//         Nav.toAll(const NavMenuScreen());
//       } else if (result.transactionStatus == TransactionResultStatus.pending) {
//         Nav.back();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _midtrans?.removeTransactionFinishedCallback();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           S.of(context).payment,
//           style: TextStyle(color: primaryColor),
//         ),
//       ),
//       body: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(
//                 height: 16.0,
//               ),
//               Image.asset(
//                 "assets/icons/logo_cool_vertical.png",
//                 height: 60.0,
//               ),
//               const SizedBox(
//                 height: 48,
//               ),
//               widget.id != null
//                   ? itemPayment("ID", widget.id)
//                   : const SizedBox(),
//               widget.name != null
//                   ? itemPayment(S.of(context).customer, widget.name ?? "-")
//                   : const SizedBox(),
//               widget.date != null
//                   ? itemPayment(
//                       S.of(context).date,
//                       DateFormat("dd MMM yyyy")
//                           .format(widget.date ?? DateTime.now()))
//                   : const SizedBox(),
//               const SizedBox(
//                 height: 16,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(color: greyColor.withOpacity(0.5)),
//                     borderRadius: BorderRadius.circular(16)),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     widget.paymentType != null
//                         ? itemPaymentDetail(
//                             S.of(context).payment, widget.paymentType ?? "-")
//                         : const SizedBox(),
//                     Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
//                     widget.quantity != null
//                         ? itemPaymentDetail(
//                             S.of(context).items, widget.quantity ?? "-")
//                         : const SizedBox(),
//                     Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
//                     widget.discount != null
//                         ? itemPaymentDetail(S.of(context).discount,
//                             "${Decimal.parse(widget.discount ?? "0")}%")
//                         : const SizedBox(),
//                     Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
//                     widget.amount != null
//                         ? itemPaymentTotal(
//                             S.of(context).amount,
//                             MoneyFormatter.formatMoney(
//                               Decimal.parse(
//                                 widget.amount ?? "0",
//                               ),
//                               true,
//                             ).toString())
//                         : const SizedBox(),
//                   ],
//                 ),
//               )
//             ],
//           )),
//       bottomNavigationBar: Container(
//           margin: const EdgeInsets.all(20),
//           height: 54,
//           child: ButtonPrimary(
//             "Bayar Sekarang",
//             onPress: () async {
//               _midtrans?.startPaymentUiFlow(
//                 token: widget.snapToken,
//               );
//             },
//             radius: 10,
//           )),
//     );
//   }
// }
