import 'dart:io';

import 'package:camera/camera.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/on_boarding/on_boarding_preview.dart';
import 'package:coolappflutter/presentation/on_boarding/onboarding_isi_email.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/takeimage_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FotoPage extends StatefulWidget {
  @override
  State<FotoPage> createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderUser>(builder: (context, providerUser, child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, Colors.white], // Gradasi biru ke putih
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50,right: 20,left: 20,bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/Selfi.png', // Ganti dengan path gambar kamu
                      ),
                    ),
                  ),
                  // SizedBox(height: 30,),
                  // providerUser.isProfileUser
                  //     ? Shimmer.fromColors(
                  //     baseColor: greyColor.withOpacity(0.2),
                  //     highlightColor: whiteColor,
                  //     child: Container(
                  //       width: MediaQuery.of(context)
                  //           .size
                  //           .width, // Lebar layar
                  //       // Tinggi 200
                  //       color:
                  //       greyColor, // Menggunakan warna greyColor sebagai placeholder
                  //     ))
                  //     : providerUser.image != null
                  //     ? SizedBox(
                  //   width: MediaQuery.of(context)
                  //       .size
                  //       .width, // Lebar layar
                  //   // Tinggi 200
                  //   child: Center(
                  //     child: Image.file(
                  //       File(providerUser.image!.path),
                  //       // Menjaga proporsi gambar
                  //     ),
                  //   ),
                  // )
                  //     : providerUser.dataUser?.image == null
                  //     ?
                  //     : SizedBox(
                  //   width: MediaQuery.of(context)
                  //       .size
                  //       .width, // Lebar layar
                  //   height: 270, // Tinggi 200
                  //   child: Center(
                  //     child: Image.network(
                  //         "${providerUser.dataUser?.image}",
                  //         fit: BoxFit
                  //             .cover, // Menjaga proporsi gambar
                  //         errorBuilder:
                  //             (BuildContext context,
                  //             Object exception,
                  //             StackTrace? stackTrace) {
                  //           // Tampilkan gambar placeholder jika terjadi error
                  //           return GestureDetector(
                  //             onTap: () async {
                  //               var res =
                  //               await takeImage(context);
                  //               if (res != null) {
                  //                 setState(() {
                  //                   providerUser.image = res;
                  //                 });
                  //                 await providerUser
                  //                     .updateProfileUser(
                  //                     context,
                  //                     providerUser.image!);
                  //               }
                  //             },
                  //             child: Image.asset(
                  //               'images/default_user.png', // Path ke gambar placeholder lokal
                  //               fit: BoxFit.cover,
                  //             ),
                  //           );
                  //         }),
                  //   ),
                  // ),
                   Text(
                    S.of(context).ayo_selfie,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  isLoading
                      ? GlobalButton(
                    onPressed: () async {},
                    color: greyColor,
                    text: S.of(context).next,
                    textStyle: TextStyle(color: Colors.white),
                    icon: Icon(Icons.camera_alt_rounded, color: Colors.white),
                  ) : GlobalButton(
                    onPressed: () async {
                      // Aktifkan loading
                      setState(() {
                        isLoading = true;
                      });

                      // Ambil gambar
                      XFile? res = await pickAndCompressImage(ImageSource.camera);


                      // Jika ada file, navigasi ke halaman berikutnya
                      if (res != null) {
                        setState(() {
                          isLoading = false;
                        });
                        Nav.toAll(OnBoardingPreview(res: res));
                      }
                    },
                    color: primaryColor,
                    text: S.of(context).next,
                    textStyle: TextStyle(color: Colors.white),
                    icon: Icon(Icons.camera_alt_rounded, color: Colors.white),
                  ),

                  gapH10,
                  isLoading
                      ? GlobalButton(
                    onPressed: () async {

                    },
                    color: Colors.grey,
                    text: S.of(context).pilihGambar,
                    textStyle: TextStyle(color: Colors.white),
                    icon: Icon(Icons.image, color: Colors.white),
                  ) : GlobalButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      XFile? res = await pickAndCompressImage(ImageSource.gallery);



                      if (res != null) {
                        setState(() {
                          isLoading = false;
                        });
                        Nav.toAll(OnBoardingPreview(res: res));
                      }
                    },
                    color: Colors.white,
                    text: S.of(context).pilihGambar,
                    textStyle: TextStyle(color: primaryColor),
                    icon: Icon(Icons.image, color: primaryColor),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
    });
  }
}
