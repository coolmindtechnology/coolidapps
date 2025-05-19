import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/member/deetail_anggota.dart';
import 'package:coolappflutter/presentation/pages/afiliate/member/detail_activity.dart';
import 'package:coolappflutter/presentation/pages/afiliate/member/semua_list_activity.dart';
import 'package:coolappflutter/presentation/pages/afiliate/member/semua_list_anggota.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/card_homekonsultant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AnggotaSayaPage extends StatefulWidget {
  @override
  _AnggotaSayaPageState createState() => _AnggotaSayaPageState();
}

class _AnggotaSayaPageState extends State<AnggotaSayaPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<ProviderAffiliate>(context, listen: false);
      provider.getListMember(context);
      provider.getListActivity(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    String formatTanggal(String dateString) {
      try {
        // Parse string ke DateTime
        DateTime dateTime = DateTime.parse(dateString);

        // Format ke 'dd MMMM yyyy', contoh: 13 Januari 2025
        return DateFormat('dd MMMM yyyy', 'id').format(dateTime);
      } catch (e) {
        return '-'; // Kalau gagal parse, tampilkan '-'
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          S.of(context).member,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Consumer<ProviderAffiliate>(
        builder: (context, provider, child) {
          if (provider.isListMember || provider.isListActivity) {
            return const Center(child: CircularProgressIndicator());
          }

          // Gunakan data dari provider.listMember dan provider.listActivity
          final listMember = provider.listMember?.data ?? [];
          final listActivity = provider.listActivity?.data ?? [];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 400,
                  height: 80,
                  child: CardHomeKonsultant(
                    title: S.of(context).Total_Members,
                    titleColor: Colors.white,
                    subtitleColor: Colors.white,
                    subtitle: "${listMember.length} ${S.of(context).Member}",
                    imageAsset: AppAsset.icMember,
                    containerColor: const Color(0xFF4CCBF4),
                  ),
                ),
              ),

              // Anggota Terbaru
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: sectionTitle(
                          context: context,
                          title: S.of(context).anggota_terbaru,
                          onTap: () => Nav.to(SemuaAnggotaPage()),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: listMember.length,
                          itemBuilder: (context, index) {
                            final member = listMember[index];
                            return InkWell(
                              onTap: () {
                                Nav.to(DetailAnggotaPage(idMember: member.id.toString(),));
                              },
                              child: Card(
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          gapH10,
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    member.image.toString()),
                                              ),
                                              gapW16,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    member.name ?? '-',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  gapH10,
                                                  Text(
                                                    S
                                                        .of(context)
                                                        .jadi_anggota_pada,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            member.tipeOtak ?? '-',
                                            style:  TextStyle(
                                                color: _getColorForType( member.tipeOtak ?? ''),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          gapH10,
                                          Text(
                                            formatTanggal(
                                                member.createdAt.toString() ??
                                                    '-'),
                                            style: TextStyle(fontSize: 12),
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
                  ),
                ),
              ),

              // Aktivitas Terbaru
              // Expanded(
              //   child: Container(
              //     color: Colors.white,
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 16, vertical: 8),
              //           child: sectionTitle(
              //             context: context,
              //             title: S.of(context).aktivitas_terbaru,
              //             onTap: () => Nav.to(AktivitiPage()),
              //           ),
              //         ),
              //         Expanded(
              //           child: ListView.builder(
              //             itemCount: listActivity.length,
              //             itemBuilder: (context, index) {
              //               final activity = listActivity[index];
              //               return InkWell(
              //
              //                 onTap: () {
              //                   Nav.to(DetailAktivitasPage(idActivity: activity.id.toString(),)); // Bisa dikembangkan passing data
              //                 },
              //                 child: Card(
              //                   color: Colors.white,
              //                   margin: const EdgeInsets.symmetric(
              //                       horizontal: 16, vertical: 6),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Column(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceEvenly,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             Text(
              //                               '+ ${(activity.affPoint?.fold<double>(
              //                                 0.0,
              //                                     (sum, item) =>
              //                                 sum + (double.tryParse(item.point.toString() ?? '0') ?? 0.0),
              //                               ) ?? 0.0).toStringAsFixed(2)} ${S.of(context).points}',
              //                               style: const TextStyle(
              //                                 color: Colors.green,
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 18,
              //                               ),
              //                             ),
              //                             gapH10,
              //                             Row(
              //                               children: [
              //                                 CircleAvatar(
              //                                   radius: 25,
              //                                   backgroundImage: NetworkImage(
              //                                       activity.image.toString()),
              //                                 ),
              //                                 gapW16,
              //                                 Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       activity.name ?? '-',
              //                                       style: const TextStyle(
              //                                           fontSize: 16,
              //                                           fontWeight:
              //                                               FontWeight.w600),
              //                                     ),
              //                                     gapH10,
              //                                     Text(
              //                                       S
              //                                           .of(context)
              //                                           .profiling_dibuat,
              //                                       style: const TextStyle(
              //                                           fontSize: 14,),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                           ],
              //                         ),
              //                         Column(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.end,
              //                           children: [
              //                             Text(
              //                               formatTanggal(activity.otpTime.toString() ?? '-'),
              //                               style: const TextStyle(fontSize: 12),
              //                             ),
              //                             gapH32,
              //                             Text(
              //                               '${activity?.profilingsCount?.toString() ?? '0'} X',
              //                               style: TextStyle(fontSize: 12),
              //                             )
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             },
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }

  Widget sectionTitle({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onTap,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            S.of(context).see_all,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
  Color _getColorForType(String type) {
    switch (type) {
      case 'Emotion In':
      case 'Emotion Out':
        return Colors.green;
      case 'Logic In':
      case 'Logic Out':
        return Colors.yellow;
      case 'Master':
        return Colors.black;
      case 'Creative In':
      case 'Creative Out':
        return Colors.orange;
      case 'Action In':
      case 'Action Out':
        return Colors.red;
      default:
        return Colors.grey; // Warna default jika type tidak cocok
    }
  }
}
