import 'package:cool_app/data/provider/provider_payment.dart';
import 'package:cool_app/data/response/payments/res_history_topup.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';

class HistoryMerchandisePayement extends StatefulWidget {
  const HistoryMerchandisePayement({super.key});

  @override
  State<HistoryMerchandisePayement> createState() =>
      _HistoryMerchandisePayementState();
}

class _HistoryMerchandisePayementState
    extends State<HistoryMerchandisePayement> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderPayment();
      },
      child: Consumer<ProviderPayment>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "History Merchandise Payment",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: value.isLoadingHistoryTopu
                ? CircularProgressWidget(
                    color: primaryColor,
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
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          DataHistoryTopup data =
                              value.listDataHistoryTopup[index];
                          return ListTile(
                            onTap: () {
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
                        itemCount: value.listDataHistoryTopup.length),
          ),
        ),
      ),
    );
  }
}
