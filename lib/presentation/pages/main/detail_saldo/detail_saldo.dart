import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_payment.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/response/affiliate/res_bank_account.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
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
  late TabController _tabController;
  TextEditingController nameBankC = TextEditingController();
  TextEditingController noRekC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    nameBankC =
        TextEditingController(text: widget.bankName?.data?.bankName ?? "-");
    noRekC =
        TextEditingController(text: widget.bankName?.data?.accountNo ?? "-");
    namaC =
        TextEditingController(text: widget.bankName?.data?.accountName ?? "-");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAffiliate>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset("images/buku/arrowleft.png")),
                title: Text(
                  "Detail Saldo",
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
                                "Saldo Anda",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${MoneyFormatter.formatMoney(value.dataAffiliasi?.totalSaldoAffiliate ?? "0", true)}",
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
                              onPressed: () {
                                if (stateUser.dataUser?.isAffiliate
                                        .toString() ==
                                    "1") {
                                  debugPrint("tes topup1");
                                  NotificationUtils.showDialogError(context,
                                      () {
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
                                      .getListTopUp(context);
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

                    // Card Rekening
                    Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFDFE5EE),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                namaC.text,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                namaC.text != "-" ? "${DateTime.now()}" : "-",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            nameBankC.text,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          SizedBox(height: 4),
                          Text(
                            noRekC.text,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Tab Bar
                    namaC.text == "-"
                        ? Center(
                            child: Text(""),
                          )
                        : TabBar(
                            controller: _tabController,
                            labelColor: Color(0xFF68CDF1),
                            unselectedLabelColor: Color(0xFF68CDF1),
                            // indicator: BoxDecoration(
                            //   color: Color(0xFF93F1FB),
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            tabs: [
                              Tab(text: S.of(context).all),
                              Tab(text: "Penambahan"),
                              Tab(text: "Penarikan"),
                            ],
                          ),

                    SizedBox(height: 10),

                    // TabBar View untuk Riwayat Transaksi
                    namaC.text == "-"
                        ? Center(
                            child: Text("No Data"),
                          )
                        : Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                TransactionList(),
                                TransactionList(filter: "topup"),
                                TransactionList(filter: "withdraw"),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ));
  }
}

// Komponen ListView untuk Riwayat Transaksi
class TransactionList extends StatelessWidget {
  final String? filter;
  TransactionList({super.key, this.filter});

  final List<Map<String, String>> transactions = [
    {
      "type": "topup",
      "amount": "+Rp100.000",
      "date": "10/02/2024",
      "desc": "Top Up Saldo"
    },
    {
      "type": "withdraw",
      "amount": "-Rp50.000",
      "date": "08/02/2024",
      "desc": "Penarikan Saldo"
    },
    {
      "type": "topup",
      "amount": "+Rp200.000",
      "date": "06/02/2024",
      "desc": "Top Up Saldo"
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredTransactions = transactions;
    if (filter != null) {
      filteredTransactions =
          transactions.where((tx) => tx["type"] == filter).toList();
    }

    return ListView.builder(
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        var transaction = filteredTransactions[index];
        bool isTopUp = transaction["type"] == "topup";

        return Column(
          children: [
            gapH20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Riwayat Transaksi",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Image.asset("images/tr.png")
                ],
              ),
            ),
            gapH20,
            ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction["amount"]!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isTopUp ? Colors.green : Colors.red,
                    ),
                  ),
                  gapH20,
                ],
              ),
              subtitle: Text(
                "Rekening",
                style: TextStyle(),
              ),
              trailing: Column(
                children: [
                  Text(
                    "${transaction["desc"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  gapH20,
                  Text("${transaction["date"]}"),
                ],
              ),
            ),
            Divider()
          ],
        );
      },
    );
  }
}
