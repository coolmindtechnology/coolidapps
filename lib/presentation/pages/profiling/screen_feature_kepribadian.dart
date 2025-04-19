// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/response/profiling/res_list_multiple_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/add_multiple_profiling.dart';
import 'package:coolappflutter/presentation/pages/profiling/detail_profiling.dart';
import 'package:coolappflutter/presentation/pages/profiling/list_multiple_profiling.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_hasil_kepribadian.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_tambah_profiling.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:coolappflutter/presentation/widgets/no_data_widget.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading_widget_many.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/provider/provider_profiling.dart';
import '../../../data/response/profiling/res_list_profiling.dart';
import '../../utils/notification_utils.dart';

class ScreenFeatureKepribadian extends StatefulWidget {
  final Function? onUpdate;
  const ScreenFeatureKepribadian({super.key, this.onUpdate});

  @override
  State<ScreenFeatureKepribadian> createState() =>
      _ScreenFeatureKepribadianState();
}

class _ScreenFeatureKepribadianState extends State<ScreenFeatureKepribadian>
    with SingleTickerProviderStateMixin {
  bool isInput = false;
  TextEditingController controllerJumlahProfiling = TextEditingController();
  late TabController tabController;
  void show() {
    setState(() {
      isInput = !isInput;
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    Timer(Duration(seconds: 2), () {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<ProviderUser>().getUser(context);
        });
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    controllerJumlahProfiling.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) {
          return ProviderProfiling.initList(context);
        },
        child: Consumer<ProviderUser>(
          builder: (BuildContext context, valueUser, Widget? child) =>
              Consumer<ProviderProfiling>(
                builder: (BuildContext context, value, Widget? child) => Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      S.of(context).profiling,
                      style: const TextStyle(color: Colors.white),
                    ),
                    iconTheme: const IconThemeData(color: Colors.white),
                    backgroundColor: primaryColor,
                  ),
                  body: CustomMaterialIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () {
                      value.getListProfiling(context);
                      value.getListMutipleProfiling(context);
                      return Future<void>.delayed(const Duration(seconds: 1));
                    },
                    indicatorBuilder:
                        (BuildContext context, IndicatorController controller) {
                      return const RefreshIconWidget();
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 275,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/feature.png"),
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        TabBar(
                          controller: tabController,
                          tabs: [
                            Tab(
                              text: S.of(context).single,
                            ),
                            Tab(
                              text: S.of(context).multiple,
                            ),
                          ],
                          labelColor: primaryColor,
                          unselectedLabelColor: primaryColor,
                          indicatorColor: primaryColor,
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 2,
                        ),
                        Expanded(
                          child: TabBarView(controller: tabController, children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: value.isLoading
                                  ? const ShimmerLoadingWidgetMany(
                                itemBuilderHeight: 156,
                                separatorBuilderHeight: 10,
                                itemCount: 5,
                              )
                                  : value.listProfiling.isEmpty
                                  ? const NoDataWidget()
                                  : ListView.separated(
                                // physics:
                                //     const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    DataProfiling data =
                                    value.listProfiling[index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (data.status.toString() == "0") {
                                          NotificationUtils
                                              .showSimpleDialog2(
                                              context,
                                              S
                                                  .of(context)
                                                  .pay_to_see_more,
                                              textButton1: S
                                                  .of(context)
                                                  .yes_continue,
                                              textButton2: S
                                                  .of(context)
                                                  .no, onPress2: () {
                                            Nav.back();
                                          }, onPress1: () async {
                                            Nav.back();
                                            await NotificationUtils
                                                .showSimpleDialog2(
                                                context,
                                                S
                                                    .of(context)
                                                    .pay_with_your_cool_balance,
                                                textButton1: S
                                                    .of(context)
                                                    .yes_continue,
                                                textButton2: S
                                                    .of(context)
                                                    .other_pay,
                                                onPress2: () async {
                                                  Nav.back();
                                                  await value.payProfiling(
                                                      context,
                                                      [
                                                        int.tryParse(data
                                                            .idLogResult
                                                            .toString() ??
                                                            "0") ??
                                                            0
                                                      ],
                                                      "0",
                                                      "transaction_type",
                                                      1, onUpdate: () async {
                                                    await value
                                                        .getListProfiling(
                                                        context);
                                                  }, fromPage: "profiling");
                                                }, onPress1: () async {
                                              Nav.back();
                                              await value
                                                  .createTransactionProfiling(
                                                  context,
                                                  DataCheckoutTransaction(
                                                      idLogs: [
                                                        int.parse(data
                                                            .idLogResult
                                                            .toString() ??
                                                            "0")
                                                      ],
                                                      discount: "0",
                                                      idItemPayments:
                                                      "1",
                                                      qty: 1,
                                                      gateway:
                                                      "paypal"),
                                                      () async {
                                                    await value
                                                        .getListProfiling(
                                                        context);
                                                  });
                                            },
                                                colorButon1:
                                                primaryColor,
                                                colorButton2:
                                                Colors.white);
                                          },
                                              colorButon1: primaryColor,
                                              colorButton2:
                                              Colors.white);
                                        } else {
                                          Nav.to(
                                              DetailProfiling(data: data));
                                        }
                                      },
                                      onDoubleTap: () {
                                        if (data.status.toString() == "0") {
                                          NotificationUtils
                                              .showSimpleDialog2(
                                              context,
                                              S
                                                  .of(context)
                                                  .pay_to_see_more,
                                              textButton1: S
                                                  .of(context)
                                                  .yes_continue,
                                              textButton2: S
                                                  .of(context)
                                                  .no, onPress2: () {
                                            Nav.back();
                                          }, onPress1: () async {
                                            Nav.back();
                                            await NotificationUtils
                                                .showSimpleDialog2(
                                                context,
                                                S
                                                    .of(context)
                                                    .pay_with_your_cool_balance,
                                                textButton1: S
                                                    .of(context)
                                                    .yes_continue,
                                                textButton2:
                                                S.of(context).other,
                                                onPress2: () async {
                                                  await value.payProfiling(
                                                    context,
                                                    [
                                                      int.tryParse(data
                                                          .idLogResult
                                                          .toString() ??
                                                          "0") ??
                                                          0
                                                    ],
                                                    "0",
                                                    "transaction_type",
                                                    1,
                                                    onUpdate: () async {
                                                      await value
                                                          .getListProfiling(
                                                          context);
                                                    },
                                                    fromPage: "profiling",
                                                  );
                                                }, onPress1: () async {
                                              Nav.back();
                                              await value
                                                  .createTransactionProfiling(
                                                  context,
                                                  DataCheckoutTransaction(
                                                    idLogs: [
                                                      int.parse(data
                                                          .idLogResult
                                                          .toString() ??
                                                          "0")
                                                    ],
                                                    discount: "0",
                                                    idItemPayments: "1",
                                                    qty: 1,
                                                  ), () async {
                                                await value
                                                    .getListProfiling(
                                                    context);
                                              });
                                            },
                                                colorButon1:
                                                primaryColor,
                                                colorButton2:
                                                Colors.white);
                                          },
                                              colorButon1: primaryColor,
                                              colorButton2:
                                              Colors.white);
                                        } else {
                                          Nav.to(ScreenHasilKepribadian(
                                              data: data));
                                        }
                                      },
                                      child: CardListProfilingWidget(
                                          data: data),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 8));
                                  },
                                  itemCount: value.listProfiling.length),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: value.isLoadingGetLIstMultipleProfiling
                                  ? const ShimmerLoadingWidgetMany(
                                itemBuilderHeight: 156,
                                separatorBuilderHeight: 10,
                                itemCount: 5,
                              )
                                  : value.listMultipleProfiling.isEmpty
                                  ? const NoDataWidget()
                                  : ListView.separated(
                                  itemBuilder: (context, index) {
                                    DataListMultipleProfiling
                                    dataListMultipleProfiling =
                                    value.listMultipleProfiling[index];
                                    return ListTile(
                                      onTap: () async {
                                        await Nav.to(ListMultipleProfiling(
                                          dataListMultipleProfiling:
                                          dataListMultipleProfiling,
                                        ));
                                        value.getListMutipleProfiling(
                                            context);
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      title: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: primaryColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Text(
                                            dataListMultipleProfiling.name
                                                .toString()),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 8,
                                    );
                                  },
                                  itemCount:
                                  value.listMultipleProfiling.length),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: MaterialButton(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         side: BorderSide(width: 1, color: primaryColor)),
                        //     color: Colors.white,
                        //     textColor: primaryColor,
                        //     height: 54,
                        //     minWidth: MediaQuery.of(context).size.width,
                        //     onPressed: () {
                        //       show();
                        //       Nav.to(ScreenTambahProfiling(
                        //         onAdd: () async {
                        //           await value.getListProfiling(context);
                        //         },
                        //       ));
                        //     },
                        //     child: Text("+ ${S.of(context).add}"),
                        //   ),
                        // ),
                        // value.listProfiling.isNotEmpty
                        //     ? SizedBox(
                        //         height:
                        //             value.listDisable.length == value.listProfiling.length
                        //                 ? 0
                        //                 : 12,
                        //       )
                        //     : const SizedBox(
                        //         height: 0,
                        //         width: 0,
                        //       ),
                        // value.listProfiling.isNotEmpty ||
                        // value.listProfiling.isNotEmpty &&
                        //         value.listDisable != value.listProfiling
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(
                        //             left: 20, right: 20, bottom: 10),
                        //         child: MaterialButton(
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //           color: primaryColor,
                        //           textColor: Colors.white,
                        //           height: 54,
                        //           minWidth: MediaQuery.of(context).size.width,
                        //           onPressed: value.listDisable.length ==
                        //                   value.listProfiling.length
                        //               ? null
                        //               : () {
                        //                   NotificationUtils.showSimpleDialog2(
                        //                       context, S.of(context).pay_to_see_more,
                        //                       textButton1: S.of(context).yes_continue,
                        //                       textButton2: S.of(context).no,
                        //                       onPress2: () {
                        //                     Nav.back();
                        //                   }, onPress1: () async {
                        //                     List<DataProfiling> satuList = [];
                        //                     satuList = value.listProfiling.where((e) {
                        //                       return e.status == "0";
                        //                     }).toList();

                        //                     print(
                        //                         "satuList ${satuList.map((e) => e.idLogResult)}");

                        //                     await value.payProfiling(
                        //                         context,
                        //                         satuList
                        //                             .map((e) =>
                        //                                 int.tryParse(
                        //                                     e.idLogResult ?? "0") ??
                        //                                 0)
                        //                             .toList(),
                        //                         "0",
                        //                         "payment",
                        //                         satuList.length, onUpdate: () {
                        //                       value.getListProfiling(context);
                        //                     });
                        //                   },
                        //                       colorButon1: primaryColor,
                        //                       colorButton2: Colors.white);

                        //                   // Nav.to(InvoiceScreen());
                        //                   // Nav.to(PreInvoiceScreen());
                        //                   // show();
                        //                   // Nav.to(const ScreenHasilKepribadian());
                        //                 },
                        //           child: const Text("Bayar Semua"),
                        //         ),
                        //       )
                        //     : const SizedBox(
                        //         height: 0,
                        //         width: 0,
                        //       ),
                        if (valueUser.dataUser!.isAffiliate.toString() != "1")
                          SizedBox(
                            height: 54,
                            child: ButtonPrimary(S.of(context).single,
                                expand: true,
                                negativeColor: true,
                                useBorder: true,
                                border: 1,
                                radius: 10,
                                elevation: 0.0,
                                borderColor: primaryColor, onPress: () {
                                  // show();
                                  Nav.to(ScreenTambahProfiling(
                                    onAdd: () async {
                                      await value.getListProfiling(context);
                                    },
                                  ));
                                }),
                          ),
                        if (valueUser.dataUser!.isAffiliate.toString() != "1")
                          const SizedBox(
                            height: 8,
                          ),
                        if (valueUser.dataUser!.isAffiliate.toString() != "1")
                          SizedBox(
                            height: 54,
                            child: ButtonPrimary(
                              S.of(context).multiple,
                              expand: true,
                              negativeColor: true,
                              useBorder: true,
                              border: 1,
                              radius: 10,
                              elevation: 0.0,
                              borderColor: primaryColor,
                              onPress: () async {
                                if (value.dataMaximumProfiling?.maxQty != null) {
                                  await showDialog(
                                    context: context,
                                    builder: (context) =>
                                        InputAmountProfilingDialog(
                                          maxProfiling: value
                                              .dataMaximumProfiling?.maxQty
                                              .toString(),
                                          onAdd: () async {
                                            await value
                                                .getListMutipleProfiling(context);
                                          },
                                        ),
                                  );
                                } else {}
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  floatingActionButton: const CustomFAB(),
                ),
              ),
        ));
  }
}

class CardListProfilingWidget extends StatelessWidget {
  const CardListProfilingWidget({
    super.key,
    required this.data,
  });

  final DataProfiling data;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 24,
                              child: Image.asset(
                                "images/profile2.png",
                                color: Colors.black,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.profilingName}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${data.date}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: greyColor),
                              )
                            ],
                          )
                        ],
                      ),
                      data.status == "0"
                          ? const Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: ImageIcon(
                          AssetImage(
                            "images/brain/Lock.png",
                          ),
                          color: Color(0XFFF2994A),
                        ),
                      )
                          : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).residence,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${data.domicile}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: greyColor),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).blood_type,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          data.bloodType ?? "-",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: greyColor),
                        )
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class InputAmountProfilingDialog extends StatelessWidget {
  final String? maxProfiling;
  final Function? onAdd;

  InputAmountProfilingDialog({super.key, this.maxProfiling, this.onAdd});

  final TextEditingController _controllerJumlahProfiling =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).how_much_data_do_you_want_to_create,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: _controllerJumlahProfiling,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '2-$maxProfiling',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: greyColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: greyColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1.0, color: greyColor),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "${S.of(context).enter_a_value_between_2_and_10} $maxProfiling";
                }

                int inputValue = int.parse(value);

                if (inputValue < 2 ||
                    inputValue > int.parse(maxProfiling ?? "0")) {
                  return "${S.of(context).enter_a_value_between_2_and_10} $maxProfiling";
                }

                return null;
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: 54,
              child: ButtonPrimary(
                S.of(context).save,
                expand: true,
                elevation: 0.0,
                radius: 10,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    Nav.back();
                    Nav.to(AddMultipleProfiling(
                      int.parse(_controllerJumlahProfiling.text),
                      int.parse(maxProfiling ?? '0'),null
                      // onAdd,
                    ));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}