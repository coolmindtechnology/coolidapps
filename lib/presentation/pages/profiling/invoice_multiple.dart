import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/models/data_checkout_transaction.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling_false.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InboisPage extends StatefulWidget {
  const InboisPage({super.key,required this.data,});
  final ProfilingData data;

  @override
  State<InboisPage> createState() => _InboisPageState();
}

class _InboisPageState extends State<InboisPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<ProviderProfiling>(context, listen: false);
      provider.getPriceProfiling(context,widget.data.result.length.toString()); // ← ganti “1” dengan qty yang sesuai
    });
  }

  @override
  Widget build(BuildContext context) {
    String formatTanggal(String rawDate) {
      try {
        final dt = DateTime.parse(rawDate);
        return DateFormat('dd/MM/yyyy').format(dt);
      } catch (_) {
        return rawDate;
      }
    }
    return Consumer<ProviderProfiling>(builder: (context, value, child) {
      String _getFormattedPrice() {
        if (value.priceProfiling?.data == null) return '';
        return 'Rp ${NumberFormat("#,##0", "id_ID").format(value.priceProfiling!.data)}';
      }
      bool isLoading = value.isCreateMultipleProfiling || value.isPayProfiling || value.isCreatePayment;
      return Scaffold(
      appBar: AppBar(
        title:  Text(S.of(context).invoice,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
             S.of(context).lakukan_pembayaran_pertanyaan,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text:S.of(context).peringatan_penghapusan_profiling),
                  TextSpan(
                    text: " ${widget.data.time} ",
                    style: TextStyle(color: Colors.red),
                  ),
                  TextSpan(text:   S.of(context).peringatan_pembayaran_belum_dilakukan),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // infoRow(S.of(context).id, widget.data.idMultiple.toString()),
            infoRow(S.of(context).customer, dataGlobal.dataUser?.name.toString() ?? ""),
            infoRow(S.of(context).date, widget.data.createdAt.toString()),
            const SizedBox(height: 16),
            paymentBox(widget.data.totalProfiling.toString(),"0"),
            const SizedBox(height: 20),
             Text(
               S.of(context).profiling_dibuat,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.data.result.length,
              itemBuilder: (context, index) {
                final item = widget.data.result[index];
                return profileCard(
                  item.profilingName,
                  formatTanggal(item.createdAt),
                );
              },
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: isLoading
                  ? const CircularProgressWidget()
                  :  ElevatedButton(
                onPressed: () async {
                  List<int> idLogs = widget.data.result.map((e) => int.parse(e.idLogResult)).toList();
                  int qty = widget.data.totalProfiling;
                  await NotificationUtils
                      .showSimpleDialog2(
                      context,
                      S
                          .of(context)
                          .pay_with_your_cool_balance,
                      textButton1: S
                          .of(context)
                          .yes_continue,
                      textButton2:
                      S.of(context).other_pay,
                      onPress2: () async {
                        Nav.back();
                        await value.payProfiling(
                            context,
                            idLogs,
                            "0",
                            "transaction_type",
                            qty, onUpdate: () async {
                          await value
                              .getListProfiling(context);
                        }, fromPage: "profiling");
                      }, onPress1: () async {
                    Nav.back();
                    await value
                        .createTransactionProfiling(
                        context,
                        DataCheckoutTransaction(
                            idLogs: idLogs,
                            discount: "0",
                            idItemPayments: "1",
                            qty: qty,
                            gateway: "paypal"),
                            () async {
                          await value
                              .getListProfiling(context);
                        });
                  },
                      colorButon1: primaryColor,
                      colorButton2: Colors.white);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:  Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text(
                    S.of(context).lakukan_pembayaran,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          gapW10,
          Text(value),
        ],
      ),
    );
  }

  Widget paymentBox(String banyak, String diskon) {
    return Consumer<ProviderProfiling>(builder: (context, value, child) {
      String _getFormattedPrice() {
        if (value.priceProfiling?.data == null) return '';
        return 'Rp ${NumberFormat("#,##0", "id_ID").format(value.priceProfiling!.data)}';
      }
      bool isLoading = value.isCreateMultipleProfiling || value.isPayProfiling || value.isCreatePayment;
      return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:  Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).Status, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(S.of(context).pending),
          SizedBox(height: 12),
          Text(S.of(context).items, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('${S.of(context).profiling} ${banyak}x'),
          SizedBox(height: 12),
          // Text('Diskon', style: TextStyle(fontWeight: FontWeight.bold)),
          // Text(diskon),
          Divider(thickness: 1),
          Align(
            alignment: Alignment.centerRight,
            child: value.isLoadingPriceProfiling ? CircularProgressIndicator() : Text(
              value.priceProfiling?.data != null
                  ? 'Rp ${NumberFormat("#,##0", "id_ID").format(value.priceProfiling!.data)}'
                  : '',
            )
          ),
        ],
      ),
    );
  });
  }

  Widget profileCard(String name, String date) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: primaryColor)
      ),
      color: lightBlue,
      child: ListTile(
        title: Text(name),
        trailing: Text(date),
      ),
    );
  }
}
