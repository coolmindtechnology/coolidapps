// import 'package:cool_app/data/models/data_post.dart';
// import 'package:cool_app/data/provider/provider_cool_chat.dart';
// import 'package:cool_app/presentation/pages/chat/screen_detail_postingan.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../data/networks/endpoint/api_endpoint.dart';
// import '../../../generated/l10n.dart';
// import '../../theme/color_utils.dart';
// import '../../utils/circular_progress_widget.dart';
// import '../../utils/nav_utils.dart';
// import 'chat_profile.dart';
//
// class ItemListCoolchat extends StatefulWidget {
//   final DataPost? data;
//   const ItemListCoolchat(
//     this.data, {
//     super.key,
//   });
//
//   @override
//   State<ItemListCoolchat> createState() => _ItemListCoolchatState();
// }
//
// class _ItemListCoolchatState extends State<ItemListCoolchat> {
//   bool isShare = false, isLike = false, isComment = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Nav.to(ScreenDetailPostingan(data: widget.data));
//       },
//       child: Container(
//         margin: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(width: 1, color: greyColor.withOpacity(0.1))),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         // Nav.to(ChatProfile(
//                         //     idUser: data.idUser,
//                         //     idprofiling: data.profiling?.idUser));
//                       },
//                       child: Image.asset(
//                         "images/face.png",
//                         width: 30,
//                         height: 30,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 12,
//                     ),
//                     // Text(
//                     //   "${value.userProfiling?.name ?? ""} .  ${widget.data?.createdAt?.hour} hours ago",
//                     //   style: TextStyle(fontSize: 12, color: greyColor),
//                     // )
//                   ],
//                 ),
//                 Image.asset(
//                   "images/chat/more.png",
//                   width: 24,
//                   height: 24,
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 40),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     height: 150,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: NetworkImage(
//                                 // data.multimedia
//                                 //             ?.elementAt(0)
//                                 //             .fileName
//                                 //             ?.contains(
//                                 //                 ".jpg") ==
//                                 //         true
//                                 //     ?
//                                 "${ApiEndpoint.imageUrlPost}${widget.data?.multimedia?.elementAt(0).path?.replaceAll("//", "/") ?? ""}"
//                                 // : "images/chat/gambar_chat1.png",
//                                 ),
//                             fit: BoxFit.cover)),
//                     // child: index == 1
//                     //     ? ClipRRect(
//                     //         borderRadius: BorderRadius.circular(10),
//                     //         child: Image.asset(
//                     //           "images/chat/play.png",
//                     //           height: 40,
//                     //           width: 40,
//                     //         ),
//                     //       )
//                     //     : const SizedBox(
//                     //         height: 0,
//                     //         width: 0,
//                     //       ),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Text(
//                     "${widget.data?.description}",
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           // await value.postReaction(
//                           //     data.id.toString());
//                           // setState(() {
//                           //   isLike = !isLike;
//                           // });
//                         },
//                         child: Image.asset(
//                           "images/chat/like.png",
//                           width: 20,
//                           height: 20,
//                           color: isLike == true ? primaryColor : greyColor,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 4,
//                       ),
//                       // Text(
//                       //   "${value.dataTotalCountByPost?.likes ?? "0"}+",
//                       //   style: TextStyle(
//                       //       color: greyColor.withOpacity(0.5),
//                       //       fontSize: 12),
//                       // ),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             isComment = !isComment;
//                           });
//                         },
//                         child: Image.asset(
//                           "images/chat/chat.png",
//                           width: 20,
//                           height: 20,
//                           color: isComment == true ? primaryColor : greyColor,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 4,
//                       ),
//                       // Text(
//                       //   "${value.dataTotalCountByPost?.comment ?? "0"}+",
//                       //   style: const TextStyle(
//                       //       color: Colors.black, fontSize: 12),
//                       // ),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               // value.getShareCode(
//                               //     context, widget.data?.id ?? 0);
//                               // setState(() {
//                               //   isShare = !isShare;
//                               // });
//                             },
//                             child: Image.asset(
//                               "images/chat/share.png",
//                               width: 20,
//                               height: 20,
//                               color: isShare == true ? primaryColor : greyColor,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 4,
//                           ),
//                           // Text(
//                           //   "${value.dataTotalCountByPost?.share ?? "0"}+",
//                           //   style: const TextStyle(
//                           //       color: Colors.black, fontSize: 12),
//                           // ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Divider(
//               thickness: 1,
//               color: greyColor.withOpacity(0.1),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: greyColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   width: 1,
//                   color: greyColor.withOpacity(0.2),
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     // controller: value.etComment,
//                     decoration: InputDecoration(
//                         hintText: S.of(context).what_to_discuss,
//                         hintStyle: TextStyle(color: greyColor.withOpacity(0.5)),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none)),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             "images/chat/vn.png",
//                             width: 24,
//                             height: 24,
//                           ),
//                           const SizedBox(
//                             width: 8,
//                           ),
//                           Image.asset(
//                             "images/chat/video.png",
//                             width: 24,
//                             height: 24,
//                           ),
//                           const SizedBox(
//                             width: 8,
//                           ),
//                           Image.asset(
//                             "images/chat/gambar.png",
//                             width: 24,
//                             height: 24,
//                           )
//                         ],
//                       ),
//                       // value.isComment
//                       //     ? CircularProgressWidget(
//                       //   color: primaryColor,
//                       // )
//                       //     :
//                       MaterialButton(
//                         elevation: 0,
//                         minWidth: 75,
//                         height: 28,
//                         color: primaryColor,
//                         textColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                         onPressed: () {
//                           // value.commentPost(widget.data?.id ?? 0,
//                           //     value.etComment.text, 1, onUpdate: () {
//                           //       // value.getListComment(
//                           //       //     widget.data?.id.toString() ?? "");
//                           //     });
//                         },
//                         child: Text(S.of(context).posting),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             )
//             // index == 1
//             //     ? Padding(
//             //         padding: const EdgeInsets.only(left: 16),
//             //         child: Column(
//             //           crossAxisAlignment:
//             //               CrossAxisAlignment.start,
//             //           children: [
//             //             Row(
//             //               mainAxisAlignment:
//             //                   MainAxisAlignment.start,
//             //               children: [
//             //                 Image.asset(
//             //                   "images/face.png",
//             //                   width: 30,
//             //                   height: 30,
//             //                 ),
//             //                 const SizedBox(
//             //                   width: 12,
//             //                 ),
//             //                 Text(
//             //                   "Thomas friens .  12 hours ago",
//             //                   style: TextStyle(
//             //                       fontSize: 12,
//             //                       color: greyColor),
//             //                 )
//             //               ],
//             //             ),
//             //             const Padding(
//             //               padding: EdgeInsets.only(left: 40),
//             //               child: Text(
//             //                 "Halo semuanya!!\nbagaimana kabarnya??",
//             //                 style: TextStyle(fontSize: 16),
//             //               ),
//             //             ),
//             //             Padding(
//             //               padding: const EdgeInsets.only(
//             //                   left: 40, top: 12),
//             //               child: Row(
//             //                 children: [
//             //                   Image.asset(
//             //                     "images/chat/like.png",
//             //                     width: 20,
//             //                     height: 20,
//             //                   ),
//             //                   const SizedBox(
//             //                     width: 4,
//             //                   ),
//             //                   Text(
//             //                     "2",
//             //                     style: TextStyle(
//             //                         color: greyColor
//             //                             .withOpacity(0.5),
//             //                         fontSize: 12),
//             //                   ),
//             //                   const SizedBox(
//             //                     width: 8,
//             //                   ),
//             //                   Image.asset(
//             //                     "images/chat/chat.png",
//             //                     width: 20,
//             //                     height: 20,
//             //                   ),
//             //                   const SizedBox(
//             //                     width: 4,
//             //                   ),
//             //                   const Text(
//             //                     "1",
//             //                     style: TextStyle(
//             //                         color: Colors.black,
//             //                         fontSize: 12),
//             //                   ),
//             //                   const SizedBox(
//             //                     width: 8,
//             //                   ),
//             //                   Image.asset(
//             //                     "images/chat/share.png",
//             //                     width: 20,
//             //                     height: 20,
//             //                   ),
//             //                 ],
//             //               ),
//             //             ),
//             //             Padding(
//             //               padding: const EdgeInsets.only(
//             //                   left: 16, top: 12),
//             //               child: Column(
//             //                 crossAxisAlignment:
//             //                     CrossAxisAlignment.start,
//             //                 children: [
//             //                   Row(
//             //                     mainAxisAlignment:
//             //                         MainAxisAlignment.start,
//             //                     children: [
//             //                       Image.asset(
//             //                         "images/chat/cae2.png",
//             //                         width: 30,
//             //                         height: 30,
//             //                       ),
//             //                       const SizedBox(
//             //                         width: 12,
//             //                       ),
//             //                       Text(
//             //                         "Thomas friens .  12 hours ago",
//             //                         style: TextStyle(
//             //                             fontSize: 12,
//             //                             color: greyColor),
//             //                       )
//             //                     ],
//             //                   ),
//             //                 ],
//             //               ),
//             //             )
//             //           ],
//             //         ),
//             //       )
//             //     : const SizedBox(
//             //         height: 0,
//             //         width: 0,
//             //       ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
