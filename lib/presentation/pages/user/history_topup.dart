import 'package:cool_app/data/provider/provider_payment.dart';
import 'package:cool_app/data/response/payments/res_history_topup.dart';
import 'package:cool_app/presentation/pages/payments/invoice_screen.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';

class HistoryTopup extends StatefulWidget {
  const HistoryTopup({super.key});

  @override
  State<HistoryTopup> createState() => _HistoryTopupState();
}

class _HistoryTopupState extends State<HistoryTopup> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProviderPayment>().getHistoryTopup(
            context,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderPayment>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${S.of(context).history} ${S.of(context).top_up}",
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: value.isLoadingHistoryTopu
              ? Column(
                  children: [
                    ShimmerLoadingWidget(
                        height: 54, width: MediaQuery.of(context).size.width),
                    const SizedBox(
                      height: 8,
                    ),
                    ShimmerLoadingWidget(
                        height: 54, width: MediaQuery.of(context).size.width),
                    const SizedBox(
                      height: 8,
                    ),
                    ShimmerLoadingWidget(
                        height: 54, width: MediaQuery.of(context).size.width)
                  ],
                )
              : value.listDataHistoryTopup.isEmpty
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
                  : value.getFilteredHistory("Paid").isEmpty
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
                            DataHistoryTopup data =
                                value.getFilteredHistory("Paid")[index];
                            return ListTile(
                              onTap: () {
                                Nav.to(
                                    InvoiceScreen(isHistory: true, data: data));
                                value.getInvoice(context, data.orderId ?? "");
                              },
                              title: Text(
                                '${data.orderId}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 2,
                              color: greyColor.withOpacity(0.2),
                            );
                          },
                          itemCount: value.getFilteredHistory("Paid").length),
        ),
      ),
    );
  }
}
