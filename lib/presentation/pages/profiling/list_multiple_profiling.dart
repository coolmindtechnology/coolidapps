import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_multiple_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/detail_profiling.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_feature_kepribadian.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_hasil_kepribadian.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMultipleProfiling extends StatefulWidget {
  const ListMultipleProfiling(
      {super.key, required this.dataListMultipleProfiling});

  final DataListMultipleProfiling dataListMultipleProfiling;

  @override
  State<ListMultipleProfiling> createState() => _ListMultipleProfilingState();
}

class _ListMultipleProfilingState extends State<ListMultipleProfiling> {
  List<int> selectedIds = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderProfiling(),
      child: Consumer<ProviderProfiling>(builder: (context, value, child) {
        return Scaffold(
            appBar: AppBar(
                title: Text(
              "Multiple Profiling",
              style: TextStyle(color: whiteColor),
            )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomMaterialIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () {
                  return Future.value();
                },
                indicatorBuilder:
                    (BuildContext context, IndicatorController controller) {
                  return const RefreshIconWidget();
                },
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      DataProfiling dataProfiling =
                          widget.dataListMultipleProfiling.profiling![index];
                      return GestureDetector(
                          onTap: () {
                            if (dataProfiling.status.toString() == "0") {
                              //     NotificationUtils.showSimpleDialog2(
                              //       context,
                              //       S.of(context).pay_to_see_more,
                              //       textButton1: S.of(context).yes_continue,
                              //       textButton2: S.of(context).no,
                              //       onPress2: () {
                              //         Nav.back();
                              //       },
                              //       onPress1: () {
                              //         Nav.back();
                              //         NotificationUtils.showSimpleDialog2(
                              //           context,
                              //           S.of(context).pay_with_your_cool_balance,
                              //           textButton1: S.of(context).yes_continue,
                              //           textButton2: S.of(context).other_pay,
                              //           onPress1: () {
                              //             Nav.back();
                              //             Nav.replace(LoadingPaymentSaldo(
                              //                 dataCheckoutTransaction:
                              //                     DataCheckoutTransaction(
                              //               idLogs: [
                              //                 int.parse(
                              //                     dataProfiling.idLogResult ?? "0")
                              //               ],
                              //               discount: "0",
                              //               idItemPayments: "1",
                              //               qty: 1,
                              //             )));
                              //           },
                              //           onPress2: () async {
                              //             Nav.back();

                              //             //nanti ditambahkan pre invoice
                              //             await value.payProfiling(
                              //                 context,
                              //                 [
                              //                   int.tryParse(
                              //                           dataProfiling.idLogResult ??
                              //                               "0") ??
                              //                       0
                              //                 ],
                              //                 "0",
                              //                 "transaction_type",
                              //                 1, onUpdate: () {
                              //               value.getListMutipleProfiling(context);
                              //             });
                              //           },
                              //         );
                              //       },
                              //     );
                            } else {
                              Nav.to(DetailProfiling(data: dataProfiling));
                            }
                          },
                          onDoubleTap: () {
                            if (dataProfiling.status.toString() == "0") {
                              // NotificationUtils.showSimpleDialog(
                              //     context, S.of(context).pay_to_see_more, () {
                              //   Nav.back();
                              // });
                            } else {
                              Nav.to(
                                  ScreenHasilKepribadian(data: dataProfiling));
                            }
                          },
                          child: CardListProfilingWidget(data: dataProfiling));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                    itemCount:
                        widget.dataListMultipleProfiling.profiling?.length ??
                            0),
              ),
            ),
            bottomNavigationBar: widget.dataListMultipleProfiling.profiling
                        ?.any((dataProfiling) =>
                            dataProfiling.status.toString() != "1") ==
                    true
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 54,
                      child: value.isPayProfiling
                          ? const CircularProgressWidget()
                          : ButtonPrimary(
                              S.of(context).pay_all,
                              elevation: 0.0,
                              radius: 10,
                              onPress: () async {
                                selectedIds.clear();
                                widget.dataListMultipleProfiling.profiling
                                    ?.forEach((dataProfiling) {
                                  if (dataProfiling.status.toString() != "1") {
                                    selectedIds.add(int.parse(
                                        dataProfiling.idLogResult.toString() ??
                                            "0"));
                                  }
                                });
                                DataCheckoutTransaction dataCheckoutTransaction;
                                dataCheckoutTransaction =
                                    DataCheckoutTransaction(
                                        idLogs: selectedIds,
                                        discount: "0",
                                        transactionType: "Multiple Profiling",
                                        idItemPayments: "1",
                                        qty: selectedIds.length);

                                await NotificationUtils.showSimpleDialog2(
                                  context,
                                  S.of(context).pay_with_your_cool_balance,
                                  textButton1: S.of(context).yes_continue,
                                  textButton2: S.of(context).other,
                                  onPress1: () async {
                                    Nav.back();

                                    await value.createTransactionProfiling(
                                        context, dataCheckoutTransaction, () {
                                      value.getListMutipleProfiling(context);
                                    }, isMultiple: true);
                                  },
                                  onPress2: () async {
                                    Nav.back();

                                    await value.payMultipleProfiling(
                                        context, dataCheckoutTransaction,
                                        onUpdate: () {
                                      value.getListMutipleProfiling(context);
                                    }, fromPage: "profiling", isMultiple: true);
                                  },
                                );
                              },
                            ),
                    ),
                  )
                : const SizedBox());
      }),
    );
  }
}
