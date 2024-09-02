import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> listNotification = [
    {
      "title": S.current.profiling_results,
      "subtitle": "Description of result Profiling",
      "time": "15 minutes",
      "image": "assets/icons/person_add.png"
    },
    {
      "title": S.current.reset_password,
      "subtitle": "Description of result Profiling",
      "time": "15 minutes",
      "image": "assets/icons/person_add.png"
    },
    {
      "title": S.current.account_success,
      "subtitle": "Description of result Profiling",
      "time": "15 minutes",
      "image": "assets/icons/person_add.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).notification,
          style: TextStyle(color: whiteColor),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(
            S.of(context).coming_soon,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        //  ListView.separated(
        //     itemCount: listNotification.length,
        //     separatorBuilder: (context, index) {
        //       return Divider(
        //         color: naturalGrey.withOpacity(0.5),
        //       );
        //     },
        //     itemBuilder: (context, index) {
        //       return Dismissible(
        //         key: Key(listNotification[index]["title"]),
        //         direction: DismissDirection.endToStart,
        //         onDismissed: (direction) {
        //           setState(() {
        //             listNotification.removeAt(index);
        //           });
        //         },
        //         background: Container(color: Colors.red),
        //         child: itemNotification(
        //           title: listNotification[index]["title"],
        //           subtitle: listNotification[index]["subtitle"],
        //           time: listNotification[index]["time"],
        //           image: listNotification[index]["image"],
        //           onTap: () {
        //             setState(() {
        //               listNotification.removeAt(index);
        //             });
        //           },
        //         ),
        //       );
        //     }),
      ),
    );
  }

  Padding itemNotification(
      {required String title,
      required String subtitle,
      required String time,
      required String image,
      Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: greenColor.withOpacity(0.1)),
              child: Center(
                  child: Image.asset(
                image,
                width: 24,
              )),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ]),
            ),
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: onTap,
                  child: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                ))
          ])),
    );
  }
}
