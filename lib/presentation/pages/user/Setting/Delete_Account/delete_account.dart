// // ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

// import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
// import 'package:coolappflutter/data/provider/provider_user.dart';
// import 'package:coolappflutter/generated/l10n.dart';
// import 'package:coolappflutter/presentation/pages/user/Setting/Delete_Account/delete_account_email.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/utils/nav_utils.dart';
// import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:provider/provider.dart';

// class DeletedAccount extends StatefulWidget {
//   const DeletedAccount({super.key});

//   @override
//   State<DeletedAccount> createState() => _DeletedAccountState();
// }

// class _DeletedAccountState extends State<DeletedAccount> {
//   String? selectedItem;
//   bool isExpanded = false; // Track dropdown expansion

//   final List<String> items = ["Alasan 1", "Alasan 2", "Alasan 3"];

//   @override
//   void initState() {
//     super.initState();
//     selectedItem = "Alasan 1"; // Set default value to "Item 1"
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: Text(
//           S.of(context).Delete_Account,
//           style: TextStyle(color: Colors.white),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.only(top: 30,bottom: 30,right: 20,left: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(child: Image.asset('images/Account_Delete.png')),
//             const SizedBox(
//               height: 30,
//             ),
//             Text(
//               S.of(context).Do_You_Want_To_Delete_Account,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ) ,
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               S.of(context).Please_Tell_Us_Why,
//               style: TextStyle(fontSize: 14),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey)

//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   value: selectedItem,
//                   isExpanded: true, // Ensures full width
//                   icon: Icon(
//                     isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedItem = value;
//                     });
//                   },
//                   onTap: () {
//                     // Toggle icon direction
//                     setState(() {
//                       isExpanded = !isExpanded;
//                     });
//                   },
//                   items: items.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(item),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(S.of(context).Your_Story_Helps),
//             const SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               maxLines: 5,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderSide:
//                       const BorderSide(color: Colors.white, width: 1),
//                       borderRadius: BorderRadius.circular(10)),
//                   hintText: S.of(context).Tell_Us_Here),
//             ),
//             Spacer(),
//             GlobalButton(
//               onPressed: () {
//                 Nav.to(DeletedEmail());
//               },
//               color: Colors.red,
//               text: S.of(context).Delete_Account,
//             )

//           ],
//         ),
//       ),

//       //old code
//       // body: ChangeNotifierProvider(
//       //   create: (_) => ProviderUser(),
//       //   child: Consumer<ProviderUser>(
//       //     builder: (context, provider, child) {
//       //       return Stack(
//       //         children: [
//       //           InAppWebView(
//       //             initialUrlRequest: URLRequest(
//       //               url: Uri.parse(
//       //                   '${ApiEndpoint.baseUrl}/users/delete/account'),
//       //             ),
//       //             onLoadStart: (controller, url) {
//       //               provider.setLoading(true);
//       //             },
//       //             onLoadStop: (controller, url) async {
//       //               provider.setLoading(false);
//       //             },
//       //             onLoadError: (controller, url, code, message) {
//       //               provider.setLoading(false);
//       //             },
//       //             onLoadHttpError: (controller, url, statusCode, description) {
//       //               provider.setLoading(false);
//       //             },
//       //             initialOptions: InAppWebViewGroupOptions(
//       //               android: AndroidInAppWebViewOptions(
//       //                 useHybridComposition: true,
//       //               ),
//       //             ),
//       //           ),
//       //           if (provider.isLoading)
//       //             const Center(child: CircularProgressIndicator()),
//       //         ],
//       //       );
//       //     },
//       //   ),
//       // ),
//     );
//   }
// }
