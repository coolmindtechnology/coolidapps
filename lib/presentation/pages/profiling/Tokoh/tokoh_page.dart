import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/response/profiling/res_detail_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';

class TokohPage extends StatefulWidget {
  final void Function()? onLanguageChanged;
  final List<PublicFigure> publicFigures;

  const TokohPage({super.key, required this.publicFigures,this.onLanguageChanged});

  @override
  State<TokohPage> createState() => _TokohPageState();
}

class _TokohPageState extends State<TokohPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  int? _selectedIndex; // Index yang sedang diperluas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).figures_with_same_brain_type,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 20,left: 20,top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).figures_with_same_personality,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            gapH8,
            Text(S.of(context).great_figures_with_same_brain_type),
            gapH32,
            Expanded(
              child: ListView.builder(
                itemCount: widget.publicFigures.length,
                itemBuilder: (context, index) {
                  PublicFigure tokoh = widget.publicFigures[index];
                  bool isExpanded = _selectedIndex == index;

                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        ListTile(
                          leading: isExpanded
                              ? null // Hilangkan foto kecil jika detail terbuka
                              : CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage("${tokoh.image}"),
                            backgroundColor: Colors.grey[300], // Placeholder jika gambar gagal
                          ),
                          title: Text(tokoh.name ?? "Tanpa Nama",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          // trailing: Icon(
                          //   isExpanded ? CupertinoIcons.chevron_down : CupertinoIcons.forward,
                          //   color: Colors.grey,
                          // ),
                          // onTap: () {
                          //   setState(() {
                          //     _selectedIndex = isExpanded ? null : index;
                          //   });
                          // },
                        ),
                        // if (isExpanded) // Detail muncul hanya jika item diklik
                        //   Padding(
                        //     padding: const EdgeInsets.all(16),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         // Gambar Besar
                        //         ClipRRect(
                        //           borderRadius: BorderRadius.circular(12),
                        //           child: Image.network(
                        //             tokoh.image ?? '',
                        //             width: double.infinity,
                        //             height: 200,
                        //             fit: BoxFit.cover,
                        //             errorBuilder: (context, error, stackTrace) =>
                        //                 Container(
                        //                   width: double.infinity,
                        //                   height: 200,
                        //                   color: Colors.grey[300], // Placeholder jika gambar gagal dimuat
                        //                   child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                        //                 ),
                        //           ),
                        //         ),
                        //         SizedBox(height: 12),
                        //         if (tokoh.description != null)
                        //           Text(S.of(context).biodata,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                        //           gapH10,
                        //           Text("${tokoh.description}",
                        //               style: TextStyle(fontSize: 14)),
                        //         gapH20,
                        //         if (tokoh.career != null)
                        //           Text(S.of(context).career,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                        //         gapH10,
                        //           Text("${tokoh.career}",
                        //               style: TextStyle(fontSize: 14)),
                        //         SizedBox(height: 10),
                        //       ],
                        //     ),
                        //   ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



