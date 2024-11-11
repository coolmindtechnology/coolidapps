// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:coolappflutter/data/provider/provider_transaksi_affiliate.dart';
import 'package:coolappflutter/presentation/pages/transakction/component/transaction_filter_date.dart';
import 'package:coolappflutter/presentation/pages/transakction/withdraw.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:coolappflutter/presentation/pages/transakction/component/header_topup_widget.dart';
import 'package:coolappflutter/presentation/pages/transakction/component/income_card_widget.dart';
import 'package:coolappflutter/presentation/pages/transakction/component/output_card_widget.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../utils/circular_progress_widget.dart';
import '../../widgets/shimmer_loading_widget_many.dart';

class RealMoneyWidget extends StatefulWidget {
  final TabController? controller;
  const RealMoneyWidget(this.controller, {super.key});

  @override
  State<RealMoneyWidget> createState() => _RealMoneyWidgetState();
}

class _RealMoneyWidgetState extends State<RealMoneyWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int selectedIndex = 0;
  String filter = "";
  String filterWithdrawal = "";

  final ScrollController _scrollController = ScrollController();
  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll &&
        context
            .read<ProviderTransaksiAffiliate>()
            .hasMoreHistoryIncomeRealMoney) {
      context
          .read<ProviderTransaksiAffiliate>()
          .getHistoryRealMoney(context, filter);
    }

    if (currentScroll == maxScroll &&
        context
            .read<ProviderTransaksiAffiliate>()
            .hasMoreHistoryIncomeRealMoneyWithdrawal) {
      context
          .read<ProviderTransaksiAffiliate>()
          .getHistoryRealMoneyWithdrawal(context, filterWithdrawal);
    }
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: selectedIndex,
    );
    _scrollController.addListener(onScroll);
    Future.microtask(() {
      context
          .read<ProviderTransaksiAffiliate>()
          .getSingleTotalRealMoney(context);
      context
          .read<ProviderTransaksiAffiliate>()
          .refreshHistoryIncomeRealMoney(context, filter);
      context
          .read<ProviderTransaksiAffiliate>()
          .refreshHistoryRealMoneyWithdrawal(context, filterWithdrawal);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    context.read<ProviderTransaksiAffiliate>().getSingleTotalRealMoney(context);
    if (selectedIndex == 0) {
      context
          .read<ProviderTransaksiAffiliate>()
          .refreshHistoryIncomeRealMoney(context, filter);
    } else if (selectedIndex == 1) {
      context
          .read<ProviderTransaksiAffiliate>()
          .refreshHistoryRealMoneyWithdrawal(context, filterWithdrawal);
    }
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderTransaksiAffiliate>(builder: (context, state, _) {
      return CustomMaterialIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return const RefreshIconWidget();
        },
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderTopupWidget(
                    title: S.of(context).total_real_money,
                    textButton: S.of(context).withdraw,
                    isLoading: state.isGetSingleTotalRealMoney,
                    nominal:
                        "${MoneyFormatter.formatMoney(state.dataSingleTotalRealMoney?.totalRealMoney, true)}",
                    onPress: () async {
                      var data = await Nav.to(const Withdraw());
                      if (data == "withdraw") {
                        state.getSingleTotalRealMoney(context);
                        state.refreshHistoryIncomeRealMoney(context, filter);
                        state.refreshHistoryRealMoneyWithdrawal(
                            context, filterWithdrawal);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TabbarSaldoWidget(
                    tabController: _tabController,
                    onTap: (int index) {
                      setState(() {
                        selectedIndex = index;
                        _tabController.animateTo(index);
                      });
                    },
                  ),
                  IndexedStack(
                    index: selectedIndex,
                    children: <Widget>[
                      Visibility(
                        maintainState: true,
                        visible: selectedIndex == 0,
                        child: IncomeWidget(state: state, filter: filter),
                      ),
                      Visibility(
                        maintainState: true,
                        visible: selectedIndex == 1,
                        child: OutcomeWidget(state: state),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class TabbarSaldoWidget extends StatelessWidget {
  const TabbarSaldoWidget({
    super.key,
    required TabController tabController,
    required this.onTap,
  }) : _tabController = tabController;

  final TabController _tabController;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: TabBar(
          controller: _tabController,
          indicatorColor: primaryColor,
          labelColor: whiteColor,
          unselectedLabelColor: primaryColor,
          labelStyle: const TextStyle(
            fontSize: 16,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
          ),
          indicator: BoxDecoration(
            color: primaryColor,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: onTap,
          tabs: [
            Tab(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(S.of(context).income),
                ],
              ),
            ),
            Tab(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(S.of(context).withdrawal),
                ],
              ),
            ),
          ]),
    );
  }
}

class OutcomeWidget extends StatefulWidget {
  final ProviderTransaksiAffiliate state;
  String filter;
  OutcomeWidget({
    super.key,
    required this.state,
    this.filter = "",
  });

  @override
  State<OutcomeWidget> createState() => _OutcomeWidgetState();
}

class _OutcomeWidgetState extends State<OutcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).list,
                style: const TextStyle(fontSize: 20),
              ),
              GestureDetector(
                child: const Icon(Icons.filter_list_outlined),
                onTap: () async {
                  var data = await showDialog(
                      context: context,
                      useSafeArea: false,
                      builder: (context) => const TransactionFilterDialog());

                  if (data != null) {
                    setState(() {
                      widget.filter = data;
                    });
                    widget.state.refreshHistoryRealMoneyWithdrawal(
                        context, widget.filter);
                  }
                },
              )
            ],
          ),
        ),
        widget.state.isLoadingHistoryRealMoneyWithdrawal == true
            ? const ShimmerLoadingWidgetMany(
                itemBuilderHeight: 50,
                itemCount: 5,
                separatorBuilderHeight: 8,
              )
            : widget.state.listHistoryRealMoneyWithdrawal.isEmpty
                ? Center(child: Text(S.of(context).no_data))
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget
                            .state.hasMoreHistoryIncomeRealMoneyWithdrawal
                        ? widget.state.listHistoryRealMoneyWithdrawal.length + 1
                        : widget.state.listHistoryRealMoneyWithdrawal.length,
                    itemBuilder: (context, index) {
                      if (index <
                          widget.state.listHistoryRealMoneyWithdrawal.length) {
                        var data =
                            widget.state.listHistoryRealMoneyWithdrawal[index];
                        return OutcomeCardWidget(
                          nominal: "${data.amount}",
                          status: "${data.status}",
                          date: data.createdAt,
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(15),
                          child: CircularProgressWidget(),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                          thickness: 1, color: greyColor.withOpacity(0.1));
                    },
                  )
      ],
    );
  }
}

class IncomeWidget extends StatefulWidget {
  final ProviderTransaksiAffiliate state;
  String filter;
  IncomeWidget({
    super.key,
    required this.state,
    this.filter = "",
  });

  @override
  State<IncomeWidget> createState() => _IncomeWidgetState();
}

class _IncomeWidgetState extends State<IncomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).list,
                style: const TextStyle(fontSize: 20),
              ),
              GestureDetector(
                child: const Icon(Icons.filter_list_outlined),
                onTap: () async {
                  var data = await showDialog(
                      context: context,
                      useSafeArea: false,
                      builder: (context) => const TransactionFilterDialog());

                  if (data != null) {
                    setState(() {
                      widget.filter = data;
                    });
                    widget.state
                        .refreshHistoryIncomeRealMoney(context, widget.filter);
                  }
                },
              )
            ],
          ),
        ),
        widget.state.isLoadingHistoryRealMoney == true
            ? const ShimmerLoadingWidgetMany(
                itemBuilderHeight: 50,
                itemCount: 5,
                separatorBuilderHeight: 8,
              )
            : widget.state.listHistoryRealMoney.isEmpty
                ? Center(child: Text(S.of(context).no_data))
                : ListView.separated(
                    itemCount: widget.state.hasMoreHistoryIncomeRealMoney
                        ? widget.state.listHistoryRealMoney.length + 1
                        : widget.state.listHistoryRealMoney.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < widget.state.listHistoryRealMoney.length) {
                        var data = widget.state.listHistoryRealMoney[index];
                        return GestureDetector(
                          onTap: () {
                            widget.state.getInvoiceRealMoney(
                                context, data.id.toString());
                          },
                          child: IncomeCardWidget(
                            nominal: "${data.amount}",
                            date: data.createdAt,
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(15),
                          child: CircularProgressWidget(),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                          thickness: 1, color: greyColor.withOpacity(0.1));
                    },
                  )
      ],
    );
  }
}
