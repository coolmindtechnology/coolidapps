// // ignore_for_file: use_build_context_synchronously
//
// import 'dart:async';
//
// import 'package:coolappflutter/data/apps/app_sizes.dart';
// import 'package:coolappflutter/data/data_global.dart';
// import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
// import 'package:coolappflutter/data/provider/provider_user.dart';
// import 'package:coolappflutter/data/response/profiling/res_list_multiple_profiling.dart';
// import 'package:coolappflutter/generated/l10n.dart';
// import 'package:coolappflutter/presentation/pages/profiling/add_multiple_profiling.dart';
// import 'package:coolappflutter/presentation/pages/profiling/detail_profiling.dart';
// import 'package:coolappflutter/presentation/pages/profiling/list_multiple_profiling.dart';
// import 'package:coolappflutter/presentation/pages/profiling/screen_hasil_kepribadian.dart';
// import 'package:coolappflutter/presentation/pages/profiling/screen_tambah_profiling.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/utils/nav_utils.dart';
// import 'package:coolappflutter/presentation/widgets/Container/container_slider_home.dart';
// import 'package:coolappflutter/presentation/widgets/button_primary.dart';
// import 'package:coolappflutter/presentation/widgets/no_data_widget.dart';
// import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
// import 'package:coolappflutter/presentation/widgets/shimmer_loading_widget_many.dart';
// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../data/provider/provider_profiling.dart';
// import '../../../data/response/profiling/res_list_profiling.dart';
// import '../../utils/notification_utils.dart';
//
// class ScreenFeatureKepribadian extends StatefulWidget {
//   final Function? onUpdate;
//   const ScreenFeatureKepribadian({super.key, this.onUpdate});
//
//   @override
//   State<ScreenFeatureKepribadian> createState() =>
//       _ScreenFeatureKepribadianState();
// }
//
// class _ScreenFeatureKepribadianState extends State<ScreenFeatureKepribadian>
//     with SingleTickerProviderStateMixin {
//   bool isInput = false;
//   TextEditingController controllerJumlahProfiling = TextEditingController();
//   late TabController tabController;
//   void show() {
//     setState(() {
//       isInput = !isInput;
//     });
//   }
//
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//   GlobalKey<RefreshIndicatorState>();
//
//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: brainColors.length + 1, vsync: this);
//     // tabController = TabController(length: 2, vsync: this, initialIndex: 0);
//     Timer(Duration(seconds: 2), () async {
//       await context.read<ProviderUser>().getUser(context);
//     });
//   }
//
//   Map<String, Color> brainColors = {
//     "all": Colors.blue,
//     "emotion in": Colors.green,
//     "action in": Colors.red,
//     "creative in": Colors.orange,
//     "master": Colors.black,
//     "logic in": Colors.yellow,
//   };
//
//   @override
//   void dispose() {
//     super.dispose();
//     controllerJumlahProfiling.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//         create: (BuildContext context) {
//           return ProviderProfiling.initList(context);
//         },
//         child: Consumer<ProviderUser>(
//           builder: (BuildContext context, valueUser, Widget? child) =>
//               Consumer<ProviderProfiling>(
//                   builder: (BuildContext context, value, Widget? child){
//                     return Scaffold(
//                       appBar: AppBar(
//                         centerTitle: true,
//                         title: Text(
//                           S.of(context).profiling,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         iconTheme: const IconThemeData(color: Colors.white),
//                         backgroundColor: primaryColor,
//                       ),
//                       body: CustomMaterialIndicator(
//                         key: _refreshIndicatorKey,
//                         onRefresh: () {
//                           value.getListProfiling(context);
//                           value.getListMutipleProfiling(context);
//                           return Future<void>.delayed(const Duration(seconds: 1));
//                         },
//                         indicatorBuilder:
//                             (BuildContext context, IndicatorController controller) {
//                           return const RefreshIconWidget();
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 30,right: 20,left: 20,bottom: 20),
//                           child: Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ContainerSliderHome(
//                                   ContainerSize: 170,
//                                   text: S.of(context).Go_test_profiling,
//                                   imageUrl: 'images/Slider1.png',
//                                   containerColor: BlueColor,
//                                   textColor: whiteColor,
//                                 ),gapH10,
//                                 Container(
//                                   height: 50,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     color: BlueColor,
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(bottom: 10,left: 10,right: 20,top: 10),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Apa itu Profiling',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//                                         Image.asset('images/IcArrow.png',fit: BoxFit.cover,width: 30,)
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 gapH10,
//                                 Text(S.of(context).My_Profiling,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
//                                 gapH10,
//                                 TabBar(
//                                   controller: tabController,
//                                   tabs: [
//                                     // Tab pertama untuk "Semua"
//                                     Tab(
//                                       text: S.of(context).all, // Tab untuk semua
//                                     ),
//                                     // Tab kedua untuk setiap `typeBrain`
//                                     ...brainColors.keys.map((String brainKey) {
//                                       return Tab(
//                                         text: brainKey == "all"
//                                             ? "Semua" // Teks untuk tab semua
//                                             : brainKey.replaceAll(" ", "\n"), // Pisahkan kata untuk tampilan lebih baik
//                                         icon: Container(
//                                           height: 20,
//                                           width: 20,
//                                           decoration: BoxDecoration(
//                                             color: brainColors[brainKey], // Warna sesuai dengan key
//                                             shape: BoxShape.circle,
//                                           ),
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ],
//                                   labelColor: Colors.white,
//                                   unselectedLabelColor: Colors.grey,
//                                   indicatorColor: Colors.transparent,
//                                   indicatorWeight: 3,
//                                   indicatorSize: TabBarIndicatorSize.tab,
//                                   isScrollable: true,
//                                 ),
//                                 Expanded(
//                                   child: TabBarView(
//                                     controller: tabController,
//                                     children: [
//                                       // Tab pertama untuk menampilkan semua data
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                                         child: value.isLoading
//                                             ? const ShimmerLoadingWidgetMany(
//                                           itemBuilderHeight: 156,
//                                           separatorBuilderHeight: 10,
//                                           itemCount: 5,
//                                         )
//                                             : value.listProfiling.isEmpty
//                                             ? const NoDataWidget()
//                                             : ListView.separated(
//                                           itemBuilder: (context, index) {
//                                             DataProfiling data =
//                                             value.listProfiling[index];
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 // Logika untuk navigasi saat item diklik
//                                                 if (data.status.toString() == "0") {
//                                                   NotificationUtils.showSimpleDialog2(
//                                                       context,
//                                                       S.of(context).pay_to_see_more,
//                                                       textButton1:
//                                                       S.of(context).yes_continue,
//                                                       textButton2: S.of(context).no,
//                                                       onPress2: () {
//                                                         Nav.back();
//                                                       },
//                                                       onPress1: () async {
//                                                         Nav.back();
//                                                         await NotificationUtils
//                                                             .showSimpleDialog2(
//                                                             context,
//                                                             S.of(context).pay_with_your_cool_balance,
//                                                             textButton1: S.of(context).yes_continue,
//                                                             textButton2: S.of(context).other,
//                                                             onPress2: () async {
//                                                               await value.payProfiling(
//                                                                 context,
//                                                                 [
//                                                                   int.tryParse(data.idLogResult
//                                                                       .toString() ?? "0") ??
//                                                                       0
//                                                                 ],
//                                                                 "0",
//                                                                 "transaction_type",
//                                                                 1,
//                                                                 onUpdate: () async {
//                                                                   await value.getListProfiling(context);
//                                                                 },
//                                                                 fromPage: "profiling",
//                                                               );
//                                                             }, onPress1: () async {
//                                                           Nav.back();
//                                                           await value.createTransactionProfiling(
//                                                               context,
//                                                               DataCheckoutTransaction(
//                                                                 idLogs: [
//                                                                   int.parse(data.idLogResult
//                                                                       .toString() ?? "0")
//                                                                 ],
//                                                                 discount: "0",
//                                                                 idItemPayments: "1",
//                                                                 qty: 1,
//                                                               ), () async {
//                                                             await value.getListProfiling(context);
//                                                           });
//                                                         },
//                                                             colorButon1: primaryColor,
//                                                             colorButton2: Colors.white);
//                                                       },
//                                                       colorButon1: primaryColor,
//                                                       colorButton2: Colors.white);
//                                                 } else {
//                                                   Nav.to(ScreenHasilKepribadian(data: data));
//                                                 }
//                                               },
//                                               child: CardListProfilingWidget(data: data),
//                                             );
//                                           },
//                                           separatorBuilder: (context, index) {
//                                             return const Padding(
//                                                 padding: EdgeInsets.only(bottom: 8));
//                                           },
//                                           itemCount: value.listProfiling.length,
//                                         ),
//                                       ),
//                                       // Tab untuk setiap tipe brain
//                                       ...brainColors.keys.map((String brainKey) {
//                                         return Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                                           child: value.isLoading
//                                               ? const ShimmerLoadingWidgetMany(
//                                             itemBuilderHeight: 156,
//                                             separatorBuilderHeight: 10,
//                                             itemCount: 5,
//                                           )
//                                               : value.listProfiling
//                                               .where((data) => data.typeBrain == brainKey)
//                                               .isEmpty
//                                               ? const NoDataWidget()
//                                               : ListView.separated(
//                                             itemBuilder: (context, index) {
//                                               DataProfiling data =
//                                               value.listProfiling[index];
//                                               return GestureDetector(
//                                                 onTap: () {
//                                                   // Logika untuk item klik
//                                                   Nav.to(ScreenHasilKepribadian(data: data));
//                                                 },
//                                                 child: CardListProfilingWidget(data: data),
//                                               );
//                                             },
//                                             separatorBuilder: (context, index) {
//                                               return const Padding(padding: EdgeInsets.only(bottom: 8));
//                                             },
//                                             itemCount: value.listProfiling.length,
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ],
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       bottomNavigationBar: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//
//                             if (valueUser.dataUser!.isAffiliate.toString() != "1")
//                               SizedBox(
//                                 height: 54,
//                                 child: ButtonPrimary(S.of(context).single,
//                                     expand: true,
//                                     negativeColor: true,
//                                     useBorder: true,
//                                     border: 1,
//                                     radius: 10,
//                                     elevation: 0.0,
//                                     borderColor: primaryColor, onPress: () {
//                                       // show();
//                                       Nav.to(ScreenTambahProfiling(
//                                         onAdd: () async {
//                                           await value.getListProfiling(context);
//                                         },
//                                       ));
//                                     }),
//                               ),
//                             if (valueUser.dataUser!.isAffiliate.toString() != "1")
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                             if (valueUser.dataUser!.isAffiliate.toString() != "1")
//                               SizedBox(
//                                 height: 54,
//                                 child: ButtonPrimary(
//                                   S.of(context).multiple,
//                                   expand: true,
//                                   negativeColor: true,
//                                   useBorder: true,
//                                   border: 1,
//                                   radius: 10,
//                                   elevation: 0.0,
//                                   borderColor: primaryColor,
//                                   onPress: () async {
//                                     if (value.dataMaximumProfiling?.maxQty != null) {
//                                       await showDialog(
//                                         context: context,
//                                         builder: (context) =>
//                                             InputAmountProfilingDialog(
//                                               maxProfiling: value
//                                                   .dataMaximumProfiling?.maxQty
//                                                   .toString(),
//                                               onAdd: () async {
//                                                 await value
//                                                     .getListMutipleProfiling(context);
//                                               },
//                                             ),
//                                       );
//                                     } else {}
//                                   },
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     );
//
//                   }
//
//               ),
//         ));
//   }
// }
//
// class CardListProfilingWidget extends StatelessWidget {
//   const CardListProfilingWidget({
//     super.key,
//     required this.data,
//   });
//
//   final DataProfiling data;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 color: primaryColor.withOpacity(0.2),
//                 borderRadius: const BorderRadius.only(
//                     topRight: Radius.circular(20),
//                     topLeft: Radius.circular(20))),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20.0,
//                     vertical: 16,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           SizedBox(
//                             child: CircleAvatar(
//                               backgroundColor: Colors.white,
//                               radius: 24,
//                               child: Image.asset(
//                                 "images/profile2.png",
//                                 color: Colors.black,
//                                 width: 24,
//                                 height: 24,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 12,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "${data.profilingName}",
//                                 style: const TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.w400),
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               Text(
//                                 "${data.date}",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: greyColor),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                       data.status == "0"
//                           ? const Padding(
//                         padding: EdgeInsets.only(right: 24),
//                         child: ImageIcon(
//                           AssetImage(
//                             "images/brain/Lock.png",
//                           ),
//                           color: Color(0XFFF2994A),
//                         ),
//                       )
//                           : const SizedBox(
//                         height: 0,
//                         width: 0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//               decoration: BoxDecoration(
//                   color: whiteColor,
//                   borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(20))),
//               child: Padding(
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           S.of(context).residence,
//                           style: const TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w400),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           "${data.domicile}",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: greyColor),
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           S.of(context).blood_type,
//                           style: const TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w400),
//                         ),
//                         const SizedBox(
//                           height: 4,
//                         ),
//                         Text(
//                           data.bloodType ?? "-",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: greyColor),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
//
// class InputAmountProfilingDialog extends StatelessWidget {
//   final String? maxProfiling;
//   final Function? onAdd;
//
//   InputAmountProfilingDialog({super.key, this.maxProfiling, this.onAdd});
//
//   final TextEditingController _controllerJumlahProfiling =
//   TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               S.of(context).how_much_data_do_you_want_to_create,
//               style: const TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 8.0,
//             ),
//             TextFormField(
//               controller: _controllerJumlahProfiling,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: '2-$maxProfiling',
//                 hintStyle: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey[500],
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(width: 1, color: greyColor),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(color: greyColor),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(width: 1.0, color: greyColor),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "${S.of(context).enter_a_value_between_2_and_10} $maxProfiling";
//                 }
//
//                 int inputValue = int.parse(value);
//
//                 if (inputValue < 2 ||
//                     inputValue > int.parse(maxProfiling ?? "0")) {
//                   return "${S.of(context).enter_a_value_between_2_and_10} $maxProfiling";
//                 }
//
//                 return null;
//               },
//             ),
//             const SizedBox(
//               height: 8.0,
//             ),
//             SizedBox(
//               height: 54,
//               child: ButtonPrimary(
//                 S.of(context).save,
//                 expand: true,
//                 elevation: 0.0,
//                 radius: 10,
//                 onPress: () {
//                   if (_formKey.currentState!.validate()) {
//                     Nav.back();
//                     Nav.to(AddMultipleProfiling(
//                       int.parse(_controllerJumlahProfiling.text),
//                       int.parse(maxProfiling ?? '0'),
//                       onAdd,
//                     ));
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
