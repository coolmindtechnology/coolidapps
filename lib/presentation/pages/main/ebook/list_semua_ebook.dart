import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/detail_baca_ebook.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/detail_ebook.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class ListSemuaEbook extends StatefulWidget {
  const ListSemuaEbook(
      {super.key, required this.titlePage, required this.data});
  final String titlePage;
  final String data;

  @override
  State<ListSemuaEbook> createState() => _ListSemuaEbookState();
}

class _ListSemuaEbookState extends State<ListSemuaEbook> {
  List<String> listImg = [
    "images/buku/image-book.png",
    "images/buku/img-yellow.png",
    "images/buku/img-red.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("images/buku/arrowleft.png")),
        title: Text(
          widget.titlePage,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Image.asset(
                          "images/buku/search-buku.png",
                          color: blueContainer,
                          width: 10,
                          height: 10,
                        ),
                      ),
                      hintText: "Cari Judul Buku",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.p10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      )),
                ),
              ),
            ),
            if (widget.data == "rak") gapH16,
            if (widget.data == "rak")
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Terakhir dibaca!",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            if (widget.data == "rak")
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      // Menambahkan outline abu-abu
                      color: const Color.fromARGB(255, 226, 225, 225),
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("images/buku/img-red.png"),
                        gapW10,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "HUMAN BOOK",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            gapH10,
                            Text(
                              "Chapter 1- Hal 62",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Menghilangkan border radius
                                    side: BorderSide(
                                        color: Colors
                                            .transparent), // Menghilangkan border
                                  ),
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    (MaterialPageRoute(
                                        builder: (context) =>
                                            DetailBacaEbook())));
                              },
                              child: Text(
                                "Lanjut Baca",
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            gapH10,
            if (widget.data == "rak")
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    // Menambahkan outline abu-abu
                    color: const Color.fromARGB(255, 226, 225, 225),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Menghilangkan border radius
                                    side: BorderSide(
                                        color: Colors
                                            .transparent), // Menghilangkan border
                                  ),
                                  backgroundColor: primaryColor),
                              onPressed: () {},
                              child: Text(
                                "Gratis",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Menghilangkan border radius
                                    side: BorderSide(
                                        color: Colors
                                            .transparent), // Menghilangkan border
                                  ),
                                  backgroundColor: Colors.white),
                              onPressed: () {},
                              child: Text(
                                "Berbayar",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            gapH16,
            if (widget.data == "rak")
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "24 Buku Gratis Dimiliki",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            if (widget.data == "")
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Populer",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 210,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listImg.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailEbookNew(
                                      isPay: 'false',
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 100,
                          width: 120,
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Image.asset(
                                  listImg[index],
                                ),
                                gapH10,
                                Text("Judul Buku"),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Gratis",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 15,
                                      ),
                                      Text(
                                        "4.0",
                                        style: TextStyle(fontSize: 8),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Menghilangkan border radius
                                            side: BorderSide(
                                                color: Colors
                                                    .transparent), // Menghilangkan border
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                              210, 255, 255, 255)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailEbookNew(
                                                      isPay: 'true',
                                                    )));
                                      },
                                      child: Text(
                                        "Baca Buku",
                                        style: TextStyle(fontSize: 10),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            gapH16,
            if (widget.data == "")
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Terbaru",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 210,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listImg.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailEbookNew(
                                      isPay: 'false',
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 100,
                          width: 120,
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Image.asset(
                                  listImg[index],
                                ),
                                gapH10,
                                Text("Judul Buku"),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Gratis",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 15,
                                      ),
                                      Text(
                                        "4.0",
                                        style: TextStyle(fontSize: 8),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Menghilangkan border radius
                                            side: BorderSide(
                                                color: Colors
                                                    .transparent), // Menghilangkan border
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                              210, 255, 255, 255)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailEbookNew(
                                                      isPay: 'true',
                                                    )));
                                      },
                                      child: Text(
                                        "Baca Buku",
                                        style: TextStyle(fontSize: 10),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
