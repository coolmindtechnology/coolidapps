import 'package:coolappflutter/data/provider/provider_payment.dart';
import 'package:coolappflutter/data/response/payments/res_history_brain_activation.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/no_data_widget.dart';
import 'package:coolappflutter/presentation/widgets/shimmer_loading_widget_many.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';

class HistoryBrainActivation extends StatefulWidget {
  const HistoryBrainActivation({super.key});

  @override
  State<HistoryBrainActivation> createState() => _HistoryBrainActivationState();
}

class _HistoryBrainActivationState extends State<HistoryBrainActivation> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProviderPayment>().getHistoryBrainActivation(
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
            "${S.of(context).history} ${S.of(context).brain_activation}",
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: value.isLoadingHistoryBrainActivation
              ? const ShimmerLoadingWidgetMany(
                  itemBuilderHeight: 72,
                  separatorBuilderHeight: 8,
                  itemCount: 10)
              : value.dataHistoryBrainActivation.isEmpty
                  ? const NoDataWidget(
                      withParamsAdd: false,
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        DataHistoryBrainActivation data =
                            value.dataHistoryBrainActivation[index];
                        return ListTile(
                          onTap: () {
                            value.getInvoiceBrain(context, data.orderId ?? "");
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
                      itemCount: value.dataHistoryBrainActivation.length),
        ),
      ),
    );
  }
}
