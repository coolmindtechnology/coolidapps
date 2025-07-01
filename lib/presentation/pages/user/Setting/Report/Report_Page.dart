import 'dart:io';

import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Report/Pop_Up.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Report/log_report.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../main/home_screen.dart';


class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String? selectedItem;
  bool isExpanded = false;
  File? selectedImage;

  // Controller untuk TextField (body laporan)
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ambil data kategori dari API saat halaman dibuka
    Future.microtask(() {
      context.read<ProviderUser>().getCategroyBug(context);
      context.read<ProviderUser>().getLogReport(context);
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Ikon tombol kembali
          onPressed: () {
            Nav.toAll(
                NavMenuScreen()); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: Consumer<ProviderUser>(  // Letakkan Consumer di sini
        builder: (context, provider, child) {
          bool isloading = provider.isLoading || provider.isLoadingLogReport == true;
          return Padding(
            padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
            child: isloading
                ? Column(
              children: [
                gapH32,
                shimmerButton(),
                gapH20,
                shimmerButton(),
                gapH32,
                shimmerButton(),
                gapH10,
                shimmerContainer(height: 250, width: double.infinity),
                gapH20,
              ],
            )
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (provider.logReportData?.data?.isNotEmpty ?? false)
                        InkWell(
                    onTap: () {
                    Nav.to(LogLaporanPage());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                  
                      decoration: BoxDecoration(
                        color: Color(0xFFF19773),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xFF960D11),
                        ),
                      ),
                      child: Center(
                        child: Text(S.of(context).logPermasalahanAnda,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                      ),
                    ),
                  ),
                      if (provider.logReportData?.data?.isNotEmpty ?? false)
                        gapH32,
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
                    Builder(
                      builder: (context) {
                        final categories = provider.categoryData!.data!;
                        // Set selectedItem ke kategori pertama jika belum ada
                        if (selectedItem == null && categories.isNotEmpty) {
                          Future.microtask(() {
                            setState(() {
                              selectedItem = categories.first.name;
                            });
                          });
                        }

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedItem,
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
                              items: categories
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
                        );
                      },
                    ),
                                  const SizedBox(height: 20),
                  Text(S.of(context).Supporting_Documents,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  gapH10,
                  GestureDetector(
                    onTap: _pickImage, // Panggil fungsi untuk memilih gambar
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image.asset(AppAsset.icImages),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              selectedImage != null
                                  ? selectedImage!.path.split('/').last  // Tampilkan nama file
                                  : S.of(context).pilihGambar,
                              style: TextStyle(color: selectedImage != null ? Colors.black : Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  
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
                  const SizedBox(height: 80,),
                  
                  // Tombol kirim
                                 provider.isLoadingReportBug ? Container(
                     width: double.infinity,
                     decoration: BoxDecoration(
                         color: primaryColor,
                       borderRadius: BorderRadius.circular(10)
                     ),
                     height: 50,
                     child: const Center(child: CircularProgressIndicator(color: Colors.white,))) : GlobalButton(
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
                            body: bodyController.text,
                            media: selectedImage, // Kirim body laporan
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
                          print('Error: ${e.toString()}');
                          print('Error: $selectedItem');
                        }
                      } else {
                        // Jika kategori atau body kosong, tampilkan snack bar
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text(S.of(context).pilihKategoriDanDeskripsi)),
                        );
                      }
                    },
                    color: primaryColor,
                    text: S.of(context).Send,
                  ),
                  
                                ],
                              ),
                ),
          );
        },
      ),
    );
  }
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Ambil dari Kamera"),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      selectedImage = File(image.path);
                      // Extract the file name and format (extension)
                      String fileName = image.path.split('/').last;
                      String fileExtension = fileName.split('.').last;
                      String displayName = "$fileName ($fileExtension)";
                      print(displayName); // You can display this name in the UI
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Pilih dari Galeri"),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      selectedImage = File(image.path);
                      // Extract the file name and format (extension)
                      String fileName = image.path.split('/').last;
                      String fileExtension = fileName.split('.').last;
                      String displayName = "$fileName ($fileExtension)";
                      print(displayName); // You can display this name in the UI
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

}


