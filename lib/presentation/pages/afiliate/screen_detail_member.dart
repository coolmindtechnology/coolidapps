// import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
// import 'package:coolappflutter/data/provider/provider_affiliate.dart';
// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../data/models/data_member_affiliate.dart';
// import '../../../generated/l10n.dart';
// import '../../theme/color_utils.dart';
// import '../../widgets/refresh_icon_widget.dart';
//
// class ScreenDetailMember extends StatefulWidget {
//   final DataMemberAffiliate? data;
//   const ScreenDetailMember(this.data, {super.key});
//
//   @override
//   State<ScreenDetailMember> createState() => _ScreenDetailMemberState();
// }
//
// class _ScreenDetailMemberState extends State<ScreenDetailMember> {
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//
//   @override
//   void initState() {
//     Future.microtask(() => context
//         .read<ProviderAffiliate>()
//         .getDetailAffiliate(context, widget.data?.id.toString() ?? ""));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProviderAffiliate>(
//       builder: (BuildContext context, value, Widget? child) => Scaffold(
//         appBar: AppBar(
//           title: Text(
//             S.of(context).member_details,
//             style: TextStyle(color: whiteColor),
//           ),
//           backgroundColor: primaryColor,
//         ),
//         body: CustomMaterialIndicator(
//           key: _refreshIndicatorKey,
//           onRefresh: () {
//             if (kDebugMode) {
//               print(
//                   "link ${ApiEndpoint.imageUrlPreHome}${value.detailDataMember?.image}");
//             }
//             Provider.of<ProviderAffiliate>(context, listen: false)
//                 .getDetailAffiliate(context, widget.data?.id.toString() ?? "");
//             return Future<void>.delayed(const Duration(seconds: 1));
//           },
//           indicatorBuilder:
//               (BuildContext context, IndicatorController controller) {
//             return const RefreshIconWidget();
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   Center(
//                     child: CircleAvatar(
//                       radius: 35,
//                       child: value.detailDataMember?.image == null
//                           ? Image.asset(
//                               "images/default_user.png",
//                               color: greyColor,
//                             )
//                           : ClipRRect(
//                               borderRadius: BorderRadius.circular(100),
//                               child: Image.network(
//                                 "${value.detailDataMember?.image}",
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                     ),
//                   ),
//                   Text(
//                     S.of(context).name,
//                     style: TextStyle(
//                         fontSize: 12, color: greyColor.withOpacity(0.3)),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     value.detailDataMember?.name ?? "-",
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Divider(
//                     color: greyColor.withOpacity(0.3),
//                   ),
//                   Text(
//                     S.of(context).phone_number,
//                     style: TextStyle(
//                         fontSize: 12, color: greyColor.withOpacity(0.3)),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     value.detailDataMember?.phoneNumber.toString() ?? "-",
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Divider(
//                     color: greyColor.withOpacity(0.3),
//                   ),
//                   Text(
//                     S.of(context).email,
//                     style: TextStyle(
//                         fontSize: 12, color: greyColor.withOpacity(0.3)),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     value.detailDataMember?.email ?? "-",
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Divider(
//                     color: greyColor.withOpacity(0.3),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
