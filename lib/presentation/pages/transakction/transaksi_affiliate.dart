import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/transakction/real_money_widget.dart'
    as real_money;
import 'package:coolappflutter/presentation/pages/transakction/saldo_widget.dart'
    as saldo;
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class TransaksiAffiliatePage extends StatefulWidget {
  final int Function()? initialTab;
  final void Function(Function(int newIndex) changeTabAffiliate) tabChanger;

  const TransaksiAffiliatePage({
    super.key,
    this.initialTab,
    required this.tabChanger,
  });

  @override
  State<TransaksiAffiliatePage> createState() => _TransaksiAffiliatePageState();
}

class _TransaksiAffiliatePageState extends State<TransaksiAffiliatePage>
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
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabbarTransaksiWidget(tabController: tabController),
          Expanded(
              child: TabBarView(controller: tabController, children: [
            saldo.SaldoWidget(tabController),
            real_money.RealMoneyWidget(tabController)
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
