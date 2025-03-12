// import 'dart:async';
//
// import 'package:coolappflutter/data/apps/app_sizes.dart';
// import 'package:coolappflutter/data/locals/preference_handler.dart';
// import 'package:coolappflutter/data/locals/shared_pref.dart';
// import 'package:coolappflutter/generated/l10n.dart';
// import 'package:coolappflutter/presentation/pages/payments/componen/rekening_widget.dart';
// import 'package:coolappflutter/presentation/pages/payments/componen/saldo_widget.dart';
// import 'package:coolappflutter/presentation/pages/transakction/topup_saldo.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/utils/nav_utils.dart';
// import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class DetailSaldoAff extends StatefulWidget {
//   const DetailSaldoAff({super.key});
//
//   @override
//   State<DetailSaldoAff> createState() => _DetailSaldoAffState();
// }
//
// class _DetailSaldoAffState extends State<DetailSaldoAff> {
//   String selectedOption = "Hari ini"; // Default pilihan
//
//   @override
//   void initState() {
//     cekSession();
//   }
//
//   final List<Map<String, String>> dummyTransactions = [
//     {"type": "Top Up", "amount": "+ Rp200.000", "source": "Rekening", "date": "2025-02-12"},
//     {"type": "Pengurangan", "amount": "- Rp200.000", "source": "CoolPoints", "date": "2025-02-11"},
//     {"type": "Top Up", "amount": "+ Rp200.000", "source": "Rekening", "date": "2025-02-05"},
//     {"type": "Pengurangan", "amount": "- Rp200.000", "source": "CoolPoints", "date": "2025-01-13"},
//   ];
//
//   DateTime _getFilteredDate(String option) {
//     DateTime now = DateTime.now();
//     switch (option) {
//       case "Hari ini":
//         return now;
//       case "Kemarin":
//         return now.subtract(Duration(days: 1));
//       case "7 hari yang lalu":
//         return now.subtract(Duration(days: 7));
//       case "30 hari yang lalu":
//         return now.subtract(Duration(days: 30));
//       case "90 hari yang lalu":
//         return now.subtract(Duration(days: 90));
//       default:
//         return now;
//     }
//   }
//
//   List<Map<String, String>> _getFilteredTransactions() {
//     DateTime filterDate = _getFilteredDate(selectedOption);
//     return dummyTransactions.where((transaction) {
//       DateTime transactionDate = DateFormat('yyyy-MM-dd').parse(transaction["date"]!);
//       return transactionDate.isAfter(filterDate);
//     }).toList();
//   }
//
//   void _showFilterDialog() {
//     String tempSelectedOption = selectedOption; // Menyimpan pilihan sementara
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Filter",style: TextStyle(fontSize: 16),),
//               IconButton(onPressed: () {
//                 Navigator.pop(context);
//               }, icon: Icon(CupertinoIcons.xmark,color: Colors.black,size: 16))
//             ],
//           ),
//           content: StatefulBuilder(
//             builder: (context, setState) {
//               return DropdownButton<String>(
//                 isExpanded: true,
//                 value: tempSelectedOption,
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     setState(() {
//                       tempSelectedOption = newValue;
//                     });
//                   }
//                 },
//                 items: [
//                   "Hari ini",
//                   "Kemarin",
//                   "7 hari yang lalu",
//                   "30 hari yang lalu",
//                   "90 hari yang lalu"
//                 ].map((String option) {
//                   return DropdownMenuItem<String>(
//                     value: option,
//                     child: Text(option),
//                   );
//                 }).toList(),
//               );
//             },
//           ),
//           actions: [
//             SizedBox(
//               width: double.infinity, // Pastikan tombol terisi penuh di dalam dialog
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Agar tombol rata
//                 children: [
//                   // Tombol Reset
//                   Expanded(
//                     child: GlobalButton(
//                       onPressed: () {
//                         setState(() {
//                           selectedOption = "Hari ini"; // Reset ke default
//                         });
//                         Navigator.pop(context);
//                       },
//                       color: whiteColor,
//                       text: 'Reset',
//                       textStyle: TextStyle(color: primaryColor),
//                     ),
//                   ),
//
//                   SizedBox(width: 10), // Spasi antar tombol
//
//                   // Tombol Simpan
//                   Expanded(
//                     child: GlobalButton(
//                       onPressed: () {
//                         setState(() {
//                           selectedOption = tempSelectedOption; // Simpan pilihan baru
//                         });
//                         Navigator.pop(context); // Tutup dialog setelah simpan
//                       },
//                       color: primaryColor,
//                       text: 'Simpan',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   cekSession() async {
//     dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
//     if (ceklanguage == null) {
//       Prefs().setLocale('en_US', () {
//         setState(() {
//           S.load(Locale('en_US'));
//           setState(() {});
//         });
//       });
//       Timer(Duration(seconds: 2), () {
//         Prefs().getLocale().then((locale) {
//           debugPrint(locale);
//
//           S.load(Locale(locale)).then((value) {});
//         });
//       });
//     } else {
//       Prefs().setLocale('$ceklanguage', () {
//         setState(() {
//           S.load(Locale('$ceklanguage'));
//           setState(() {});
//         });
//       });
//       Timer(Duration(seconds: 2), () {
//         Prefs().getLocale().then((locale) {
//           debugPrint(locale);
//
//           S.load(Locale(locale)).then((value) {});
//         });
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           title: Text(S.of(context).my_balance, style: TextStyle(color: whiteColor)),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: whiteColor),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           iconTheme: IconThemeData(color: whiteColor),
//           backgroundColor: primaryColor,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//           child: Column(
//             children: [
//               SaldoWidget(
//                 title: S.of(context).Your_Balance,
//                 subtitle: S.of(context).top_up + "+",
//                 saldo: 'Rp.200.000',
//                 backgroundColor: primaryColor,
//                 assetImage: 'images/IcWallet.png',
//                 onTap: () {
//                   Nav.to(const TopupSaldoPage());
//                 },
//               ),
//               // gapH40,
//               // RekeningInfoWidget(
//               //   nama: 'Fadlan Zholifunnas Soemarta',
//               //   tanggal: '12/09/2024',
//               //   namaBank: 'Bank Central Asia',
//               //   nomorRekening: '0918373103284210',
//               // ),
//               gapH20,
//
//               // Tombol Filter (Pop-up Dialog)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _showFilterDialog,
//                     child: Text(selectedOption, style: TextStyle(fontSize: 16)),
//                   ),
//                   Icon(Icons.calendar_month, size: 30),
//                 ],
//               ),
//
//               gapH20,
//               TabBar(
//                 labelColor: primaryColor,
//                 unselectedLabelColor: Colors.grey,
//                 indicatorColor: primaryColor,
//                 tabs: [
//                   Tab(text: 'Semua'),
//                   Tab(text: 'Penambahan'),
//                   // Tab(text: 'Penarikan'),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     buildTransactionList(_getFilteredTransactions()),
//                     buildTransactionList(_getFilteredTransactions()
//                         .where((t) => t["type"] == "Top Up").toList()),
//                     // buildTransactionList(_getFilteredTransactions()
//                     //     .where((t) => t["type"] == "Pengurangan").toList()),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildTransactionList(List<Map<String, String>> transactions) {
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: transactions.length,
//       itemBuilder: (context, index) {
//         final transaction = transactions[index];
//         return ListTile(
//           title: Text(
//             transaction["amount"]!,
//             style: TextStyle(
//               color: transaction["amount"]!.startsWith("+") ? Colors.green : Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(transaction["source"]!),
//           trailing: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(transaction["type"]!),
//               Text(transaction["date"]!, style: TextStyle(fontSize: 12)),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/transakction/real_money_widget.dart'
as real_money;
import 'package:coolappflutter/presentation/pages/transakction/saldo_widget.dart'
as saldo;
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class DetailSaldoAff extends StatefulWidget {
  final int Function()? initialTab;
  final void Function(Function(int newIndex) changeTabAffiliate) tabChanger;

  const DetailSaldoAff({
    super.key,
    this.initialTab,
    required this.tabChanger,
  });

  @override
  State<DetailSaldoAff> createState() => _DetailSaldoAffState();
}

class _DetailSaldoAffState extends State<DetailSaldoAff>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  void changeTabAffiliate(int newTab) {
    tabController.animateTo(newTab);
  }

  @override
  void initState() {
    super.initState();

    widget.tabChanger(changeTabAffiliate);
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab!(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          S.of(context).transaction,
          style: TextStyle(color: whiteColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: whiteColor), // Ikon Back
          onPressed: () {
            Navigator.pop(context); // Fungsi kembali ke halaman sebelumnya
          },
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TabbarTransaksiWidget(tabController: tabController),
          Expanded(
              child: TabBarView(controller: tabController, children: [
                saldo.SaldoWidget(tabController),
                // real_money.RealMoneyWidget(tabController)
              ]))
        ],
      ),
    );
  }
}

class TabbarTransaksiWidget extends StatelessWidget {
  const TabbarTransaksiWidget({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: [
        Tab(text: S.of(context).Balance),
        Tab(text: S.of(context).Real_Money),
      ],
      labelColor: primaryColor,
      unselectedLabelColor: primaryColor,
      indicatorColor: primaryColor,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 2,
    );
  }
}
