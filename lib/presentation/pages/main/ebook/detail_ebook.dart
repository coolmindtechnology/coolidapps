import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/beri_rating.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/detail_baca_ebook.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class DetailEbookNew extends StatefulWidget {
  const DetailEbookNew({super.key, required this.isPay});
  final String isPay;

  @override
  State<DetailEbookNew> createState() => _DetailEbookNewState();
}

class _DetailEbookNewState extends State<DetailEbookNew> {
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
          "Detail buku",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  "images/buku/img-cover-b.png",
                  fit: BoxFit.cover,
                )),
            gapH20,
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Judul Buku",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            gapH10,
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Text(
                    "CoolTeam 17 October 2024 ",
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15,
                  ),
                  Text(
                    "4.0",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Usaha membangun satu inovasi Aplikasi untuk membuat profilin keperibadian bagi mengenali potensi diri yang kini bakal dilancarkan sekitar pasaran Asia Tenggara  -  Dian Sukma"),
            ),
            gapH20,
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Rating Terbaik",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            gapH10,
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Circle Image
                              ClipOval(
                                child: Image.asset(
                                  "images/face.png", // Ganti dengan path gambar Anda
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                  width: 10), // Jarak antara image dan teks

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Witrin Nany", // Title
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Emotion In", // Deskripsi
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12,
                              ),
                              Text(
                                "4.0",
                                style: TextStyle(fontSize: 12),
                              ),
                              gapW10,
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    );
                  }),
            ),
            if (widget.isPay == "false")
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Menghilangkan border radius
                          side: BorderSide(
                              color:
                                  Colors.transparent), // Menghilangkan border
                        ),
                        backgroundColor: primaryColor),
                    onPressed: () {},
                    child: Text(
                      "Beli RP200,000.00",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
            if (widget.isPay == "true")
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
                          height: 50,
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
                                      const Color.fromARGB(255, 204, 204, 204)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BeriRating()));
                              },
                              child: Text(
                                "Ratings",
                                style: TextStyle(
                                  color: Colors.yellow,
                                ),
                              )),
                        ),
                      ),
                      gapW10,
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // Menghilangkan border radius
                                    side: BorderSide(
                                        color: Colors
                                            .transparent), // Menghilangkan border
                                  ),
                                  backgroundColor: primaryColor),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailBacaEbook()));
                              },
                              child: Text(
                                "Lanjut Baca",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
