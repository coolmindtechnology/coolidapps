import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_payment.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/response/affiliate/res_bank_account.dart';
import 'package:coolappflutter/data/response/payments/res_history_topup.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/payments/invoice_screen.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailSaldoPage extends StatefulWidget {
  const DetailSaldoPage({super.key, this.onUpdate, this.bankName});
  final Function? onUpdate;
  final ResBankAccount? bankName;

  @override
  _DetailSaldoPageState createState() => _DetailSaldoPageState();
}

class _DetailSaldoPageState extends State<DetailSaldoPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProviderPayment>().getHistoryTopup(
        context,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("images/buku/arrowleft.png")),
        title: Text(
          S.of(context).total_balance,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Card Saldo
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF4CCBF4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).my_balance,
                        style: TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${MoneyFormatter.formatMoney(dataGlobal.dataUser?.totalDeposit ?? "0", true)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Consumer<ProviderUser>(
                      builder: (context, stateUser, __) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (stateUser.dataUser?.isAffiliate
                                .toString() ==
                                "1") {
                              debugPrint("tes topup1");
                              NotificationUtils.showDialogError(
                                  context, () {
                                Nav.back();
                              },
                                  widget: Text(
                                    S
                                        .of(context)
                                        .feature_unavailable_affiliate,
                                    textAlign: TextAlign.center,
                                  ));
                            } else {
                              //
                              debugPrint("tes topup2");

                              context
                                  .read<ProviderPayment>()
                                  .cekListTopUp(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Menghilangkan border radius
                                side: BorderSide(
                                    color: Colors
                                        .transparent), // Menghilangkan border
                              ),
                              backgroundColor: Colors.white),
                          child: Text("Top Up +"),
                        );
                      })
                ],
              ),
            ),
            SizedBox(height: 20),
            Consumer<ProviderPayment>(
              builder: (BuildContext context, value, Widget? child) =>
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: value.isLoadingHistoryTopu
                        ? Column(
                      children: [
                        ShimmerLoadingWidget(
                            height: 54, width: MediaQuery.of(context).size.width),
                        const SizedBox(
                          height: 8,
                        ),
                        ShimmerLoadingWidget(
                            height: 54, width: MediaQuery.of(context).size.width),
                        const SizedBox(
                          height: 8,
                        ),
                        ShimmerLoadingWidget(
                            height: 54, width: MediaQuery.of(context).size.width)
                      ],
                    )
                        : value.listDataHistoryTopup.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "images/no_profiling.png",
                              width: 70,
                              height: 70,
                            ),
                          ),
                          Text(
                            S.of(context).no_data,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                        : value.getFilteredHistory("Paid").isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "images/no_profiling.png",
                              width: 70,
                              height: 70,
                            ),
                          ),
                          Text(
                            S.of(context).no_data,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                        : ListView.separated(
                        itemBuilder: (context, index) {
                          DataHistoryTopup data =
                          value.getFilteredHistory("Paid")[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            child: ListTile(
                              onTap: () {
                                Nav.to(InvoiceScreen(
                                    isHistory: true, data: data));
                                value.getInvoice(
                                    context, data.orderId.toString() ?? "");
                              },
                              title: Text(
                                data.createdAt.toString().substring(0, 10),
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${data.orderId}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              trailing: const Icon(Icons.book),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container();
                          // Divider(
                          //   thickness: 2,
                          //   color: greyColor.withOpacity(0.2),
                          // );
                        },
                        itemCount: value.getFilteredHistory("Paid").length),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
