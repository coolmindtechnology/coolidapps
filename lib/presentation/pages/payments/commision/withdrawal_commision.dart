import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_promotion.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/response/payments/res_get_data_top_up.dart';
import 'package:provider/provider.dart';

class WithdrawalCommision extends StatefulWidget {
  const WithdrawalCommision({super.key});

  @override
  State<WithdrawalCommision> createState() => _WithdrawalCommisionState();
}

class _WithdrawalCommisionState extends State<WithdrawalCommision> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController emailController = TextEditingController(text: "sb-ep6zi32672359@business.example.com");
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Buka keyboard secara otomatis setelah widget dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  String _getMinimumWd() {
    final itemQty1 = dataGlobal.dataTopUp?.data?.firstWhere(
      (item) => item.qty == 1,
      orElse: () =>
          DataListTopUp(name: "Profiling x1", price: 250000, intlPrice: 365000),
    );

    final priceQty1 = dataGlobal.isIndonesia
        ? (itemQty1?.price?.toString() ?? "250.000")
        : (itemQty1?.intlPrice?.toString() ?? "365.000");

    return priceQty1;
  }

  @override
  void dispose() {
    amountController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Withdrawal',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildCommissionCard(),
              SizedBox(height: 20),
              _buildPaymentGateway(),
              // _buildEmailInput(),
              SizedBox(height: 20),
              _buildWithdrawalSection(),
              Consumer<PromotionProvider>(builder: (context, provider, child) {
                return GlobalButton(
                    onPressed: provider.isWithdrawing
                        ? null
                        : () {NotificationUtils.showSimpleDialog2(context, S.of(context).yakinWithdrawal + ' ${amountController.text} USD ?',
                        textButton1: S.of(context).yes,
                        textButton2: S.of(context).no,
                      onPress1: () {
                        if (emailController.text.isNotEmpty &&
                            amountController.text.isNotEmpty) {
                          provider.withdrawCommission(
                              email: emailController.text,
                              amount: amountController.text,
                              context: context
                          );
                          Nav.back();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(S.of(context).isiSemuaKolom)),
                          );
                        }
                      },
                      onPress2: () {
                          Nav.back();
                      }
                    );},
                    color: primaryColor,
                    text: S.of(context).Next);
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommissionCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFEFDCD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 15, bottom: 8, top: 8),
        child: Row(
          children: [
            Image.asset(
              AppAsset.icRealMoney,
            ),
            gapW10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).komisiKu,
                  style: TextStyle(
                    color: DarkYellow,
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "${(dataGlobal.dataPromotion?.totalComission == null || dataGlobal.dataPromotion?.totalComission.toString().isEmpty == true) ? '0' : dataGlobal.dataPromotion?.totalComission.toString()}",
                  style: TextStyle(
                    color: DarkYellow,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentGateway() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Gateway",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              "You will be redirected to the PayPal payment page. Please ensure that you already have a PayPal account beforehand.",
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('images/logos_paypal.png'),
                gapW10,
                Expanded(
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",

                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.grey.shade200,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                //   onPressed: () {},
                //   child: Text("Paypal", style: TextStyle(color: Colors.black)),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildWithdrawalSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Withdrawal",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            "Minimum withdrawal amount : 10x Profiling (${_getMinimumWd()})",
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          SizedBox(height: 15),
          SizedBox(height: 8),
          TextField(
            controller: amountController,
            focusNode: _focusNode, // Tambahkan FocusNode
            decoration: InputDecoration(
              prefixText: "USD ",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
    );
  }
}
