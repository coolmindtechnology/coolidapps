import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/response/profiling/res_detail_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_hasil_kepribadian_dibawah17.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';

class TokohPage extends StatefulWidget {
  final void Function()? onLanguageChanged;
  final List<PublicFigure> publicFigures;
  final bool isUnder17; // Tambahan boolean cek usia

  const TokohPage({
    super.key,
    required this.publicFigures,
    this.onLanguageChanged,
    required this.isUnder17, // Wajib diisi saat memanggil halaman ini
  });
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
      body: Container(
        color:  widget.isUnder17
            ? Color(0xFF93F1FB) : Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isUnder17
                  ? SizedBox()
                  : Text(
                      S.of(context).figures_with_same_personality,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
              gapH8,
              widget.isUnder17
                  ? CostumeContainer(
                      titleColor: Colors.white,
                      containerColor: primaryColor,
                      title: 'Tokoh dengan profil anda!',
                    )
                  : Text(S.of(context).great_figures_with_same_brain_type),
              gapH32,
              Expanded(
                child: ListView.builder(
                  itemCount: widget.publicFigures.length,
                  itemBuilder: (context, index) {
                    PublicFigure tokoh = widget.publicFigures[index];
                    bool isExpanded = _selectedIndex == index;

                    return Card(
                      color:  widget.isUnder17
                          ? primaryColor : Colors.white,
                      margin: EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          ListTile(
                            leading: isExpanded
                                ? null // Hilangkan foto kecil jika detail terbuka
                                : CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage("${tokoh.image}"),
                                    backgroundColor: Colors.grey[
                                        300], // Placeholder jika gambar gagal
                                  ),
                            title: Text(tokoh.name ?? "Tanpa Nama",
                                style: TextStyle(fontWeight: FontWeight.bold,color: widget.isUnder17 ? Colors.white : blackColor)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const CustomFAB(),
    );
  }
}
