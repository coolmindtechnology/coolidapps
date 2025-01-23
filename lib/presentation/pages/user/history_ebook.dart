import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/data/response/payments/res_history_ebook.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';

class HistoryEbook extends StatefulWidget {
  const HistoryEbook({super.key});

  @override
  State<HistoryEbook> createState() => _HistoryEbookState();
}

class _HistoryEbookState extends State<HistoryEbook> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderBook.initHistoryEbook(context);
      },
      child: Consumer<ProviderBook>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "${S.of(context).history} ${S.of(context).ebook}",
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: value.isGetHistoryEbook
                ? Column(
                    children: [
                      ShimmerLoadingWidget(
                          height: 50, width: MediaQuery.of(context).size.width),
                      const SizedBox(
                        height: 8,
                      ),
                      ShimmerLoadingWidget(
                          height: 50, width: MediaQuery.of(context).size.width),
                      const SizedBox(
                        height: 8,
                      ),
                      ShimmerLoadingWidget(
                          height: 50, width: MediaQuery.of(context).size.width)
                    ],
                  )
                : value.dataHistoryEbook.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "images/no_profiling.png",
                                width: 70,
                                height: 70,
                              ),
                            ),
                            Text(
                              S.of(context).no_data,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          DataHistoryEbook data = value.dataHistoryEbook[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            child: ListTile(
                              onTap: () {
                                value.getHistoryDetailEbook(
                                    context, data.id.toString());
                              },
                              title: Text(
                                data.createdAt.toString().substring(0, 10),
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${data.orderId}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              trailing: const Icon(Icons.book),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container();
                          // Divider(
                          //   thickness: 2,
                          //   color: greyColor.withOpacity(0.2),
                          // );
                        },
                        // separatorBuilder: (context, index) {
                        //   return Divider(
                        //     thickness: 2,
                        //     color: greyColor.withOpacity(0.2),
                        //   );
                        // },
                        itemCount: value.dataHistoryEbook.length),
          ),
        ),
      ),
    );
  }
}
