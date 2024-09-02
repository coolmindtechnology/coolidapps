import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/models/subcribtion_brain_transaction_data_model.dart';
import 'package:cool_app/data/provider/provider_brain_activation.dart';
import 'package:cool_app/data/response/brain_activation/res_list_subcription_per_item.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:cool_app/presentation/utils/money_formatter.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/utils/notification_utils.dart';
import 'package:cool_app/presentation/widgets/button_primary.dart';
import 'package:cool_app/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrainSubscriptionPage extends StatefulWidget {
  const BrainSubscriptionPage(
      {Key? key, this.idLogProfiling, this.typeSubcribe})
      : super(key: key);
  final String? idLogProfiling;
  final String? typeSubcribe;

  @override
  State<BrainSubscriptionPage> createState() => _BrainSubscriptionPageState();
}

class _BrainSubscriptionPageState extends State<BrainSubscriptionPage> {
  String selectedSubscriptionType = '';
  SubscribeBrainTransactionDataModel? selectedType;
  List<int> selectedIds = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context
          .read<ProviderBrainActivation>()
          .getListSubcriptionPerItem(context, widget.idLogProfiling ?? '');
      if (widget.typeSubcribe != "single") {
        context
            .read<ProviderBrainActivation>()
            .getListSubcriptionAllItem(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).brain_subscription,
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: Consumer<ProviderBrainActivation>(builder: (context, state, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (state.isGetListSubcriptionAllItem ||
                    state.isGetListSubcriptionPerItem) ...[
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (itemBuilder, index) => ShimmerLoadingWidget(
                          height: 85, width: MediaQuery.of(context).size.width),
                      separatorBuilder: (itemBuilder, index) => const SizedBox(
                            height: 12,
                          ),
                      itemCount: 5)
                ] else if (state.dataResponse?.transactionType == "yearly") ...[
                  Text(
                    S.of(context).listen_brain_40_times,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ] else ...[
                  Text(
                    S.of(context).get_lots_of_benefits_by_subcribing,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: greyColor.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: ExpansionTile(
                      collapsedShape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                      title: Text(S.of(context).subscription_per_type),
                      children: state.listDataSubcriptionPerItem.map((item) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: greyColor.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item.name ?? "-",
                                style: const TextStyle(fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSubscriptionType =
                                        "${item.name} yearly";
                                    selectedType =
                                        SubscribeBrainTransactionDataModel(
                                      idBrainActivations: [
                                        int.parse(item.id.toString())
                                      ],
                                      discount: double.parse(
                                              item.yearlyDiscount.toString())
                                          .toInt(),
                                      transactionType: "yearly",
                                      subscriptionType: "single",
                                      price: double.parse(
                                              item.yearlyPrice.toString())
                                          .toInt(),
                                      gateway: dataGlobal.isIndonesia
                                          ? 'midtrans'
                                          : 'paypal',
                                    );
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ItemTextWidgetPrice(
                                            item: item,
                                            isYearly: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                      child: Radio(
                                        value: "${item.name} yearly",
                                        groupValue: selectedSubscriptionType,
                                        activeColor: primaryColor,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedSubscriptionType =
                                                value.toString();
                                            selectedType =
                                                SubscribeBrainTransactionDataModel(
                                                    idBrainActivations: [
                                                  int.parse(item.id.toString())
                                                ],
                                                    discount: double.parse(item
                                                            .yearlyDiscount
                                                            .toString())
                                                        .toInt(),
                                                    transactionType: "yearly",
                                                    subscriptionType: "single",
                                                    price: double.parse(item
                                                            .yearlyPrice
                                                            .toString())
                                                        .toInt(),
                                                    gateway:
                                                        dataGlobal.isIndonesia
                                                            ? "midtrans"
                                                            : "paypal");
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (state.dataResponse?.transactionType ==
                                  "monthly") ...[
                                const SizedBox(
                                  height: 8,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              '${S.of(context).congratulations} ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text:
                                            '${S.of(context).subscribed_this_month} ',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              if (state.dataResponse?.transactionType !=
                                  "monthly") ...[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSubscriptionType =
                                          "${item.name} monthly";
                                      selectedType =
                                          SubscribeBrainTransactionDataModel(
                                              idBrainActivations: [
                                            int.parse(item.id.toString())
                                          ],
                                              discount:
                                                  double
                                                          .parse(
                                                              item.monthlyDiscount
                                                                  .toString())
                                                      .toInt(),
                                              transactionType: "monthly",
                                              subscriptionType: "single",
                                              price: double.parse(item
                                                      .monthlyPrice
                                                      .toString())
                                                  .toInt(),
                                              gateway: !dataGlobal.isIndonesia
                                                  ? "paypal"
                                                  : null);
                                    });
                                  },
                                  child: Row(children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ItemTextWidgetPrice(
                                          item: item,
                                          isYearly: false,
                                        ),
                                      ],
                                    )),
                                    SizedBox(
                                      height: 24,
                                      child: Radio(
                                        value: "${item.name} monthly",
                                        groupValue: selectedSubscriptionType,
                                        activeColor: primaryColor,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedSubscriptionType =
                                                value.toString();
                                            selectedType =
                                                SubscribeBrainTransactionDataModel(
                                                    idBrainActivations: [
                                                  int.parse(item.id.toString())
                                                ],
                                                    discount: double.parse(item
                                                            .monthlyDiscount
                                                            .toString())
                                                        .toInt(),
                                                    transactionType: "monthly",
                                                    subscriptionType: "single",
                                                    price: double.parse(item
                                                            .monthlyPrice
                                                            .toString())
                                                        .toInt(),
                                                    gateway:
                                                        dataGlobal.isIndonesia
                                                            ? "midtrans"
                                                            : "paypal");
                                          });
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if (widget.typeSubcribe != "single") ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: ExpansionTile(
                        collapsedShape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        title: Text(S.of(context).subcription_all_type),
                        children: state.listDataSubcriptionAllItem.map((item) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIds.clear();
                                for (var perItem
                                    in state.listDataSubcriptionPerItem) {
                                  selectedIds.add(perItem.id ?? 0);
                                }
                                selectedSubscriptionType = "${item.name} all";
                                selectedType =
                                    SubscribeBrainTransactionDataModel(
                                        idBrainActivations: selectedIds,
                                        discount: double.parse(
                                                item.discount.toString())
                                            .toInt(),
                                        transactionType: item.title == "Monthly"
                                            ? "monthly"
                                            : "yearly",
                                        subscriptionType: "all",
                                        price: double.parse(
                                                item.originalPrice.toString())
                                            .toInt(),
                                        gateway: !dataGlobal.isIndonesia
                                            ? "paypal"
                                            : null);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: greyColor.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(item.title ?? "-"),
                                        RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              if (item.discount != "0.00") ...[
                                                TextSpan(
                                                    text:
                                                        '${MoneyFormatter.formatMoney(
                                                      item.originalPrice,
                                                      true,
                                                    )} ',
                                                    style: TextStyle(
                                                        color: greyColor,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                              TextSpan(
                                                text:
                                                    '${MoneyFormatter.formatMoney(
                                                  item.discountPrice,
                                                  true,
                                                )}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                    SizedBox(
                                      height: 24,
                                      child: Radio(
                                        value: "${item.name} all",
                                        groupValue: selectedSubscriptionType,
                                        activeColor: primaryColor,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedIds.clear();
                                            for (var perItem in state
                                                .listDataSubcriptionPerItem) {
                                              selectedIds.add(perItem.id ?? 0);
                                            }
                                            selectedSubscriptionType =
                                                value.toString();
                                            selectedType =
                                                SubscribeBrainTransactionDataModel(
                                                    idBrainActivations:
                                                        selectedIds,
                                                    discount: double.parse(item
                                                            .discount
                                                            .toString())
                                                        .toInt(),
                                                    transactionType:
                                                        item.title ==
                                                                "Monthly"
                                                            ? "monthly"
                                                            : "yearly",
                                                    subscriptionType: "all",
                                                    price: double.parse(item
                                                            .originalPrice
                                                            .toString())
                                                        .toInt(),
                                                    gateway:
                                                        dataGlobal.isIndonesia
                                                            ? "midtrans"
                                                            : "paypal");
                                          });
                                        },
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 54,
                    child: state.isCreateTransactionSubcribeBrainActivation
                        ? const CircularProgressWidget()
                        : ButtonPrimary(
                            S.of(context).next,
                            onPress: () {
                              if (selectedSubscriptionType.isEmpty ||
                                  selectedType?.idBrainActivations == null) {
                                NotificationUtils.showDialogError(
                                  context,
                                  () {
                                    Nav.back();
                                  },
                                  textButton: S.of(context).yes,
                                  widget: Text(
                                    S.of(context).please_select_subscription,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              } else {
                                selectedType?.idLogProfiling =
                                    int.parse(widget.idLogProfiling.toString());
                                selectedType?.idItemPayments = "3";

                                if (!state.valueAllList) {
                                  state.subcribeBrainProfiling(
                                      context,
                                      selectedType ??
                                          SubscribeBrainTransactionDataModel(),
                                      onUpdate: () async {
                                    Nav.back();
                                    await state.getListBrain(context,
                                        widget.idLogProfiling.toString());
                                  });
                                } else {
                                  state.createTransactionSubcribeBrainActivation(
                                      context,
                                      selectedType ??
                                          SubscribeBrainTransactionDataModel(),
                                      onUpdate: () async {
                                    Nav.back();
                                    await state.getListBrain(context,
                                        widget.idLogProfiling.toString());
                                  });
                                }
                              }
                            },
                            expand: true,
                            radius: 10,
                            elevation: 0.0,
                          ),
                  )
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ItemTextWidgetPrice extends StatelessWidget {
  const ItemTextWidgetPrice(
      {super.key, required this.item, required this.isYearly});
  final DataSubcriptionPerItem item;
  final bool isYearly;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: isYearly ? S.of(context).yearly : S.of(context).monthly,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const TextSpan(text: " "),
          if (isYearly) ...[
            if (item.yearlyDiscount != "0.00") ...[
              TextSpan(
                  text: '${MoneyFormatter.formatMoney(
                    item.yearlyPrice ?? 0,
                    true,
                  )}',
                  style: TextStyle(
                      color: greyColor,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              const TextSpan(text: " "),
            ]
          ] else if (item.monthlyDiscount != "0.00") ...[
            TextSpan(
                text: '${MoneyFormatter.formatMoney(
                  item.monthlyPrice ?? 0,
                  true,
                )}',
                style: TextStyle(
                    color: greyColor,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            const TextSpan(text: " "),
          ],
          TextSpan(
            text: '${MoneyFormatter.formatMoney(
              isYearly
                  ? item.discountedYearlyPrice
                  : item.discountedMonthlyPrice,
              true,
            )}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
