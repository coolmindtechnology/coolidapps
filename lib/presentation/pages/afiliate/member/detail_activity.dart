import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DetailAktivitasPage extends StatefulWidget {
  final String idActivity;

  const DetailAktivitasPage({super.key, required this.idActivity});

  @override
  State<DetailAktivitasPage> createState() => _DetailAktivitasPageState();
}

class _DetailAktivitasPageState extends State<DetailAktivitasPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProviderAffiliate>(context, listen: false)
          .getDetailActivity(context, widget.idActivity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).detail_aktivitas,style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF4CCBF4),
        elevation: 0,
      ),
      body: Consumer<ProviderAffiliate>(
        builder: (context, provider, _) {
          if (provider.isDetailActivity) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = provider.detailActivity?.data;
          if (data == null) {
            return const Center(child: Text('Tidak ada data.'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LOGO
                Center(
                  child: Image.asset(
                    'images/newcoollogos.png',
                    width: 300,
                  ),
                ),
                const SizedBox(height: 32),

                // DETAIL INFO
                Text(S.of(context).detail_aktivitas,
                    style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _detailItem(S.of(context).aktivitas, data.activityName ?? '-'),
                _detailItem(S.of(context).profiling, data.profilingName ?? '-'),
                _detailItem(S.of(context).Price, 'Rp ${data.price ?? '0'}'),
                _detailItem(S.of(context).reward_point,
                    '${data.point ?? 0} ${S.of(context).points}'),

                const SizedBox(height: 24),

                // GARIS + TOTAL
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).reward_total,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${data.point ?? 0} ${S.of(context).points}',
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 2,
                  color: Colors.teal,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child:
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          const Spacer(),
          Expanded(child: Text(value, maxLines: 1)),
        ],
      ),
    );
  }
}
