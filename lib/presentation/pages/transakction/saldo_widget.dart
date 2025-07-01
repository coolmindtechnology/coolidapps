// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:async';

import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/provider/provider_transaksi_affiliate.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/payments/componen/saldo_widget.dart';
import 'package:coolappflutter/presentation/pages/transakction/component/transaction_filter_date.dart';
import 'package:coolappflutter/presentation/pages/transakction/topup_saldo.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading_widget_many.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:coolappflutter/presentation/pages/transakction/component/header_topup_widget.dart';
import 'package:coolappflutter/presentation/pages/transakction/component/income_card_widget.dart';
import 'package:coolappflutter/presentation/pages/transakction/component/output_card_widget.dart';
import 'package:provider/provider.dart';

class SaldoWidget extends StatefulWidget {
  final TabController? controller;
  const SaldoWidget(this.controller, {super.key});

  @override
  State<SaldoWidget> createState() => _SaldoWidgetState();
}

class _SaldoWidgetState extends State<SaldoWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  String filter = "";
  String filterReduction = "";
  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll &&
        context.read<ProviderTransaksiAffiliate>().hasMoreHistoryIncomeSaldo) {
      context
          .read<ProviderTransaksiAffiliate>()
          .getHistoryTopup(context, filter);
    }
    if (currentScroll == maxScroll &&
        context
            .read<ProviderTransaksiAffiliate>()
            .hasMoreHistoryReductionSaldo) {
      context
          .read<ProviderTransaksiAffiliate>()
          .getHistorySaldoReduction(context, filterReduction);
    }
  }

  @override
  void initState() {
    cekSession();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: selectedIndex,
    );
    _scrollController.addListener(onScroll);
    Future.microtask(() {
      context
          .read<ProviderTransaksiAffiliate>()
          .getSingleTotalSaldoAffiliate(context);
      context
          .read<ProviderTransaksiAffiliate>()
          .refreshHistoryIncomeSaldo(context, filter);
      context
          .read<ProviderTransaksiAffiliate>()
          .refreshHistoryReductionSaldo(context, filterReduction);
    });

    super.initState();
  }

  cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
    if (ceklanguage == null) {
      Prefs().setLocale('en_US', () {
        setState(() {
          S.load(Locale('en_US'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    } else {
      Prefs().setLocale('$ceklanguage', () {
        setState(() {
          S.load(Locale('$ceklanguage'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    context
        .read<ProviderTransaksiAffiliate>()
        .getSingleTotalSaldoAffiliate(context);
    if (selectedIndex == 0) {
      context
          .read<ProviderTransaksiAffiliate>()
          .refreshHistoryIncomeSaldo(context, filter);
    } else if (selectedIndex == 1) {
      context
          .read<ProviderTransaksiAffiliate>()
          .refreshHistoryReductionSaldo(context, filterReduction);
    }
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderTransaksiAffiliate>(builder: (context, state, _) {
      return CustomMaterialIndicator(
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return const RefreshIconWidget();
        },
        onRefresh: refreshList,
        key: refreshKey,
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SaldoWidgetContainer(
                title: S.of(context).Your_Balance,
                subtitle: S.of(context).top_up + "+",
                saldo:  "${MoneyFormatter.formatMoney(state.dataSingleTotalSaldoAffiliate?.totalSaldoAffiliate.toString(), true)}",
                backgroundColor: primaryColor,
                assetImage: 'images/IcWallet.png',
                onTap: () async {
                  var data = await Nav.to(const TopupSaldoPage());
                  if (data != null) {
                    if (data == "topup_affiliate") {
                      context
                          .read<ProviderTransaksiAffiliate>()
                          .getSingleTotalSaldoAffiliate(context);
                      context
                          .read<ProviderTransaksiAffiliate>()
                          .refreshHistoryIncomeSaldo(context, filter);

                    }
                  }
                },
              ),
                  // HeaderTopupWidget(
                  //   title: S.of(context).total_balance,
                  //   isLoading: state.isGetSingleTotalSaldoAffiliate,
                  //   textButton: S.of(context).top_up,
                  //   nominal:
                  //       "${MoneyFormatter.formatMoney(state.dataSingleTotalSaldoAffiliate?.totalSaldoAffiliate.toString(), true)}",
                  //   onPress: () async {
                  //     var data = await Nav.to(const TopupSaldoPage());
                  //     if (data != null) {
                  //       if (data == "topup_affiliate") {
                  //         context
                  //             .read<ProviderTransaksiAffiliate>()
                  //             .getSingleTotalSaldoAffiliate(context);
                  //         context
                  //             .read<ProviderTransaksiAffiliate>()
                  //             .refreshHistoryIncomeSaldo(context, filter);
                  //       }
                  //     }
                  //   },
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
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
                  Text(S.of(context).top_up),
                ],
              ),
            ),
            Tab(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(S.of(context).deduction),
                ],
              ),
            ),
          ]),
    );
  }
}

class OutcomeWidget extends StatefulWidget {
  final ProviderTransaksiAffiliate state;
  OutcomeWidget({
    super.key,
    required this.state,
    this.filter = "",
  });
  String filter;

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
                    widget.state
                        .refreshHistoryReductionSaldo(context, widget.filter);
                  }
                },
              )
            ],
          ),
        ),
        widget.state.isLoadingHistorySaldoReduction == true
            ? const ShimmerLoadingWidgetMany(
                itemBuilderHeight: 50,
                itemCount: 5,
                separatorBuilderHeight: 8,
              )
            : widget.state.listHistoryReductionSaldo.isEmpty
                ? Center(child: Text(S.of(context).no_data))
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.state.hasMoreHistoryReductionSaldo
                        ? widget.state.listHistoryReductionSaldo.length + 1
                        : widget.state.listHistoryReductionSaldo.length,
                    itemBuilder: (context, index) {
                      if (index <
                          widget.state.listHistoryReductionSaldo.length) {
                        var data =
                            widget.state.listHistoryReductionSaldo[index];
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
                          .refreshHistoryIncomeSaldo(context, widget.filter);
                    }
                  },
                  child: const Icon(Icons.filter_list_outlined))
            ],
          ),
        ),
        widget.state.isLoadingHistoryTopup == true
            ? const ShimmerLoadingWidgetMany(
                itemBuilderHeight: 50,
                itemCount: 5,
                separatorBuilderHeight: 8,
              )
            : widget.state.listHistoryTopupSaldo.isEmpty
                ? Center(child: Text(S.of(context).no_data))
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.state.hasMoreHistoryIncomeSaldo
                        ? widget.state.listHistoryTopupSaldo.length + 1
                        : widget.state.listHistoryTopupSaldo.length,
                    itemBuilder: (context, index) {
                      if (index < widget.state.listHistoryTopupSaldo.length) {
                        var data = widget.state.listHistoryTopupSaldo[index];
                        return GestureDetector(
                          onTap: () {
                            widget.state.getInvoiceSaldo(
                                context, data.id.toString() ?? "");
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
