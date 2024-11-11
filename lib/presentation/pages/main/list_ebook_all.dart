import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/data/response/res_list_ebook.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/card_book.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListEbookAll extends StatefulWidget {
  const ListEbookAll({super.key});

  @override
  State<ListEbookAll> createState() => _ListEbookAllState();
}

class _ListEbookAllState extends State<ListEbookAll> {
  TabBar get _tabBar => TabBar(
        labelColor: primaryColor, //<-- selected text color
        unselectedLabelColor: primaryColor, //<-- Unselected text color
        indicatorColor: primaryColor,

        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,

        tabs: [
          Tab(
            text: S.current.all,
          ),
          Tab(
            text: S.current.free,
          ),
          Tab(
            text: S.current.premium,
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderBook.initAllBook(context);
      },
      child: Consumer<ProviderBook>(
          builder: (BuildContext context, value, Widget? child) {
        return DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: value.isSearch
                  ? TextField(
                      controller: value.searchController,
                      cursorColor: whiteColor,
                      onChanged: (text) {
                        value.updateSearchController(text);
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              value.updateSearchController("");
                            },
                            child:
                                const Icon(Icons.cancel, color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: whiteColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: whiteColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: whiteColor),
                        ),
                      ),
                    )
                  : const Text(
                      "Ebook",
                      style: TextStyle(color: Colors.white),
                    ),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: primaryColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      value.toggleSearch();
                    },
                    child: Image.asset(
                      "images/chat/search.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Material(
                  color: whiteColor,
                  child: _tabBar,
                ),
              ),
            ),
            body: TabBarView(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      if (value.isAllEbook) ...[
                        ShimmerLoadingWidget(
                            height: 100,
                            width: MediaQuery.of(context).size.width),
                        const SizedBox(
                          height: 10,
                        ),
                        ShimmerLoadingWidget(
                            height: 100,
                            width: MediaQuery.of(context).size.width),
                        const SizedBox(
                          height: 10,
                        ),
                        ShimmerLoadingWidget(
                            height: 100,
                            width: MediaQuery.of(context).size.width),
                      ] else ...[
                        if (value.display.isEmpty) ...[
                          Center(child: Text(S.of(context).no_data))
                        ] else ...[
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.display.length,
                            itemBuilder: (context, index) {
                              DataBook data = value.display[index];
                              return CardBook(
                                data: data,
                                provider: value,
                                onUpdate: () {
                                  value.getListEbook(context);
                                  value.getAllBook(context);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          ),
                        ],
                      ],
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      if (value.isAllEbook) ...[
                        ShimmerLoadingWidget(
                            height: 100,
                            width: MediaQuery.of(context).size.width),
                        const SizedBox(
                          height: 10,
                        ),
                        ShimmerLoadingWidget(
                            height: 100,
                            width: MediaQuery.of(context).size.width),
                        const SizedBox(
                          height: 10,
                        ),
                        ShimmerLoadingWidget(
                            height: 100,
                            width: MediaQuery.of(context).size.width),
                      ] else ...[
                        if (value.displayFree.isEmpty) ...[
                          Center(child: Text(S.of(context).no_data))
                        ] else ...[
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.displayFree.length,
                            itemBuilder: (context, index) {
                              DataBook data = value.displayFree[index];

                              return CardBook(
                                data: data,
                                provider: value,
                                onUpdate: () {
                                  value.getListEbook(context);
                                  value.getAllBook(context);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          ),
                        ],
                      ],
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      if (value.isAllEbook) ...[
                        ShimmerLoadingWidget(
                            height: 100,
                            width: MediaQuery.of(context).size.width),
                        const SizedBox(
                          height: 10,
                        ),
                        ShimmerLoadingWidget(
                            height: 100,
                            width: MediaQuery.of(context).size.width),
                        const SizedBox(
                          height: 10,
                        ),
                        ShimmerLoadingWidget(
                            height: 100,
                            width: MediaQuery.of(context).size.width),
                      ] else ...[
                        if (value.displayPremium.isEmpty) ...[
                          Center(child: Text(S.of(context).no_data))
                        ] else ...[
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.displayPremium.length,
                            itemBuilder: (context, index) {
                              DataBook data = value.displayPremium[index];

                              return CardBook(
                                data: data,
                                provider: value,
                                onUpdate: () {
                                  value.getListEbook(context);
                                  value.getAllBook(context);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          ),
                        ],
                      ],
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
