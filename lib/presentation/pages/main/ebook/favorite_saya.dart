import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FavoriteSaya extends StatefulWidget {
  const FavoriteSaya({super.key});

  @override
  State<FavoriteSaya> createState() => _FavoriteSayaState();
}

class _FavoriteSayaState extends State<FavoriteSaya>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> books = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchBooks(0); // Load default tab (Gratis)
    _tabController.addListener(() {
      fetchBooks(_tabController.index);
    });
  }

  Future<void> fetchBooks(int tabIndex) async {
    final String? token = await Prefs().getToken();
    String url = tabIndex == 0
        ? '${ApiEndpoint.baseUrl}/api/fav/ebook?type_fav=0'
        : '${ApiEndpoint.baseUrl}/api/fav/ebook?type_fav=1';
    try {
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.data['success']) {
        setState(() {
          books = List<Map<String, dynamic>>.from(response.data['data']);
        });
      }
    } catch (e) {
      print("Error fetching books: $e");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          "Favorite Saya",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: const [],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(255, 226, 225, 225),
                  width: 1.5,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.transparent,
                ),
                labelPadding: EdgeInsets.zero,
                tabs: [
                  _buildTab("Gratis", Color(0xFF4CCBF4), Colors.white, 0),
                  _buildTab("Berbayar", Colors.white, Colors.black, 1),
                ],
              ),
            ),
          ),
          gapH20,
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 10),
            child: Row(
              children: [
                Text(
                  "${books.length} Buku Gratis Dalam Favorit",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBookList(),
                _buildBookList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, Color bgColor, Color textColor, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tabController.index = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          height: 42,
          decoration: BoxDecoration(
            color: _tabController.index == index
                ? Color(0xFF4CCBF4)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: index == 0 ? Radius.circular(10) : Radius.zero,
              topRight: index == 1 ? Radius.circular(10) : Radius.zero,
              bottomLeft: index == 0 ? Radius.circular(10) : Radius.zero,
              bottomRight: index == 1 ? Radius.circular(10) : Radius.zero,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color:
                  _tabController.index == index ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookList() {
    return books.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: books.length,
            itemBuilder: (context, index) {
              var book = books[index];
              return Card(
                color: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      book['img_path'],
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    book['title_ebook'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(book['summary_ebook']),
                  onTap: () {},
                ),
              );
            },
          )
        : Center(
            child: Text(S.of(context).no_data),
          );
  }
}
