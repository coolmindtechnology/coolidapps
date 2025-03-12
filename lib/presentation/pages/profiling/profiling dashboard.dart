import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/presentation/pages/brain/screen_brain_activition.dart';
import 'package:coolappflutter/presentation/pages/profiling/add_multiple_profiling.dart';
import 'package:coolappflutter/presentation/pages/profiling/detail_profiling.dart';
import 'package:coolappflutter/presentation/pages/profiling/konfrimasi%20identitas.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_hasil_kepribadian.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_slider_home.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfilingDashboard extends StatefulWidget {
  const ProfilingDashboard({super.key});

  @override
  State<ProfilingDashboard> createState() => _ProfilingDashboardState();
}

class _ProfilingDashboardState extends State<ProfilingDashboard> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this, initialIndex: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProviderProfiling>().filterProfilingData(_selectedIndex);
      initHome();
    });
  }

  void initHome() async {
    await context.read<ProviderProfiling>().getListProfiling(context);
  }


  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Memanggil fungsi filter setelah tab dipilih
    context.read<ProviderProfiling>().filterProfilingData(index);
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderProfiling>(
        builder: (BuildContext context, value, Widget? child)
    {
      return CustomMaterialIndicator(
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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.of(context).profiling,
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor,
                Colors.white
              ], // Gradasi biru ke putih
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerSliderHome(
                ContainerSize: 170,
                text: S.of(context).Go_test_profiling,
                imageUrl: 'images/Slider1.png',
                containerColor: BlueColor,
                textColor: whiteColor,
              ),
              gapH10,
              // Container(
              //   height: 50,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: BlueColor,
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //         bottom: 10, left: 10, right: 20, top: 10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           S.of(context).what_is_profiling,
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold),
              //         ),
              //         Image.asset(
              //           'images/IcArrow.png',
              //           fit: BoxFit.cover,
              //           width: 30,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              gapH20,
              Text(
                S.of(context).My_Profiling,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              gapH10,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTab(
                          index: 0,
                          text: S.of(context).all,
                          backgroundColor: Colors.white,
                          borderColor: primaryColor,
                          textColor: primaryColor),
                      gapW10,
                      _buildTab(
                          index: 1,
                          text: S.of(context).green,
                          textColor: Colors.white,
                          borderColor: Colors.green,
                          backgroundColor: greenColor),
                      gapW10,
                      _buildTab(
                          index: 2,
                          text: S.of(context).yellow,
                          textColor: Colors.white,
                          backgroundColor: Colors.yellow,
                          borderColor: Colors.yellow),
                      gapW10,
                      _buildTab(
                          index: 3,
                          text: S.of(context).white,
                          borderColor: Colors.white,
                          backgroundColor: Colors.white,
                          textColor: Colors.black),
                      gapW10,
                      _buildTab(
                          index: 4,
                          text: S.of(context).orange,
                          textColor: Colors.white,
                          backgroundColor: Colors.orange,
                          borderColor: Colors.orange),
                      gapW10,
                      _buildTab(
                          index: 5,
                          text: S.of(context).red,
                          textColor: Colors.white,
                          borderColor: Colors.red,
                          backgroundColor: Colors.red),
                    ],
                  ),
                ),
                // Menggunakan Consumer untuk mendengarkan perubahan pada data yang difilter
                Consumer<ProviderProfiling>( // Menggunakan Consumer untuk mendengarkan perubahan
                  builder: (context, provider, child) {
                    List<DataProfiling> dataToDisplay = provider.filteredProfiling;
                    // print("================ data filter =================");
                    // print(provider.filteredProfiling.toString());
                    // print("================ data filter =================");
                    return Expanded(
                      child: value.isLoading
                          ? ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 156,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemCount: 5, // Jumlah shimmer yang ditampilkan
                      ) : ListView.builder(

                        itemCount: dataToDisplay.length,
                        itemBuilder: (context, index) {
                          DataProfiling data = dataToDisplay[index];
                          return GestureDetector(
                            // onTap: () {
                            //   Nav.to(KonfirmasiIdentitiasPage());
                            // },
                            onTap: () {
                              if (data.status.toString() ==
                                  "0") {
                                NotificationUtils
                                    .showSimpleDialog2(
                                    context,
                                    S
                                        .of(context)
                                        .pay_to_see_more,
                                    textButton1: S
                                        .of(context)
                                        .yes_continue,
                                    textButton2:
                                    S.of(context).no,
                                    onPress2: () {
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
                                        await provider.payProfiling(
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
                                              await provider
                                                  .getListProfiling(
                                                  context);
                                            }, fromPage: "profiling");
                                      }, onPress1: () async {
                                    Nav.back();
                                    await provider
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
                                          await provider
                                              .getListProfiling(
                                              context);
                                        });
                                  },
                                      colorButon1:
                                      primaryColor,
                                      colorButton2:
                                      Colors.white);
                                },
                                    colorButon1:
                                    primaryColor,
                                    colorButton2:
                                    Colors.white);
                              } else {

                                // Nav.to(DetailProfiling(
                                //     data: data));
                                Nav.to(ScreenHasilKepribadian(
                                    data: data));
                              }
                            },
                            onDoubleTap: () {
                              if (data.status.toString() ==
                                  "0") {
                                NotificationUtils
                                    .showSimpleDialog2(
                                    context,
                                    S
                                        .of(context)
                                        .pay_to_see_more,
                                    textButton1: S
                                        .of(context)
                                        .yes_continue,
                                    textButton2:
                                    S.of(context).no,
                                    onPress2: () {
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
                                          .other,
                                      onPress2: () async {
                                        await provider.payProfiling(
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
                                            await provider
                                                .getListProfiling(
                                                context);
                                          },
                                          fromPage: "profiling",
                                        );
                                      }, onPress1: () async {
                                    Nav.back();
                                    await provider
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
                                        ), () async {
                                      await provider
                                          .getListProfiling(
                                          context);
                                    });
                                  },
                                      colorButon1:
                                      primaryColor,
                                      colorButton2:
                                      Colors.white);
                                },
                                    colorButon1:
                                    primaryColor,
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
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double
                .infinity, // Pastikan tombol terisi penuh di dalam dialog
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Agar tombol rata
              children: [
                // Tombol Reset
                // Expanded(
                //   child: GlobalButton(
                //     icon: Image.asset('images/promo/BrainActivation.png'),
                //     onPressed: () {
                //       Nav.to(ScreenBrainActivation(data,
                //           dataGlobal.dataUser?.typeBrain.toString() ??
                //               ""));
                //     },
                //     color: whiteColor,
                //     text: S.of(context).brain_activation,
                //     textStyle: TextStyle(color: primaryColor),
                //   ),
                // ),
                //
                // SizedBox(width: 10), // Spasi antar tombol

                // Tombol Simpan
                Expanded(
                  child: GlobalButton(
                    onPressed: () async {
                      Nav.to(AddMultipleProfiling(
                        int.parse('1'),
                        int.parse('10'),
                      ));
                    },
                    color: primaryColor,
                    text: S.of(context).new_profiling,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ); });

  }

  Widget _buildTab({
    required int index,
    required String text,
    required Color borderColor,
    required Color backgroundColor,
    required Color textColor,
  }) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : backgroundColor,
          border: Border.all(
            color: isSelected ? Colors.blue : borderColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: isSelected ? Colors.blue : textColor,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
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
      color: lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: borderBlue)),
      child: Column(
        children: [
          Column(
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
                        ),
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
          Padding(
            padding: const EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
            child: Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                color: _getColorForType(data.typeBrain),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(data.typeBrain,style: TextStyle(color: data.typeBrain == "master" ? Colors.black : Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),),
            ),
          )
        ],
      ),
    );
  }
  Color _getColorForType(String type) {
    switch (type) {
      case 'emotion in':
      case 'emotion out':
        return Colors.green;
      case 'logic in':
      case 'logic out':
        return Colors.yellow;
      case 'master':
        return Colors.white;
      case 'creative in':
      case 'creative out':
        return Colors.orange;
      case 'action in':
      case 'action out':
        return Colors.red;
      default:
        return Colors.grey; // Warna default jika type tidak cocok
    }
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
              S
                  .of(context)
                  .how_much_data_do_you_want_to_create,
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
                hintText: '1-$maxProfiling',
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
                  return "${S
                      .of(context)
                      .enter_a_value_between_2_and_10} $maxProfiling";
                }

                int inputValue = int.parse(value);

                if (inputValue < 1 ||
                    inputValue > int.parse(maxProfiling ?? "0")) {
                  return "${S
                      .of(context)
                      .enter_a_value_between_2_and_10} $maxProfiling";
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
                S
                    .of(context)
                    .save,
                expand: true,
                elevation: 0.0,
                radius: 10,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    Nav.back();
                    Nav.to(AddMultipleProfiling(
                      int.parse(_controllerJumlahProfiling.text),
                      int.parse(maxProfiling ?? '0'),
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

