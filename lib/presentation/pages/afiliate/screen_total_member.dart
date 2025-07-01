// import 'package:coolappflutter/generated/l10n.dart';
// import 'package:coolappflutter/presentation/pages/afiliate/screen_detail_member.dart';
// import 'package:coolappflutter/presentation/utils/nav_utils.dart';
// import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
// import 'package:coolappflutter/presentation/widgets/shimmer_loading_widget_many.dart';
// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../data/models/data_member_affiliate.dart';
// import '../../../data/provider/provider_affiliate.dart';
// import '../../theme/color_utils.dart';
// import '../../widgets/refresh_icon_widget.dart';
//
// class ScreenTotalMember extends StatefulWidget {
//   const ScreenTotalMember({super.key});
//
//   @override
//   State<ScreenTotalMember> createState() => _ScreenTotalMemberState();
// }
//
// class _ScreenTotalMemberState extends State<ScreenTotalMember> {
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//   @override
//   void initState() {
//     Future.microtask(
//         () => context.read<ProviderAffiliate>().getListMember(context));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProviderAffiliate>(
//       builder: (BuildContext context, value, Widget? child) => Scaffold(
//         appBar: AppBar(
//           title: Text(
//             S.of(context).member,
//             style: TextStyle(color: whiteColor),
//           ),
//           backgroundColor: primaryColor,
//         ),
//         body: CustomMaterialIndicator(
//           key: _refreshIndicatorKey,
//           onRefresh: () {
//             Provider.of<ProviderAffiliate>(context, listen: false)
//                 .getListMember(context);
//             return Future<void>.delayed(const Duration(seconds: 1));
//           },
//           indicatorBuilder:
//               (BuildContext context, IndicatorController controller) {
//             return const RefreshIconWidget();
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: value.isListMember == true
//                 ? const ShimmerLoadingWidgetMany(
//                     itemBuilderHeight: 50,
//                     itemCount: 5,
//                     separatorBuilderHeight: 8,
//                   )
//                 : value.listMember.isEmpty
//                     ? Center(child: Text(S.of(context).no_data))
//                     : ListView.separated(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         itemCount: value.listMember.length,
//                         itemBuilder: (context, index) {
//                           DataMemberAffiliate data = value.listMember[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Nav.to(ScreenDetailMember(data));
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "${data.name ?? data.phoneNumber}",
//                                         style: TextStyle(color: blackColor),
//                                       ),
//                                       Icon(
//                                         Icons.arrow_forward_ios,
//                                         color: blackColor,
//                                       )
//                                     ],
//                                   ),
//                                   Text(
//                                     "${data.profilingsCount ?? ""} profiling",
//                                     style: TextStyle(
//                                         color: greyColor, fontSize: 10),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         separatorBuilder: (BuildContext context, int index) {
//                           return Divider(
//                             thickness: 1,
//                             color: greyColor.withOpacity(0.3),
//                           );
//                         },
//                       ),
//           ),
//         ),
//         floatingActionButton: const CustomFAB(),
//       ),
//     );
//   }
// }
