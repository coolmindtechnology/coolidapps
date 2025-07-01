import 'package:coolappflutter/data/response/brain_activation/res_list_brain_activation.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/presentation/pages/brain/brain_subscription_page.dart';
import 'package:coolappflutter/presentation/pages/brain/play_music_screen.dart';
import 'package:coolappflutter/presentation/pages/brain/term_conditions_brain.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/durasi_utils.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/provider/provider_brain_activation.dart';
import '../../../generated/l10n.dart';
import '../../utils/notification_utils.dart';

class ScreenBrainActivation extends StatefulWidget {
  final DataProfiling? data;
  final String? idLogResult;
  const ScreenBrainActivation(this.data, this.idLogResult, {super.key});

  @override
  State<ScreenBrainActivation> createState() => _ScreenBrainActivationState();
}

class _ScreenBrainActivationState extends State<ScreenBrainActivation> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    context
        .read<ProviderBrainActivation>()
        .getListBrain(context, widget.data?.idLogResult.toString() ?? "");
    context
        .read<ProviderBrainActivation>()
        .getShowPrice(context, widget.data?.idLogResult.toString() ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderBrainActivation>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              S.of(context).brain_activation,
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: CustomMaterialIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              return value.getListBrain(
                  context, widget.data?.idLogResult ?? "");
            },
            indicatorBuilder:
                (BuildContext context, IndicatorController controller) {
              return const RefreshIconWidget();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: value.isBrain
                  ? ListView.separated(
                      itemBuilder: (itemBuilder, index) => ShimmerLoadingWidget(
                          height: 85, width: MediaQuery.of(context).size.width),
                      separatorBuilder: (itemBuilder, index) => const SizedBox(
                            height: 12,
                          ),
                      itemCount: 5)
                  : Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    const TermConditionsBrain());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).terms_conditions_brain_act,
                                  style: TextStyle(color: greyColor),
                                ),
                                Icon(Icons.info_outline_rounded,
                                    color: greyColor)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: greyColor.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).enjoy_all_access,
                                      style: TextStyle(
                                          fontSize: 10, color: greyColor),
                                    ),
                                    Text(
                                      MoneyFormatter.formatMoney(
                                              value.showPrice?.data
                                                          ?.subscribePrice
                                                          .toString() !=
                                                      ''
                                                  ? Decimal.parse(value
                                                          .showPrice
                                                          ?.data
                                                          ?.subscribePrice
                                                          .toString() ??
                                                      "0")
                                                  : "0",
                                              true)
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              value.isCekAllowSubcribe
                                  ? const CircularProgressWidget()
                                  : ButtonPrimary(
                                      S.of(context).subscribe,
                                      onPress: () {
                                        value.checAllowSubcribe(
                                            context,
                                            widget.data?.idLogResult
                                                .toString());
                                        debugPrint(
                                            "cekz ${value.cekAllowSubcribe?.success}");
                                        if (value.cekAllowSubcribe?.success ==
                                            true) {
                                          Nav.to(BrainSubscriptionPage(
                                              idLogProfiling: widget
                                                  .data?.idLogResult
                                                  .toString(),
                                              typeSubcribe: value.showPrice
                                                      ?.data?.subscribeType
                                                      .toString() ??
                                                  ""));
                                          // Nav.to(BrainSubscriptionPage(
                                          //     idLogProfiling: widget
                                          //         .data?.idLogResult
                                          //         .toString()));
                                        }

                                        // Nav.to(BrainSubscriptionPage(
                                        //     idLogProfiling: widget
                                        //         .data?.idLogResult
                                        //         .toString(),
                                        //     typeSubcribe: value.showPrice?.data
                                        //             ?.subscribeType
                                        //             .toString() ??
                                        //         ""));
                                      },
                                      textStyle: const TextStyle(fontSize: 12),
                                      elevation: 0.0,
                                      radius: 8.0,
                                    )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                DataBrain data = value.listBrain[index];
                                return GestureDetector(
                                  onTap: () {
                                    // widget.data.logEbook != null && widget.data.logEbook?.status == "1" || widget.data.isPremium == "0"
                                    if ((data.status.toString() == "1" &&
                                            data.logBrain == null) ||
                                        (data.logBrain?.status.toString() ==
                                                "0" &&
                                            data.status.toString() == "1")) {
                                      NotificationUtils.showSimpleDialog2(
                                          context,
                                          S.of(context).pay_to_see_more,
                                          textButton1:
                                              S.of(context).yes_continue,
                                          textButton2: S.of(context).no,
                                          onPress2: () {
                                        Nav.back();
                                      }, onPress1: () async {
                                        Nav.back();
                                        await value.paymentBrainActivation(
                                            context,
                                            data.id ?? 0,
                                            data.price.toString() ?? "",
                                            widget.data?.idLogResult
                                                    .toString() ??
                                                "", onUpdate: () {
                                          value.getListBrain(
                                              context,
                                              widget.data?.idLogResult
                                                      .toString() ??
                                                  "");
                                        });
                                      },
                                          colorButon1: primaryColor,
                                          colorButton2: Colors.white);
                                    } else {
                                      Nav.to(PlayMusicScreen(
                                        data,
                                        onAudio: () {
                                          value.getListBrain(
                                              context,
                                              widget.data?.idLogResult
                                                      .toString() ??
                                                  "");
                                        },
                                      ));
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: greyColor.withOpacity(0.2)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: SizedBox(
                                                    width: 56,
                                                    height: 56,
                                                    child: Image.asset(
                                                        "images/brain/brain1.png")),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${data.name}",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 64),
                                                      child: Text(
                                                        DurasiUtils
                                                            .konversiDurasi(
                                                                data.duration ??
                                                                    ""),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          data.status.toString() == "0" ||
                                                  (data.logBrain?.status ==
                                                          "1" &&
                                                      data.status.toString() ==
                                                          "1")
                                              ? "images/menu/arrow.png"
                                              : "images/brain/Lock.png",
                                          width: 24,
                                          height: 24,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Padding(
                                    padding: EdgeInsets.only(bottom: 12));
                              },
                              itemCount: value.listBrain.length),
                        ),
                      ],
                    ),
            ),
          ),     floatingActionButton: const CustomFAB(),),
    );
  }
}
