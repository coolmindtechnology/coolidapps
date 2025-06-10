import 'dart:io';

import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/presentation/on_boarding/on_boarding_isi_foto.dart';
import 'package:coolappflutter/presentation/pages/main/components/input_code_ref_profilling.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/utils/takeimage_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class OnBoardingPreview extends StatefulWidget {
  final XFile? res;
  const OnBoardingPreview({super.key,  this.res});

  @override
  State<OnBoardingPreview> createState() => _OnBoardingPreviewState();
}

class _OnBoardingPreviewState extends State<OnBoardingPreview> {
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
                padding: const EdgeInsets.only(top: 50,right: 10,left: 10,bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gapH40,
                     Text(
                      S.of(context).preview,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapH40,
                    widget.res == null
                        ? Image.asset(
                      "images/default_user.png",
                      width: MediaQuery.of(context).size.width,
                      height: 270,
                      fit: BoxFit.cover,
                    )
                        : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 270,
                      child: Center(
                        child: Image.file(
                          File(widget.res!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Spacer(),
                    providerUser.isProfileUser ? Center(child: CircularProgressIndicator(color: primaryColor,)) : GlobalButton(
                      onPressed: () async {
                        if (widget.res != null) {
                          providerUser.image = widget.res;
                          await providerUser.updateProfileUser(context, providerUser.image!, route: 'register');
                        }
                      },
                      color: primaryColor,
                      text: S.of(context).next,
                    ),


                    gapH10,
                    providerUser.isProfileUser ? Center(child: CircularProgressIndicator(color: primaryColor,)) : GlobalButton(
                      onPressed: () async {
                        Nav.toAll(FotoPage());
                      },
                      color: Colors.white,
                      text: S.of(context).ganti_foto,
                      textStyle: TextStyle(color: primaryColor),
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
