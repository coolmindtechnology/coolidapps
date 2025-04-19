import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class BeriRating extends StatefulWidget {
  const BeriRating({super.key});

  @override
  State<BeriRating> createState() => _BeriRatingState();
}

class _BeriRatingState extends State<BeriRating> {
  @override
  Widget build(BuildContext context) {
    final ratingProvider = Provider.of<ProviderBook>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("images/buku/arrowleft.png")),
        title: Text(
          "Ratings",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5), // Menghilangkan border radius
                    side: BorderSide(
                        color: Colors.transparent), // Menghilangkan border
                  ),
                  backgroundColor: Colors.white),
              onPressed: () {},
              child: Text(
                "Kirim",
                style: TextStyle(color: primaryColor),
              )),
          gapW10,
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: SizedBox(
                height: 100, // Tinggi card agar gambar penuh
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child: SizedBox(
                        width: 100, // Tentukan lebar gambar agar stabil
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          child: Image.asset(
                            "images/buku/image-book.png",
                            fit: BoxFit.cover,
                            height: double
                                .infinity, // Pastikan gambar memenuhi tinggi Card
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Judul Buku",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "CoolTeam 17 October 2024 ",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 15,
                                ),
                                Text(
                                  "4.0",
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                            gapH4,
                            Expanded(
                              child: Text(
                                " Usaha membangun satu inovasi Aplikasi untuk membuat profilin keperibadian bagi mengenali potensi diri yang kini bakal dilancarkan sekitar pasaran Asia Tenggara -  Dian Sukma",
                                style: TextStyle(fontSize: 8),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.arrow_forward_ios,
                          color: Colors.grey, size: 16),
                    ),
                  ],
                ),
              ),
            ),

            gapH20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Beri Rating anda",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Berikan rating sesuai pengalaman anda"),
                ],
              ),
            ),
            gapH20,

            // Widget Rating Bar
            RatingBar.builder(
              initialRating: ratingProvider.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                ratingProvider.setRating(rating);
              },
            ),
            gapH20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        "Ceritakan pada kami, apa yang anda suka dari buku yang telah dibaca"),
                  ),
                ],
              ),
            ),
            gapH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOutlinedText("Penulisan"),
                gapW10, // Jarak antar teks
                _buildOutlinedText("Pembawaan Cerita"),
              ],
            ),
            gapH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOutlinedText("Materi Disampaikan"),
                gapW10, // Jarak antar teks
                _buildOutlinedText("Motivasi Diberikan"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlinedText(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Outline abu-abu
        borderRadius: BorderRadius.circular(8), // Sudut melengkung
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
