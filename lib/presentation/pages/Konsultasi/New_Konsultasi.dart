import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Sesi_Card.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Sessions_time.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';

class NewKonsultasi extends StatefulWidget {
  const NewKonsultasi({super.key});

  @override
  State<NewKonsultasi> createState() => _NewKonsultasiState();
}

class _NewKonsultasiState extends State<NewKonsultasi> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {
        'imagePath': 'images/konsultasi/Item1.jpeg',
        'title': S.of(context).personality,
        'subtitle': S.of(context).PERSONALITY_desc
      },
      {
        'imagePath': 'images/konsultasi/item2.jpeg',
        'title': S.of(context).personality,
        'subtitle': S.of(context).PERSONALITY_desc
      },
      {
        'imagePath': 'images/konsultasi/item3.jpeg',
        'title': S.of(context).personality,
        'subtitle': S.of(context).PERSONALITY_desc
      },
      {
        'imagePath': 'images/konsultasi/item4.jpeg',
        'title': S.of(context).personality,
        'subtitle': S.of(context).PERSONALITY_desc
      },
      // Tambahkan lebih banyak data sesuai kebutuhan
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).New_consultation_session,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              Colors.white,
            ],
            stops: [0.1, 0.35],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                S.of(context).Consult_personality,
                style: TextStyle(
                    color: BlueColor, fontWeight: FontWeight.w600, fontSize: 20),
              ),
              SizedBox(height: 5,),
              Text(
                S.of(context).Free_once_daily,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: S.of(context).Search,
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Membungkus GridView dengan Expanded agar bisa mendapatkan ruang yang tepat
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Jumlah kolom grid
                      crossAxisSpacing: 20.0, // Spasi horizontal antar item
                      mainAxisSpacing: 20.0, // Spasi vertikal antar item
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Nav.to(SessionTime());
                        },
                        child: SesiCrad(
                          imagePath: data[index]['imagePath']!,
                          title: data[index]['title']!,
                          subtitle: data[index]['subtitle']!,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
