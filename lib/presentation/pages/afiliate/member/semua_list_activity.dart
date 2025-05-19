import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/member/detail_activity.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AktivitiPage extends StatefulWidget {
  @override
  _AktivitiPageState createState() => _AktivitiPageState();
}

class _AktivitiPageState extends State<AktivitiPage> {
  String searchQuery = '';

  String formatTanggal(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd MMMM yyyy', 'id').format(dateTime);
    } catch (e) {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CCBF4),
        elevation: 0,
        title: Text(S.of(context).aktivitas, style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<ProviderAffiliate>(
        builder: (context, provider, child) {
          if (provider.isListActivity) {
            return const Center(child: CircularProgressIndicator());
          }

          final allActivities = provider.listActivity?.data ?? [];

          // Filter aktivitas berdasarkan pencarian nama (case insensitive)
          final filteredActivities = allActivities.where((activity) {
            final name = activity.name?.toLowerCase() ?? '';
            return name.contains(searchQuery.toLowerCase());
          }).toList();

          return Column(
            children: [
              // Search bar dan filter icon
              Padding(
                padding: const EdgeInsets.all(12),
                child: Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: S.of(context).Search,
                      prefixIcon: Icon(Icons.search, color: primaryColor,),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),

              // Section title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).aktivitas,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              // List aktivitas
              Expanded(
                child: ListView.builder(
                  itemCount: filteredActivities.length,
                  itemBuilder: (context, index) {
                    final activity = filteredActivities[index];
                    final totalPoints = activity.affPoint?.fold<double>(
                      0.0,
                          (sum, item) =>
                      sum + (double.tryParse(item.point?.toString() ?? '0') ?? 0.0),
                    ) ?? 0.0;


                    return InkWell(
                      onTap: () {
                        Nav.to(DetailAktivitasPage(idActivity: activity.id.toString(),)); // Bisa dikembangkan passing data
                      },
                      child: Card(
                        color: Colors.white,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Kiri: poin, avatar, nama, aktivitas
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '+ ${totalPoints.toStringAsFixed(2)} ${S.of(context).points}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            activity.image.toString()),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            activity.name ?? '-',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            S.of(context).profiling_dibuat,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Kanan: tanggal dan jumlah profiling
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    formatTanggal(activity.otpTime?.toString() ?? '-'),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                    '${activity.profilingsCount?.toString() ?? '0'} X',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
