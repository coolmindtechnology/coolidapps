import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/data/response/res_list_ebook.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/detail_baca_ebook.dart';
import 'package:coolappflutter/presentation/pages/main/ebook/detail_ebook.dart';
import 'package:coolappflutter/presentation/pages/main/read_book.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSemuaEbook extends StatefulWidget {
  const ListSemuaEbook(
      {super.key, required this.titlePage, required this.data});
  final String titlePage;
  final String data;

  @override
  State<ListSemuaEbook> createState() => _ListSemuaEbookState();
}

class _ListSemuaEbookState extends State<ListSemuaEbook>
    with SingleTickerProviderStateMixin {
  List<String> listImg = [
    "images/buku/image-book.png",
    "images/buku/img-yellow.png",
    "images/buku/img-red.png"
  ];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _tabController.index;
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProviderBook provider = ProviderBook();
    return ChangeNotifierProvider(create: (BuildContext context) {
      return ProviderBook.initAllBook(context);
    }, child: Consumer<ProviderBook>(
        builder: (BuildContext context, value, Widget? child) {
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
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextField(
                    controller: value.searchController,
                    onChanged: (text) {
                      value.updateSearchController(text);
                    },
                    decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: () {
                            value.updateSearchController("");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.asset(
                              "images/buku/search-buku.png",
                              color: blueContainer,
                              width: 10,
                              height: 10,
                            ),
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
              // if (widget.data == "rak") gapH16,
              // if (widget.data == "rak")
              //   Padding(
              //     padding: const EdgeInsets.only(left: 15, bottom: 10),
              //     child: Row(
              //       children: [
              //         Text(
              //           "Terakhir dibaca!",
              //           style: TextStyle(
              //               fontSize: 15, fontWeight: FontWeight.bold),
              //         ),
              //       ],
              //     ),
              //   ),
              // if (widget.data == "rak")
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       height: 100,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border.all(
              //           // Menambahkan outline abu-abu
              //           color: const Color.fromARGB(255, 226, 225, 225),
              //           width: 1.5,
              //         ),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Row(
              //           children: [
              //             Image.asset("images/buku/img-red.png"),
              //             gapW10,
              //             Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Text(
              //                   "HUMAN BOOK",
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //                 gapH10,
              //                 Text(
              //                   "Chapter 1- Hal 62",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Spacer(),
              //             SizedBox(
              //               height: 40,
              //               child: ElevatedButton(
              //                   style: ElevatedButton.styleFrom(
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(
              //                             10), // Menghilangkan border radius
              //                         side: BorderSide(
              //                             color: Colors
              //                                 .transparent), // Menghilangkan border
              //                       ),
              //                       backgroundColor: Colors.white),
              //                   onPressed: () {
              //                     Navigator.push(
              //                         context,
              //                         (MaterialPageRoute(
              //                             builder: (context) =>
              //                                 DetailBacaEbook())));
              //                   },
              //                   child: Text(
              //                     "Lanjut Baca",
              //                     style: TextStyle(
              //                       color: primaryColor,
              //                     ),
              //                   )),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              gapH10,
              if (widget.data == "rak")
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
              gapH16,
              if (widget.data == "rak")
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        _tabController.index == 0
                            ? "${value.displayFree.length} Buku Gratis Dimiliki"
                            : "${value.displayPremium.length} Buku Berbayar Dimiliki",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              if (widget.data == "rak")
                SizedBox(
                  height: 220,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildListFree(value),
                      _buildListPremium(value),
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              // if (widget.data == "rak")
              //   SizedBox(
              //     height: 210,
              //     child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: value.displayFree.length,
              //         itemBuilder: (context, index) {
              //           DataBook data = value.displayFree[index];
              //           return GestureDetector(
              //             onTap: () {
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => DetailEbookNew(
              //                             isPay: 'false',
              //                           )));
              //             },
              //             child: Padding(
              //               padding: const EdgeInsets.all(5.0),
              //               child: SizedBox(
              //                 height: 100,
              //                 width: 120,
              //                 child: Card(
              //                   color: Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Padding(
              //                         padding: const EdgeInsets.all(4.0),
              //                         child: SizedBox(
              //                           height: 90,
              //                           width: double.infinity,
              //                           child: Image.network(
              //                             "${data.imagePath ?? ""}",
              //                             fit: BoxFit.cover,
              //                           ),
              //                         ),
              //                       ),
              //                       gapH10,
              //                       Padding(
              //                         padding: const EdgeInsets.only(
              //                             left: 5, right: 5),
              //                         child: Text(data.title.toString().length > 9
              //                             ? data.title.toString().substring(0, 10)
              //                             : data.title.toString()),
              //                       ),
              //                       Padding(
              //                         padding: const EdgeInsets.all(6.0),
              //                         child: Row(
              //                           children: [
              //                             Text(
              //                               data.isPremium == 0
              //                                   ? "Gratis"
              //                                   : "Premium",
              //                               style: TextStyle(fontSize: 8),
              //                             ),
              //                             Spacer(),
              //                             Icon(
              //                               Icons.star,
              //                               color: Colors.amber,
              //                               size: 15,
              //                             ),
              //                             Text(
              //                               data.rating.toString() == "null"
              //                                   ? "0"
              //                                   : data.rating.toString(),
              //                               style: TextStyle(fontSize: 8),
              //                             )
              //                           ],
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: SizedBox(
              //                           height: 30,
              //                           child: ElevatedButton(
              //                               style: ElevatedButton.styleFrom(
              //                                   shape: RoundedRectangleBorder(
              //                                     borderRadius: BorderRadius.circular(
              //                                         5), // Menghilangkan border radius
              //                                     side: BorderSide(
              //                                         color: Colors
              //                                             .transparent), // Menghilangkan border
              //                                   ),
              //                                   backgroundColor:
              //                                       const Color.fromARGB(
              //                                           210, 255, 255, 255)),
              //                               onPressed: () {
              //                                 Nav.to(ReadBook("${data.filePath}",
              //                                     "${data.title}"));
              //                               },
              //                               child: Text(
              //                                 "Baca Buku",
              //                                 style: TextStyle(fontSize: 10),
              //                               )),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           );
              //         }),
              //   ),
              if (widget.data != "rak")
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
                                              backgroundColor:
                                                  const Color.fromARGB(
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              if (widget.data != "rak")
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
                                              backgroundColor:
                                                  const Color.fromARGB(
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
    }));
  }

  Widget _buildListPremium(value) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: value.displayPremium.length,
          itemBuilder: (context, index) {
            DataBook data = value.displayPremium[index];
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
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            height: 90,
                            width: double.infinity,
                            child: Image.network(
                              "${data.imagePath ?? ""}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        gapH10,
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(data.title.toString().length > 9
                              ? data.title.toString().substring(0, 10)
                              : data.title.toString()),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(6.0),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         data.isPremium == 0 ? "Gratis" : "Premium",
                        //         style: TextStyle(fontSize: 8),
                        //       ),
                        //       Spacer(),
                        //       Icon(
                        //         Icons.star,
                        //         color: Colors.amber,
                        //         size: 15,
                        //       ),
                        //       Text(
                        //         data.rating.toString() == "null"
                        //             ? "0"
                        //             : data.rating.toString(),
                        //         style: TextStyle(fontSize: 8),
                        //       )
                        //     ],
                        //   ),
                        // ),
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
                                  backgroundColor:
                                      const Color.fromARGB(210, 255, 255, 255)),
                              onPressed: () {
                                Nav.to(ReadBook(
                                    "${data.filePath}", "${data.title}"));
                              },
                              child: Text(
                                "Baca Buku",
                                style: TextStyle(fontSize: 10),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildListFree(value) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: value.displayFree.length,
          itemBuilder: (context, index) {
            DataBook data = value.displayFree[index];
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
                  height: 210,
                  width: 120,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            height: 90,
                            width: double.infinity,
                            child: Image.network(
                              "${data.imagePath ?? ""}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        gapH10,
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(data.title.toString().length > 9
                              ? data.title.toString().substring(0, 10)
                              : data.title.toString()),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(6.0),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         data.isPremium == 0 ? "Gratis" : "Premium",
                        //         style: TextStyle(fontSize: 8),
                        //       ),
                        //       Spacer(),
                        //       Icon(
                        //         Icons.star,
                        //         color: Colors.amber,
                        //         size: 15,
                        //       ),
                        //       Text(
                        //         data.rating.toString() == "null"
                        //             ? "0"
                        //             : data.rating.toString(),
                        //         style: TextStyle(fontSize: 8),
                        //       )
                        //     ],
                        //   ),
                        // ),
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
                                  backgroundColor:
                                      const Color.fromARGB(210, 255, 255, 255)),
                              onPressed: () {
                                Nav.to(ReadBook(
                                    "${data.filePath}", "${data.title}"));
                              },
                              child: Text(
                                "Baca Buku",
                                style: TextStyle(fontSize: 10),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
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
}
