import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/detail_ebook.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/favorite_saya.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/list_semua_ebook.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/notes.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/ratings.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class HomeEbook extends StatefulWidget {
  const HomeEbook({super.key});

  @override
  State<HomeEbook> createState() => _HomeEbookState();
}

class _HomeEbookState extends State<HomeEbook> {
  List<String> listName = ["Favorite Saya", "Notes", "Ratings"];

  List<String> listIcon = [
    "images/buku/lovv.png",
    "images/buku/notee.png",
    "images/buku/starr.png"
  ];

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
        title: const Text(
          "Book",
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
            gapH10,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: blueContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("images/buku/book-saya.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Buku Saya",
                            style: TextStyle(color: Colors.white),
                          ),
                          gapH10,
                          Text(
                            "42 Buku",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                                  MaterialPageRoute(
                                      builder: (context) => ListSemuaEbook(
                                          titlePage: "Rak Buku Saya",
                                          data: "rak")));
                            },
                            child: Text("Rak buku saya")),
                      )
                    ],
                  ),
                ),
              ),
            ),
            gapH10,
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listName.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5), // Menghilangkan border radius
                                side: BorderSide(
                                    color: Colors
                                        .transparent), // Menghilangkan border
                              ),
                              backgroundColor:
                                  const Color.fromARGB(230, 255, 255, 255)),
                          onPressed: () {
                            debugPrint("ontaps ${listName[index]}");
                            listName[index] == "Favorite Saya"
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FavoriteSaya()))
                                : listName[index] == "Notes"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NotesEbook()))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RatingsEbook()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(listIcon[index]),
                              gapW10,
                              Text(
                                listName[index],
                                style: TextStyle(
                                    color: listName[index] == "Favorite Saya"
                                        ? Colors.red
                                        : listName[index] == "Notes"
                                            ? Colors.green
                                            : const Color.fromARGB(
                                                255, 124, 112, 3)),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            gapH16,
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Populer",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                                      onPressed: () {},
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
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Gratis untuk kamu!",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListSemuaEbook(
                                  titlePage: "Gratis Untuk Kamu", data: "")));
                    },
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(fontSize: 13, color: primaryColor),
                    ),
                  )
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
                                      onPressed: () {},
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
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Premium makin mantul!",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListSemuaEbook(
                                  titlePage: "Premium makin mantul",
                                  data: "")));
                    },
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(fontSize: 13, color: primaryColor),
                    ),
                  )
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
                                      onPressed: () {},
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
