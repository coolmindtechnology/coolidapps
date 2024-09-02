import 'package:cool_app/data/provider/provider_profiling.dart';
import 'package:cool_app/data/response/profiling/res_list_profiling.dart';
import 'package:cool_app/presentation/pages/profiling/screen_hasil_kepribadian.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';

class ScreenHistory extends StatefulWidget {
  const ScreenHistory({super.key});

  @override
  State<ScreenHistory> createState() => _ScreenHistoryState();
}

class _ScreenHistoryState extends State<ScreenHistory> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderProfiling.getHistory(context);
      },
      child: Consumer<ProviderProfiling>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              S.of(context).history,
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: value.isHistoryProfiling
                ? Column(
                    children: [
                      ShimmerLoadingWidget(
                          height: 98, width: MediaQuery.of(context).size.width),
                      const SizedBox(
                        height: 8,
                      ),
                      ShimmerLoadingWidget(
                          height: 98, width: MediaQuery.of(context).size.width),
                      const SizedBox(
                        height: 8,
                      ),
                      ShimmerLoadingWidget(
                          height: 98, width: MediaQuery.of(context).size.width)
                    ],
                  )
                : value.listHistory.isEmpty
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
                        itemBuilder: (context, index) {
                          DataProfiling data = value.listHistory[index];
                          return ListTile(
                            onTap: () {
                              Nav.to(ScreenHasilKepribadian(data: data));
                            },
                            title: Text(
                              '${data.profilingName}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              "${data.character}",
                              style: TextStyle(fontSize: 12, color: greyColor),
                            ),
                            trailing: Text(
                              "${data.date}",
                              style: TextStyle(fontSize: 12, color: greyColor),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 2,
                            color: greyColor.withOpacity(0.2),
                          );
                        },
                        itemCount: value.listHistory.length),
          ),
        ),
      ),
    );
  }
}
