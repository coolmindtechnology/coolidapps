import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:coolappflutter/generated/l10n.dart';

class DetailAnggotaPage extends StatefulWidget {
  final String idMember; // idMember wajib diterima saat halaman dibuat

  const DetailAnggotaPage({Key? key, required this.idMember}) : super(key: key);

  @override
  _DetailAnggotaPageState createState() => _DetailAnggotaPageState();
}

class _DetailAnggotaPageState extends State<DetailAnggotaPage> {
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ProviderAffiliate>(context, listen: false);

      setState(() {
        provider.isLoading = true;
      });

      await provider.getDetailMember(context, widget.idMember);

      setState(() {
        provider.isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CCBF4),
        elevation: 0,
        title: Text(S.of(context).member_details,
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, Colors.white], // Gradasi biru ke putih
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: Consumer<ProviderAffiliate>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.detailMember == null) {
              return const Center(child: Text('Data anggota tidak ditemukan.'));
            }

            final detail = provider.detailMember!;
            final activities = detail.data?.activityData ?? [];

            // Filter aktivitas berdasarkan searchQuery (case insensitive)
            final filteredActivities = activities.where((activity) {
              final name = activity.member?.name?.toLowerCase() ?? '';
              return name.contains(searchQuery.toLowerCase());
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 6)
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _getColorForType(
                                      detail.data?.resultName ??
                                          ""), // Warna garis tepi
                                  width: 4, // Lebar garis tepi
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: detail.data?.image != null
                                    ? NetworkImage(detail.data!.image!)
                                    : const AssetImage(
                                            'images/konsultasi/profile1.png')
                                        as ImageProvider,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detail.data?.name ?? 'Nama tidak tersedia',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  (detail.data?.resultName ?? '').isNotEmpty
                                      ? SizedBox(
                                        child: BrainTypeWidget(
                                          typeBrain:
                                              detail.data?.resultName ?? '',
                                        ),
                                      )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     // Column(
                        //     //   children: [
                        //     //     Text('${detail.data?.totalIncomePoint ?? 0}+',
                        //     //         style: const TextStyle(
                        //     //             fontSize: 18,
                        //     //             fontWeight: FontWeight.bold)),
                        //     //     Text(S.of(context).reward_point,
                        //     //         style: const TextStyle(fontSize: 12)),
                        //     //   ],
                        //     // ),
                        //     Column(
                        //       children: [
                        //         Text('${detail.data?.activity ?? 0}',
                        //             style: const TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.bold)),
                        //         Text(S.of(context).aktivitas,
                        //             style: const TextStyle(fontSize: 12)),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[200],
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.bar_chart,
                              color: Colors.white, size: 18),
                          label: Text(
                            '${detail.data?.activityInMonth.toString() ?? 0} ${S.of(context).aktivitas_bulan_ini}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- Search Bar ---
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //   child: TextField(
                //     onChanged: (value) {
                //       setState(() {
                //         searchQuery = value;
                //       });
                //     },
                //     decoration: InputDecoration(
                //       hintText: S.of(context).Search,
                //       prefixIcon: const Icon(Icons.search),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(8)),
                //       contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                //     ),
                //   ),
                // ),

                // --- List aktivitas ---
                Expanded(
                  child: filteredActivities.isEmpty
                      ? Center(child: Text('Tidak ada aktivitas ditemukan.'))
                      : ListView.builder(
                          itemCount: filteredActivities.length,
                          itemBuilder: (context, index) {
                            final activity = filteredActivities[index];
                            final point = activity.point ?? '0';
                            final name = activity.member?.name ?? '-';
                            final imageUrl = activity.member?.image;
                            final createdAt = activity.createdAt ?? '';

                            return Card(
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage: imageUrl != null
                                              ? NetworkImage(imageUrl)
                                              : const AssetImage(
                                                      'images/konsultasi/profile1.png')
                                                  as ImageProvider,
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '${S.of(context).profiling}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                              fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          formatTanggal(
                                              activity.createdAt.toString()),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(height: 24),
                                        Text(
                                          activity.status ?? '-',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: activity.status == 'success'
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
      ),
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

class BrainTypeWidget extends StatelessWidget {
  final String typeBrain;

  const BrainTypeWidget({super.key, required this.typeBrain});

  @override
  Widget build(BuildContext context) {
    // Jika typeBrain adalah "N/A", kembalikan widget kosong (tidak ditampilkan)
    if (typeBrain == "null") return SizedBox.shrink();

    // Map warna berdasarkan typeBrain
    final Map<String, Color> brainColors = {
      "Emotion In": Colors.green,
      "Emotion Out": Colors.green,
      "Emotion": Colors.green,
      "Action In": Colors.red,
      "Action Out": Colors.red,
      "Action": Colors.red,
      "Creative In": Colors.orange,
      "Creative Out": Colors.orange,
      "Creative": Colors.orange,
      "Master": Colors.black,
      "Logic In": Colors.yellow,
      "Logic Out": Colors.yellow,
      "Logic": Colors.yellow,
    };


    // Tentukan warna berdasarkan typeBrain, default hitam jika tidak ditemukan
    Color borderColor = brainColors[typeBrain] ?? Colors.white;
    Color textColor = borderColor;

    // Ubah format teks (replace "_" dengan spasi dan uppercase)
    String displayText = typeBrain.replaceAll("_", " ").toUpperCase();

    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor, // Warna border
          width: 2, // Lebar border
        ),
        borderRadius: BorderRadius.circular(10), // Radius border
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          displayText,
          style: TextStyle(
            color: _getColorForText(typeBrain),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

Color _getColorForText(String type) {
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
      return Colors.grey;// Warna default jika type tidak cocok
  }
}
