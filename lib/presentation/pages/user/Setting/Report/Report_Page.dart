import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Report/Pop_Up.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String? selectedItem;
  bool isExpanded = false;

  // Controller untuk TextField (body laporan)
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ambil data kategori dari API saat halaman dibuka
    Future.microtask(() {
      context.read<ProviderUser>().getCategroyBug(context);
    });
  }

  @override
  void dispose() {
    // Jangan lupa untuk dispose controller
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).Report_Issue,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: Consumer<ProviderUser>(  // Letakkan Consumer di sini
        builder: (context, provider, child) {
          return Padding(
            padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).What_Problem,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                // Menampilkan dropdown dengan data dari API
                if (provider.isLoadingCategory)
                  const Center(child: CircularProgressIndicator())
                else if (provider.categoryData?.data?.isEmpty ?? true)
                  const Text("Kategori tidak tersedia")
                else
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedItem ?? provider.categoryData!.data!.first.name,
                        isExpanded: true,
                        icon: Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                        onChanged: (value) {
                          setState(() {
                            selectedItem = value;
                          });
                        },
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        items: provider.categoryData!.data!
                            .map((category) => DropdownMenuItem<String>(
                          value: category.name,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(category.name ?? "Unknown"),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                  ),

                const SizedBox(height: 30),

                Text(
                  S.of(context).Tell_Us,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: bodyController, // Set controller untuk TextFormField
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: S.of(context).Tell_Us_Here,
                  ),
                ),
                const Spacer(),

                // Tombol kirim
                GlobalButton(
                  onPressed: () async {
                    // Pastikan kategori dan body sudah diisi
                    if (selectedItem != null && bodyController.text.isNotEmpty) {
                      // Ambil ID kategori berdasarkan nama kategori yang dipilih dan simpan dalam array int
                      List<int> selectedCategoryIds = provider.categoryData!.data!
                          .where((category) => category.name == selectedItem)
                          .map((category) {
                        return int.tryParse(category.id?.toString() ?? '') ?? 0;
                      }).toList();

                      try {
                        // Panggil fungsi reportBug dan tunggu hingga selesai
                        await context.read<ProviderUser>().reportBug(
                          categories: selectedCategoryIds,  // Kirim kategori dalam bentuk array of int
                          body: bodyController.text,  // Kirim body laporan
                        );

                        // Menampilkan dialog setelah berhasil
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const PopUpReport(),
                            );
                          },
                        );
                      } catch (e) {
                        // Menangani kesalahan jika ada
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }
                    } else {
                      // Jika kategori atau body kosong, tampilkan snack bar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Harap pilih kategori dan masukkan deskripsi')),
                      );
                    }
                  },
                  color: primaryColor,
                  text: S.of(context).Send,
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}

