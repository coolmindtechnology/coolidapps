import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/ebook/component/custom_button.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EbookDashboard extends StatefulWidget {
  const EbookDashboard({super.key});

  @override
  State<EbookDashboard> createState() => _EbookDashboardState();
}

class _EbookDashboardState extends State<EbookDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(S.of(context).ebook, style: TextStyle(color: whiteColor)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            gapH20,
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Image.asset('images/symbols_book.png',height: 40,fit: BoxFit.cover,),
                    gapW10,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Buku Saya',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
                        Text('42 Buku',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Rak Buku Saya',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                      ),
                    )


                  ],
                ),
              ),
            ),
            gapH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  icon: CupertinoIcons.heart,
                  text: 'Favorit Saya',
                  color: Colors.red,
                  onTap: () {
                    print('Tombol Favorit ditekan');
                  },
                ),
                CustomButton(
                  icon: Icons.sticky_note_2_outlined,
                  text: 'Note',
                  color: Colors.green,
                  onTap: () {
                    print('Tombol Favorit ditekan');
                  },
                ),
                CustomButton(
                  icon: Icons.star_border,
                  text: 'Rating',
                  color: DarkYellow,
                  onTap: () {
                    print('Tombol Favorit ditekan');
                  },
                ),
              ],
            ),
            gapH20,
            Text('Populer!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            gapH20,
            Text('Gratis untuk kamu!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            gapH20,
            Text('Premium makin mantul!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          ],
        ),
      ),
    );
  }
}
