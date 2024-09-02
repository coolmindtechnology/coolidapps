import 'package:cool_app/data/provider/provider_cool_chat.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/chat/chat_profile.dart';
import 'package:cool_app/presentation/pages/chat/screen_detail_postingan.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/widgets/refresh_icon_widget.dart';
import 'package:cool_app/presentation/widgets/shimmer_loading_widget_many.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  TextEditingController controllerSearch = TextEditingController();
  late TabController tabController;
  final ScrollController _scrollController = ScrollController();
  // final provider = ProviderCoolChat();

  Future<void> _onRefresh() async {
    context
        .read<ProviderCoolChat>()
        .refreshSearchAnything(context, controllerSearch.text);
  }

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll &&
        context.read<ProviderCoolChat>().hasMore) {
      context
          .read<ProviderCoolChat>()
          .searchAnything(context, controllerSearch.text);
    }
  }

  @override
  void initState() {
    context.read<ProviderCoolChat>();
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    _scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controllerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCoolChat>(builder: (_, provider, __) {
      return Scaffold(
        appBar: AppBar(
            title: TextField(
          controller: controllerSearch,
          cursorColor: whiteColor,
          onChanged: (text) {
            if (text.isNotEmpty) {
              Future.delayed(const Duration(seconds: 1), () async {
                provider.refreshSearchAnything(context, text);
              });
            }
          },
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
                onTap: () {
                  controllerSearch.clear();
                },
                child: const Icon(Icons.cancel, color: Colors.white)),
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
        )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TabBar(
              controller: tabController,
              tabs: [
                Tab(text: S.of(context).profiling),
                Tab(
                  text: S.of(context).post,
                ),
              ],
              labelColor: primaryColor,
              unselectedLabelColor: primaryColor,
              indicatorColor: primaryColor,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              // isScrollable: true,
              // tabAlignment: TabAlignment.start,
            ),
            Expanded(
                child: TabBarView(controller: tabController, children: [
              CustomMaterialIndicator(
                onRefresh: _onRefresh,
                indicatorBuilder:
                    (BuildContext context, IndicatorController controller) {
                  return const RefreshIconWidget();
                },
                child: provider.isLoading
                    ? const ShimmerLoadingWidgetMany(
                        itemBuilderHeight: 156,
                        separatorBuilderHeight: 10,
                        itemCount: 5,
                      )
                    : provider.profilingSearch.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: provider.hasMore
                                ? provider.profilingSearch.length + 1
                                : provider.profilingSearch.length,
                            itemBuilder: (context, index) {
                              if (index < provider.profilingSearch.length) {
                                return GestureDetector(
                                  onTap: () {
                                    Nav.to(ChatProfile(
                                      etSearch: controllerSearch.text,
                                      dataProfiling:
                                          provider.profilingSearch[index],
                                      idUser: provider
                                          .profilingSearch[index].idUser
                                          .toString(),
                                      idprofiling: provider
                                          .profilingSearch[index].idUser
                                          .toString(),
                                    ));
                                  },
                                  child: ListTile(
                                    title: Text(provider.profilingSearch[index]
                                            .dataProfile?.name ??
                                        ""),
                                    subtitle: Text(
                                      "${provider.profilingSearch[index].resultName?.name ?? "-"} • ${provider.profilingSearch[index].dataProfile?.domicile ?? "-"} • ${provider.profilingSearch[index].dataProfile?.bloodType ?? "-"}",
                                      style: TextStyle(color: greyColor),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                  ),
                                );
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: CircularProgressWidget(),
                                );
                              }
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                thickness: 1,
                              );
                            },
                          )
                        : const SizedBox(),
              ),
              CustomMaterialIndicator(
                onRefresh: _onRefresh,
                indicatorBuilder:
                    (BuildContext context, IndicatorController controller) {
                  return const RefreshIconWidget();
                },
                child: provider.isLoading
                    ? const ShimmerLoadingWidgetMany(
                        itemBuilderHeight: 156,
                        separatorBuilderHeight: 10,
                        itemCount: 5,
                      )
                    : provider.postsSearch.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index < provider.postsSearch.length) {
                                return GestureDetector(
                                  onTap: () {
                                    Nav.to(ScreenDetailPostingan(
                                      data: provider.postsSearch[index],
                                    ));
                                  },
                                  child: ListTile(
                                    title: Text(
                                      provider.postsSearch[index].description ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      S.of(context).post,
                                      style: TextStyle(color: greyColor),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                  ),
                                );
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: CircularProgressWidget(),
                                );
                              }
                              ;
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                thickness: 1,
                              );
                            },
                            itemCount: provider.hasMore
                                ? provider.postsSearch.length + 1
                                : provider.postsSearch.length,
                          )
                        : const SizedBox(),
              ),
              // CustomMaterialIndicator(
              //   onRefresh: _onRefresh,
              //   indicatorBuilder:
              //       (BuildContext context, IndicatorController controller) {
              //     return const RefreshIconWidget();
              //   },
              //   child: provider.isLoading
              //       ? const ShimmerLoadingWidgetMany(
              //           itemBuilderHeight: 156,
              //           separatorBuilderHeight: 10,
              //           itemCount: 5,
              //         )
              //       : provider.profilingsSearch.isNotEmpty
              //           ? ListView.separated(
              //               shrinkWrap: true,
              //               physics: const NeverScrollableScrollPhysics(),
              //               itemBuilder: (context, index) {
              //                 if (index < provider.profilingsSearch.length) {
              //                   return GestureDetector(
              //                     onTap: () {
              //                       Nav.to(ChatProfile(
              //                         idUser: provider
              //                             .profilingsSearch[index].idUser
              //                             .toString(),
              //                       ));
              //                     },
              //                     child: ListTile(
              //                       title: Text(
              //                           provider.profilingsSearch[index].name ??
              //                               ""),
              //                       subtitle: Text(
              //                         provider.profilingsSearch[index]
              //                                 .domicile ??
              //                             "",
              //                         style: TextStyle(color: greyColor),
              //                       ),
              //                       contentPadding: EdgeInsets.zero,
              //                       visualDensity: const VisualDensity(
              //                           horizontal: 0, vertical: -4),
              //                     ),
              //                   );
              //                 } else {
              //                   return const Padding(
              //                     padding: EdgeInsets.all(15),
              //                     child: CircularProgressWidget(),
              //                   );
              //                 }
              //               },
              //               separatorBuilder: (context, index) {
              //                 return const Divider(
              //                   thickness: 1,
              //                 );
              //               },
              //               itemCount: provider.hasMore
              //                   ? provider.profilingsSearch.length + 1
              //                   : provider.profilingsSearch.length,
              //             )
              //           : const SizedBox(),
              // ),
              // CustomMaterialIndicator(
              //   onRefresh: _onRefresh,
              //   indicatorBuilder:
              //       (BuildContext context, IndicatorController controller) {
              //     return const RefreshIconWidget();
              //   },
              //   child: provider.isLoading
              //       ? const ShimmerLoadingWidgetMany(
              //           itemBuilderHeight: 156,
              //           separatorBuilderHeight: 10,
              //           itemCount: 5,
              //         )
              //       : provider.profilingsSearch.isNotEmpty
              //           ? ListView.separated(
              //               shrinkWrap: true,
              //               physics: const NeverScrollableScrollPhysics(),
              //               itemBuilder: (context, index) {
              //                 if (index < provider.profilingsSearch.length) {
              //                   return GestureDetector(
              //                     onTap: () {
              //                       Nav.to(ChatProfile(
              //                         idUser: provider
              //                             .profilingsSearch[index].idUser
              //                             .toString(),
              //                       ));
              //                     },
              //                     child: ListTile(
              //                       title: Text(
              //                           provider.profilingsSearch[index].name ??
              //                               ""),
              //                       subtitle: Text(
              //                         provider.profilingsSearch[index]
              //                                 .bloodType ??
              //                             "-",
              //                         style: TextStyle(color: greyColor),
              //                       ),
              //                       contentPadding: EdgeInsets.zero,
              //                       visualDensity: const VisualDensity(
              //                           horizontal: 0, vertical: -4),
              //                     ),
              //                   );
              //                 } else {
              //                   return const Padding(
              //                     padding: EdgeInsets.all(15),
              //                     child: CircularProgressWidget(),
              //                   );
              //                 }
              //               },
              //               separatorBuilder: (context, index) {
              //                 return const Divider(
              //                   thickness: 1,
              //                 );
              //               },
              //               itemCount: provider.hasMore
              //                   ? provider.profilingsSearch.length + 1
              //                   : provider.profilingsSearch.length,
              //             )
              //           : const SizedBox(),
              // ),
              // CustomMaterialIndicator(
              //   onRefresh: _onRefresh,
              //   indicatorBuilder:
              //       (BuildContext context, IndicatorController controller) {
              //     return const RefreshIconWidget();
              //   },
              //   child: provider.isLoading
              //       ? const ShimmerLoadingWidgetMany(
              //           itemBuilderHeight: 156,
              //           separatorBuilderHeight: 10,
              //           itemCount: 5,
              //         )
              //       : provider.postUserSearch.isNotEmpty
              //           ? ListView.separated(
              //               shrinkWrap: true,
              //               physics: const NeverScrollableScrollPhysics(),
              //               itemBuilder: (context, index) {
              //                 if (index < provider.postUserSearch.length) {
              //                   return GestureDetector(
              //                     onTap: () {
              //                       Nav.to(ScreenDetailPostingan(
              //                         data: provider.postUserSearch[index],
              //                       ));
              //                     },
              //                     child: ListTile(
              //                       title: Text(
              //                         provider.postUserSearch[index]
              //                                 .description ??
              //                             "",
              //                         overflow: TextOverflow.ellipsis,
              //                       ),
              //                       subtitle: Text(
              //                         S.of(context).post,
              //                         style: TextStyle(color: greyColor),
              //                       ),
              //                       contentPadding: EdgeInsets.zero,
              //                       visualDensity: const VisualDensity(
              //                           horizontal: 0, vertical: -4),
              //                     ),
              //                   );
              //                 } else {
              //                   return const Padding(
              //                     padding: EdgeInsets.all(15),
              //                     child: CircularProgressWidget(),
              //                   );
              //                 }
              //               },
              //               separatorBuilder: (context, index) {
              //                 return const SizedBox(
              //                   height: 8,
              //                 );
              //               },
              //               itemCount: provider.hasMore
              //                   ? provider.postUserSearch.length + 1
              //                   : provider.postUserSearch.length,
              //             )
              //           : const SizedBox(),
              // ),
              // CustomMaterialIndicator(
              //   onRefresh: _onRefresh,
              //   indicatorBuilder:
              //       (BuildContext context, IndicatorController controller) {
              //     return const RefreshIconWidget();
              //   },
              //   child: provider.isLoading
              //       ? const ShimmerLoadingWidgetMany(
              //           itemBuilderHeight: 156,
              //           separatorBuilderHeight: 10,
              //           itemCount: 5,
              //         )
              //       : provider.profilingResultSearch.isNotEmpty
              //           ? ListView.separated(
              //               shrinkWrap: true,
              //               physics: const NeverScrollableScrollPhysics(),
              //               itemBuilder: (context, index) {
              //                 if (index <
              //                     provider.profilingResultSearch.length) {
              //                   return GestureDetector(
              //                     onTap: () {
              //                       Nav.to(ChatProfile(
              //                         idUser: provider
              //                             .profilingResultSearch[index].id
              //                             .toString(),
              //                         idprofiling: provider
              //                             .profilingResultSearch[index]
              //                             .idProfiling,
              //                       ));
              //                     },
              //                     child: ListTile(
              //                       title: Text(provider
              //                               .profilingResultSearch[index]
              //                               .dataProfile
              //                               ?.name ??
              //                           ""),
              //                       subtitle: Text(
              //                         provider.profilingResultSearch[index]
              //                                 .resultName?.name ??
              //                             "",
              //                         style: TextStyle(color: greyColor),
              //                       ),
              //                       contentPadding: EdgeInsets.zero,
              //                       visualDensity: const VisualDensity(
              //                           horizontal: 0, vertical: -4),
              //                     ),
              //                   );
              //                 } else {
              //                   return const Padding(
              //                     padding: EdgeInsets.all(15),
              //                     child: CircularProgressWidget(),
              //                   );
              //                 }
              //               },
              //               separatorBuilder: (context, index) {
              //                 return const Divider(
              //                   thickness: 1,
              //                 );
              //               },
              //               itemCount: provider.hasMore
              //                   ? provider.profilingResultSearch.length + 1
              //                   : provider.profilingResultSearch.length,
              //             )
              //           : const SizedBox(),
              // ),
            ])),
          ]),
        ),
      );
    });
  }
}
