import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/data/provider/provider_consultation.dart';
import 'package:coolappflutter/data/repositories/repo_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../rating.dart';

class ChatArchive extends StatefulWidget {
  final String imagePath;
  final String name;
  final String title;
  final String bloodType;
  final String location;
  final String time;
  final String timeRemaining;
  final Color timeColor;
  final String status;
  final Color warnastatus;
  final String getTopik;
  final String statusSession;
  final String deskripsi;
  final String idUser;
  final types.User? user;
  final String? idConsultant;
  final String? idConsultation;
  final String? idreciver;
  final dynamic? price;
  final String? type;
  final String? idDocument;
  final dynamic? rating;
  const ChatArchive({super.key,
  required this.imagePath,
  required this.name,
  required this.title,
  required this.bloodType,
  required this.location,
  required this.time,
  required this.timeRemaining,
  required this.timeColor,
  required this.status,
  required this.warnastatus,
  required this.getTopik,
  required this.statusSession,
  required this.deskripsi,
  required this.idUser,
  required this.price,
  required this.rating,
  required this.idDocument,
  this.user, required this.idConsultant,required this.idConsultation,required this.idreciver, this.type,});

  @override
  _ChatArchiveState createState() => _ChatArchiveState();
}

class _ChatArchiveState extends State<ChatArchive> {
  List<Map<String, String>> messages = [
    {
      "text":
          "Sejelek apapun masa lalumu, itu telah berlalu. Sekarang, fokus untuk kebahagiaan dirimu di masa depan.",
      "sender": "bot"
    },
    {"text": "Bagaimana bisa itu ya?", "sender": "user"},
    {
      "text":
          "Ketika kamu merasa kehilangan harapan, ingat bahwa Tuhan telah menciptakan rencana terindah untuk hidup kita.",
      "sender": "bot"
    },
    {"text": "Makasih ya", "sender": "user"},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ConsultantProvider>(context, listen: false)
          .getChatArchived(context, widget.idDocument.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
   return Consumer<ConsultantProvider>(builder: (context, value, child) {
     String sender = dataGlobal.dataUser!.email;
     return Scaffold(
       appBar: AppBar(
         title: Text(
           widget.getTopik,
           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
         ),
         centerTitle: true,
         actions: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: Colors.white,
                   border: Border.all(
                     color: Colors.red,
                     width: 5,
                   ),
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(2),
                   child: Text(
                     S.of(context).Archives,
                     style: TextStyle(
                       fontSize: 18,
                       color: Colors.red,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ),
               ),
             ),
           ),
         ],
       ),
       body: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(20),
             child: SizedBox(
               width: double.infinity,
               height: 100,
               child: Row(
                 children: [
                   ClipOval(
                     child: Image.network(
                       widget.imagePath,
                       height: 90,
                       width: 90,
                       fit: BoxFit.cover,
                     ),
                   ),
                   SizedBox(
                     width: 20,
                   ),
                   Column(
                     children: [
                       Row(
                         children: [
                           Text(widget.name,
                               style: TextStyle(fontWeight: FontWeight.w600)),
                           SizedBox(
                             width: 40,
                           ),
                           Text(
                             widget.title,
                             style: TextStyle(
                               fontWeight: FontWeight.w600,
                               color: Colors.orange,
                               fontSize: 15,
                             ),
                           )
                         ],
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       Container(
                           decoration: BoxDecoration(
                               color: BlueColor,
                               borderRadius: BorderRadius.circular(10)),
                           height: 40,
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: [
                                 Text(
                                   widget.getTopik,
                                   style: TextStyle(color: Colors.white),
                                 ),
                                 SizedBox(
                                   width: 20,
                                 ),
                                 Text(
                                   widget.time,
                                   style: TextStyle(color: Colors.white),
                                 ),
                               ],
                             ),
                           )),
                     ],
                   )
                 ],
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(20),
             child: Container(
               color: Colors.red[50],
               padding: EdgeInsets.all(10),
               child: Text(
                 S.of(context).Session_Closed_Message,
                 style:
                 TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                 textAlign: TextAlign.center,
               ),
             ),
           ),
           SizedBox(
             height: 50,
           ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: value.isLoadingChatArchived
                   ? const Center(child: CircularProgressIndicator())
                   : ListView.builder(
                 itemCount: value.chatArchivedData?.data.length ?? 0,
                 itemBuilder: (context, index) {
                   final message = value.chatArchivedData!.data[index];

                   // ⚡ Bandingkan EMAIL pengirim vs email user login
                   final isUser = message.senderEmail == sender;

                   return Align(
                     alignment:
                     isUser ? Alignment.centerRight : Alignment.centerLeft,
                     child: Container(
                       margin: const EdgeInsets.symmetric(
                           vertical: 5, horizontal: 10),
                       padding: const EdgeInsets.all(10),
                       decoration: BoxDecoration(
                         color: isUser ? Colors.blue[100] : Colors.grey[300],
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: Text(message.messageContent),
                     ),
                   );
                 },
               ),
             ),
           )


         ],
       ),
     );
    },);
  }
}
