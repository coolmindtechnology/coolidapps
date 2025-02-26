import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class RatingsEbook extends StatefulWidget {
  const RatingsEbook({super.key});

  @override
  State<RatingsEbook> createState() => _RatingsEbookState();
}

class _RatingsEbookState extends State<RatingsEbook> {
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
          "Ratings",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          gapH16,
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
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Row(
              children: [
                Text(
                  "24 Buku Gratis Diberi Rating",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          gapH10,
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            8), // Agar gambar tidak kotak keras
                        child: Image.asset(
                          "images/buku/img-red.png", // Ganti dengan path gambar yang sesuai
                          width: 50,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        "Judul Buku",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rating Di berikan"),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 15,
                                ),
                                Text(
                                  "4.0",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Colors.grey, size: 16),
                      onTap: () {
                        // Aksi saat item diklik
                      },
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
