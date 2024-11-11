// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/utils/takeimage_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final _formKey = GlobalKey<FormState>();
  bool isImageSelected = false;
  @override
  void initState() {
    super.initState();
    Provider.of<ProviderUser>(context, listen: false).setInitialValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderUser>(builder: (context, providerUser, child) {
      return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              S.of(context).profile,
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        providerUser.isProfileUser
                            ? Shimmer.fromColors(
                                baseColor: greyColor.withOpacity(0.2),
                                highlightColor: whiteColor,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: greyColor, shape: BoxShape.circle),
                                ))
                            : providerUser.image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.file(
                                          File(providerUser.image!.path),
                                          fit: BoxFit.cover,
                                        )),
                                  )
                                : providerUser.dataUser?.image == null
                                    ? Image.asset(
                                        "images/default_user.png",
                                        height: 100,
                                        width: 100,
                                        color: greyColor,
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                            "${providerUser.dataUser?.image}",
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover, errorBuilder:
                                                (BuildContext context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                          // Tampilkan gambar placeholder jika terjadi error
                                          return GestureDetector(
                                            onTap: () async {
                                              var res =
                                                  await takeImage(context);
                                              if (res != null) {
                                                setState(() {
                                                  providerUser.image = res;
                                                });
                                                await providerUser
                                                    .updateProfileUser(context,
                                                        providerUser.image!);
                                              }
                                            },
                                            child: Image.asset(
                                              'images/default_user.png', // Path ke gambar placeholder lokal
                                              width: 56,
                                              height: 56,
                                              fit: BoxFit.fill,
                                            ),
                                          );
                                        }),
                                      ),
                        Positioned(
                          top: 30,
                          left: 75,
                          child: GestureDetector(
                            onTap: () async {
                              var res = await takeImage(context);
                              if (res != null) {
                                setState(() {
                                  providerUser.image = res;
                                });
                                await providerUser.updateProfileUser(
                                    context, providerUser.image!);
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: greenColor,
                              radius: 20,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S.of(context).name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: providerUser.nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return S.of(context).cannot_be_empty;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S.of(context).phone_number,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    IntlPhoneField(
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(fontFamily: "Poppins"),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      initialCountryCode: providerUser.initialCodeCountry,
                      initialValue: providerUser.phoneNumberWithoutCode,
                      style: const TextStyle(fontFamily: "Poppins"),
                      dropdownTextStyle: const TextStyle(fontFamily: "Poppins"),
                      onChanged: (phone) {
                        providerUser.phoneController.text =
                            phone.completeNumber.replaceAll("+", "");
                      },
                      disableLengthCheck: true,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S.of(context).email,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      enabled: false,
                      controller: providerUser.emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return S.of(context).cannot_be_empty;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S.of(context).id_number,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: providerUser.idCardController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      // validator: (validator) {
                      //   if (validator!.isEmpty) {
                      //     return S.of(context).cannot_be_empty;
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S.of(context).address,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: providerUser.addressController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.streetAddress,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return S.of(context).cannot_be_empty;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (providerUser.isLoadingUpdateUser) ...[
                      CircularProgressWidget(
                        color: primaryColor,
                      )
                    ] else ...[
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: primaryColor,
                        textColor: Colors.white,
                        height: 54,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          setState(() {});
                          // handleAction(context);
                          if (_formKey.currentState?.validate() ?? false) {
                            if (providerUser.dataUser?.image == null &&
                                providerUser.image == null) {
                              NotificationUtils.showSnackbar(
                                  S.of(context).please_upload_profile_picture,
                                  backgroundColor: Colors.red);
                            } else {
                              await providerUser.updateUser(context);
                            }
                          }
                        },
                        child: Text(S.of(context).save),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ));
    });
  }

  handleAction(context) async {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(S.of(context).process), // Display loading text
            ],
          ),
        );
      },
    );

    // Timer(const Duration(seconds: 3), () {
    //   Navigator.pop(context);
    // });
    // Handle further actions after loading is complete
  }
}
