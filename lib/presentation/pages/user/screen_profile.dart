// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';
// import 'dart:io';

// import 'package:coolappflutter/data/provider/provider_user.dart';
// import 'package:coolappflutter/generated/l10n.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
// import 'package:coolappflutter/presentation/utils/notification_utils.dart';
// import 'package:coolappflutter/presentation/utils/takeimage_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';

// import '../auth/component/country_state_city_provider.dart';

// class ScreenProfile extends StatefulWidget {
//   const ScreenProfile({super.key, required this.phone});
//   final dynamic phone;

//   @override
//   State<ScreenProfile> createState() => _ScreenProfileState();
// }

// class _ScreenProfileState extends State<ScreenProfile> {
//   final _formKey = GlobalKey<FormState>();
//   bool isImageSelected = false;

//   @override
//   void initState() {
//     super.initState();

//     Provider.of<ProviderUser>(context, listen: false).getAddress(context);

//     Provider.of<CountryStateCityProvider>(context, listen: false)
//         .fetchCountries(0);
//     Provider.of<ProviderUser>(context, listen: false)
//         .setPhoneNumber(widget.phone.toString());
//     Timer(Duration(seconds: 2), () {
//       Provider.of<ProviderUser>(context, listen: false).getLocalePhonenumber();
//       Provider.of<ProviderUser>(context, listen: false)
//           .setInitialValues(widget.phone.toString());

//       // provider.setSelectedCountryId(int.parse(
//       //     Provider.of<ProviderUser>(context, listen: false)
//       //         .countryController
//       //         .text));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<CountryStateCityProvider>(context);
//     return Consumer<ProviderUser>(builder: (context, providerUser, child) {
//       return Scaffold(
//           // resizeToAvoidBottomInset: false,
//           appBar: AppBar(
//             centerTitle: true,
//             title: Text(
//               S.of(context).profile,
//               style: const TextStyle(color: Colors.white),
//             ),
//             iconTheme: const IconThemeData(color: Colors.white),
//             backgroundColor: primaryColor,
//           ),
//           body: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         providerUser.isProfileUser
//                             ? Shimmer.fromColors(
//                                 baseColor: greyColor.withOpacity(0.2),
//                                 highlightColor: whiteColor,
//                                 child: Container(
//                                   width: 100,
//                                   height: 100,
//                                   decoration: BoxDecoration(
//                                       color: greyColor, shape: BoxShape.circle),
//                                 ))
//                             : providerUser.image != null
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(100),
//                                     child: SizedBox(
//                                         width: 100,
//                                         height: 100,
//                                         child: Image.file(
//                                           File(providerUser.image!.path),
//                                           fit: BoxFit.cover,
//                                         )),
//                                   )
//                                 : providerUser.dataUser?.image == null
//                                     ? Image.asset(
//                                         "images/default_user.png",
//                                         height: 100,
//                                         width: 100,
//                                         color: greyColor,
//                                       )
//                                     : ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                         child: Image.network(
//                                             "${providerUser.dataUser?.image}",
//                                             height: 100,
//                                             width: 100,
//                                             fit: BoxFit.cover, errorBuilder:
//                                                 (BuildContext context,
//                                                     Object exception,
//                                                     StackTrace? stackTrace) {
//                                           // Tampilkan gambar placeholder jika terjadi error
//                                           return GestureDetector(
//                                             onTap: () async {
//                                               var res =
//                                                   await takeImage(context);
//                                               if (res != null) {
//                                                 setState(() {
//                                                   providerUser.image = res;
//                                                 });
//                                                 await providerUser
//                                                     .updateProfileUser(context,
//                                                         providerUser.image!);
//                                               }
//                                             },
//                                             child: Image.asset(
//                                               'images/default_user.png', // Path ke gambar placeholder lokal
//                                               width: 56,
//                                               height: 56,
//                                               fit: BoxFit.fill,
//                                             ),
//                                           );
//                                         }),
//                                       ),
//                         Positioned(
//                           top: 30,
//                           left: 75,
//                           child: GestureDetector(
//                             onTap: () async {
//                               var res = await takeImage(context);
//                               if (res != null) {
//                                 setState(() {
//                                   providerUser.image = res;
//                                 });
//                                 await providerUser.updateProfileUser(
//                                     context, providerUser.image!);
//                               }
//                             },
//                             child: CircleAvatar(
//                               backgroundColor: greenColor,
//                               radius: 20,
//                               child: const Icon(
//                                 Icons.camera_alt,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Text(
//                       S.of(context).name,
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     TextFormField(
//                       controller: providerUser.nameController,
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.name,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: Colors.white, width: 1),
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       validator: (validator) {
//                         if (validator!.isEmpty) {
//                           return S.of(context).cannot_be_empty;
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Text(
//                       S.of(context).phone_number,
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     IntlPhoneField(
//                       readOnly: true,
//                       enabled: false,
//                       // controller: providerUser.phoneController,
//                       decoration: InputDecoration(
//                         labelStyle: const TextStyle(fontFamily: "Poppins"),
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: Colors.white, width: 1),
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       initialCountryCode: providerUser.initialCodeCountry,
//                       initialValue: providerUser.phoneNumberWithoutCode,
//                       style: const TextStyle(fontFamily: "Poppins"),
//                       dropdownTextStyle: const TextStyle(fontFamily: "Poppins"),
//                       onChanged: (phone) {
//                         providerUser.phoneController.text =
//                             phone.completeNumber.replaceAll("+", "");
//                       },
//                       disableLengthCheck: true,
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Text(
//                       S.of(context).email,
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     TextFormField(
//                       enabled: false,
//                       controller: providerUser.emailController,
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: Colors.white, width: 1),
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       validator: (validator) {
//                         if (validator!.isEmpty) {
//                           return S.of(context).cannot_be_empty;
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Text(
//                       S.of(context).id_number,
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     TextFormField(
//                       controller: providerUser.idCardController,
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: Colors.white, width: 1),
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       // validator: (validator) {
//                       //   if (validator!.isEmpty) {
//                       //     return S.of(context).cannot_be_empty;
//                       //   }
//                       //   return null;
//                       // },
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Text(
//                       S.of(context).address,
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     TextFormField(
//                       controller: providerUser.addressController,
//                       textInputAction: TextInputAction.done,
//                       keyboardType: TextInputType.streetAddress,
//                       maxLines: 3,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: Colors.white, width: 1),
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       validator: (validator) {
//                         if (validator!.isEmpty) {
//                           return S.of(context).cannot_be_empty;
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     // Text(
//                     //   S.of(context).country,
//                     //   style: const TextStyle(fontSize: 14),
//                     // ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     DropdownButtonFormField<int>(
//                       hint: Text(providerUser.countryController.text,
//                           style: const TextStyle(color: Colors.grey)),
//                       value: provider.selectedCountryId,
//                       items: provider.countries
//                           .map<DropdownMenuItem<int>>((country) {
//                         return DropdownMenuItem<int>(
//                           value: country['id'],
//                           child: Text(
//                             country['name'],
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         if (value != null) {
//                           providerUser.setSelectedCountryId(value);
//                           provider.setSelectedCountryId(value);
//                           provider
//                               .setSelectedCountryId(providerUser.countryssId);
//                           providerUser.countryssId =
//                               provider.selectedCountryId!;
//                           provider.fetchCountries(value);
//                           provider.fetchStates(value);
//                           provider.selectedStateId = null;
//                         }
//                       },
//                       icon: const Icon(Icons.arrow_drop_down,
//                           color: Colors.grey), // Panah putih
//                       decoration: InputDecoration(
//                         labelText: S.of(context).country,
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 2.0),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 2.0),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     // TextFormField(
//                     //   controller: providerUser.countryController,
//                     //   textInputAction: TextInputAction.next,
//                     //   keyboardType: TextInputType.text,
//                     //   decoration: InputDecoration(
//                     //     border: OutlineInputBorder(
//                     //         borderSide:
//                     //             const BorderSide(color: Colors.white, width: 1),
//                     //         borderRadius: BorderRadius.circular(10)),
//                     //   ),
//                     // ),
//                     // const SizedBox(
//                     //   height: 8,
//                     // ),
//                     // Text(
//                     //   S.of(context).state,
//                     //   style: const TextStyle(fontSize: 14),
//                     // ),
//                     // const SizedBox(
//                     //   height: 8,
//                     // ),
//                     // TextFormField(
//                     //   controller: providerUser.stateController,
//                     //   textInputAction: TextInputAction.next,
//                     //   keyboardType: TextInputType.text,
//                     //   decoration: InputDecoration(
//                     //     border: OutlineInputBorder(
//                     //         borderSide:
//                     //             const BorderSide(color: Colors.white, width: 1),
//                     //         borderRadius: BorderRadius.circular(10)),
//                     //   ),
//                     // ),
//                     // const SizedBox(
//                     //   height: 8,
//                     // ),
//                     // Text(
//                     //   S.of(context).city,
//                     //   style: const TextStyle(fontSize: 14),
//                     // ),
//                     // const SizedBox(
//                     //   height: 8,
//                     // ),
//                     // TextFormField(
//                     //   controller: providerUser.cityController,
//                     //   textInputAction: TextInputAction.next,
//                     //   keyboardType: TextInputType.text,
//                     //   decoration: InputDecoration(
//                     //     border: OutlineInputBorder(
//                     //         borderSide:
//                     //             const BorderSide(color: Colors.white, width: 1),
//                     //         borderRadius: BorderRadius.circular(10)),
//                     //   ),
//                     // ),
//                     // const SizedBox(
//                     //   height: 8,
//                     // ),
//                     // Text(
//                     //   S.of(context).district,
//                     //   style: const TextStyle(fontSize: 14),
//                     // ),
//                     // const SizedBox(
//                     //   height: 8,
//                     // ),
//                     // TextFormField(
//                     //   controller: providerUser.districtController,
//                     //   textInputAction: TextInputAction.next,
//                     //   keyboardType: TextInputType.text,
//                     //   decoration: InputDecoration(
//                     //     border: OutlineInputBorder(
//                     //         borderSide:
//                     //             const BorderSide(color: Colors.white, width: 1),
//                     //         borderRadius: BorderRadius.circular(10)),
//                     //   ),
//                     // ),
//                     const SizedBox(height: 16),

//                     // Dropdown for State

//                     DropdownButtonFormField<int>(
//                       hint: Text(providerUser.stateController.text,
//                           style: const TextStyle(color: Colors.grey)),
//                       value: provider.selectedStateId,
//                       items:
//                           provider.states.map<DropdownMenuItem<int>>((state) {
//                         return DropdownMenuItem<int>(
//                           value: state['id'],
//                           child: Text(state['name']),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         if (value != null) {
//                           providerUser.setSelectedStateId(value);
//                           provider.setSelectedStateId(value);
//                           // provider.fetchStates(
//                           //   provider.selectedCountryId!,
//                           // );
//                           provider.fetchCities(
//                             provider.selectedCountryId!,
//                             provider.selectedStateId!,
//                           );
//                         }
//                       },
//                       icon: const Icon(Icons.arrow_drop_down,
//                           color: Colors.grey), // Panah putih
//                       decoration: InputDecoration(
//                         labelText: S.of(context).state,
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 2.0),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 2.0),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),
//                     // Dropdown for City

//                     DropdownButtonFormField<int>(
//                       hint: Text(providerUser.cityController.text,
//                           style: const TextStyle(color: Colors.grey)),
//                       value: provider.selectedCityId,
//                       items:
//                           provider.cities.map<DropdownMenuItem<int>>((cities) {
//                         return DropdownMenuItem<int>(
//                           value: cities['id'],
//                           child: Text(cities['name']),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         if (value != null) {
//                           providerUser.setSelectedCityId(value);
//                           provider.setSelectedCityId(value);
//                           provider.fetchCities(
//                             provider.selectedCountryId!,
//                             provider.selectedStateId!,
//                           );
//                           provider.fetchDistricts(provider.selectedCountryId!,
//                               provider.selectedStateId!, value);
//                         }
//                       },
//                       icon: const Icon(Icons.arrow_drop_down,
//                           color: Colors.grey), // Panah putih
//                       decoration: InputDecoration(
//                         labelText: S.of(context).city,
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 2.0),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 2.0),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 16,
//                     ),
//                     // Dropdown for District

//                     DropdownButtonFormField<int>(
//                       hint: Text(providerUser.districtController.text,
//                           style: const TextStyle(color: Colors.grey)),
//                       value: provider.selectedDistrictId,
//                       items: provider.district
//                           .map<DropdownMenuItem<int>>((district) {
//                         return DropdownMenuItem<int>(
//                           value: district['id'],
//                           child: Text(district['name']),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         if (value != null) {
//                           providerUser.setSelectedDistrictId(value);
//                           provider.setSelectedDistrictId(value);
//                           // provider.fetchDistricts(
//                           //     provider.selectedCountryId!,
//                           //     provider.selectedStateId!,
//                           //     value);
//                         }
//                       },
//                       icon: const Icon(Icons.arrow_drop_down,
//                           color: Colors.grey), // Panah putih
//                       decoration: InputDecoration(
//                         labelText: S.of(context).district,
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 2.0),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: Colors.grey, width: 2.0),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 15,
//                     ),
//                     MaterialButton(
//                         minWidth: MediaQuery.of(context).size.width,
//                         height: 55,
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         color: Colors.white,
//                         textColor: primaryColor,
//                         onPressed: () async {
//                           // dynamic idUser =
//                           //     await PreferenceHandler.retrieveIdUser();
//                           // try {
//                           //   await provider.postAddress(
//                           //     userId: idUser,
//                           //     longitude: locationProvider.longitude,
//                           //     latitude: locationProvider.latitude,
//                           //   );
//                           //   ScaffoldMessenger.of(context)
//                           //       .showSnackBar(const SnackBar(
//                           //     content: Text("Address posted successfully!"),
//                           //   ));
//                           // } catch (e) {
//                           //   ScaffoldMessenger.of(context)
//                           //       .showSnackBar(SnackBar(
//                           //     content: Text("Error posting address: $e"),
//                           //   ));
//                           // }
//                           await providerUser.getCurrentLocation();
//                           await providerUser.openMap(context);
//                         },
//                         child: Text(
//                           S.of(context).use_your_location,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         )),
//                     const SizedBox(
//                       height: 25,
//                     ),
//                     if (providerUser.isLoadingUpdateUser) ...[
//                       CircularProgressWidget(
//                         color: primaryColor,
//                       )
//                     ] else ...[
//                       MaterialButton(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         color: primaryColor,
//                         textColor: Colors.white,
//                         height: 54,
//                         minWidth: MediaQuery.of(context).size.width,
//                         onPressed: () async {
//                           setState(() {});
//                           // handleAction(context);
//                           if (_formKey.currentState?.validate() ?? false) {
//                             if (providerUser.dataUser?.image == null &&
//                                 providerUser.image == null) {
//                               NotificationUtils.showSnackbar(
//                                   S.of(context).please_upload_profile_picture,
//                                   backgroundColor: Colors.red);
//                             } else {
//                               await providerUser.updateUser(context);
//                             }
//                           }
//                         },
//                         child: Text(S.of(context).save),
//                       )
//                     ]
//                   ],
//                 ),
//               ),
//             ),
//           ));
//     });
//   }

//   handleAction(context) async {
//     showDialog(
//       context: context,
//       barrierDismissible:
//           false, // Prevents dismissing the dialog by tapping outside
//       builder: (context) {
//         return AlertDialog(
//           content: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               const CircularProgressIndicator(),
//               const SizedBox(width: 20),
//               Text(S.of(context).process), // Display loading text
//             ],
//           ),
//         );
//       },
//     );

//     // Timer(const Duration(seconds: 3), () {
//     //   Navigator.pop(context);
//     // });
//     // Handle further actions after loading is complete
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/auth/component/country_state_city_provider.dart';
import 'package:coolappflutter/presentation/pages/auth/map_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/utils/takeimage_utils.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../main/home_screen.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key, required this.phone});
  final dynamic phone;

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final _formKey = GlobalKey<FormState>();
  bool isImageSelected = false;
  TextEditingController modifiedController = TextEditingController();
  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerState = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerDistrict = TextEditingController();
  TextEditingController controllerLong = TextEditingController();
  TextEditingController controllerLat = TextEditingController();

  bool isIndonesia = true;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String? selectedDistrict;
  String? selectedLong;
  String? selectedLat;

  @override

  void _navigateToMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen()),
    );

    if (result != null) {
      final providerUser = Provider.of<ProviderUser>(context, listen: false);
      setState(() {
        controllerCountry.text = result['country'];
        controllerState.text = result['state'];
        controllerCity.text = result['city'];
        controllerDistrict.text = result['district'];

        providerUser.SelectedCountryController.text = result['country'];
        providerUser.SelectedStateController.text = result['state'];
        providerUser.SelectedCityController.text = result['city'];
        providerUser.SelectedDistrictController.text = result['district'];
        providerUser.SelectedLongtitudeController.text = result['longtitude'].toString();
        providerUser.SelectedLatitudeController.text = result['latitide'].toString();
      });
    }
  }
  void initState() {
    controllerCountry.text = selectedCountry ?? '';
    controllerState.text = selectedState ?? '';
    controllerCity.text = selectedCity ?? '';
    controllerDistrict.text = selectedDistrict ?? '';
    controllerLong.text = selectedDistrict ?? '';
    controllerLat.text = selectedDistrict ?? '';
    super.initState();
    Provider.of<ProviderUser>(context, listen: false).getAddress(context);

    Provider.of<CountryStateCityProvider>(context, listen: false)
        .fetchCountries(0);
    Provider.of<ProviderUser>(context, listen: false)
        .setPhoneNumber(widget.phone.toString());
    Timer(Duration(seconds: 2), () {
      Provider.of<ProviderUser>(context, listen: false).getLocalePhonenumber();
      Provider.of<ProviderUser>(context, listen: false)
          .setInitialValues(widget.phone.toString());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final providerUser = Provider.of<ProviderUser>(context, listen: false); // Ambil provider

        String originalText = providerUser.phoneController.text;
        print("Original Text: $originalText"); // Debugging

        String modifiedText = originalText.length > 2 ? originalText.substring(2) : "";
        print("Modified Text: $modifiedText"); // Debugging

        setState(() {
          modifiedController.text = modifiedText;
        });
      });

      // provider.setSelectedCountryId(int.parse(
      //     Provider.of<ProviderUser>(context, listen: false)
      //         .countryController
      //         .text));
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountryStateCityProvider>(context);
    return Consumer<ProviderUser>(builder: (context, providerUser, child) {
      bool isLoading = providerUser.isLoading == true;
      bool isSave = providerUser.isLoadingUpdateUser == true;
      return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              children: [
                // Title "Profile" di sebelah kiri
                Text(
                  S.of(context).profile,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            actions: [
              // Tombol "Simpan" di sebelah kanan
              Padding(
                padding: const EdgeInsets.only(
                    right: 10), // Memberikan jarak dari kanan
                child: GestureDetector(
                  onTap: isSave ? null : () async {
                    setState(() {});
                    if (_formKey.currentState?.validate() ?? false) {
                      if (providerUser.dataUser?.image == null &&
                          providerUser.image == null) {
                        NotificationUtils.showSnackbar(
                          S.of(context).please_upload_profile_picture,
                          backgroundColor: Colors.red,
                        );
                      } else {
                        await providerUser.updateUser(context,'updateprofile');
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isSave ? SizedBox( height: 20 ,width: 20 ,child: CircularProgressIndicator()) : Text(
                      S.of(context).save, // Teks tombol
                      style: TextStyle(
                        color: Colors.blue, // Warna teks biru
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: isLoading
                    ? Column(
                  children: [
                    gapH20,
                    gapH20,
                    shimmerContainer(height: 300, width: double.infinity),
                    gapH32,
                    shimmerButton(),
                    gapH10,
                    shimmerButton(),
                    gapH10,
                    shimmerButton(),
                    gapH10,
                    shimmerButton(),
                    gapH10,
                    shimmerButton(),
                    gapH10,

                  ],
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Gambar Profil berbentuk kotak dengan lebar layar dan tinggi 200
                        providerUser.isProfileUser
                            ? Shimmer.fromColors(
                                baseColor: greyColor.withOpacity(0.2),
                                highlightColor: whiteColor,
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Lebar layar
                                  height: 270, // Tinggi 200
                                  color:
                                      greyColor, // Menggunakan warna greyColor sebagai placeholder
                                ))
                            : providerUser.image != null
                                ? SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width, // Lebar layar
                                    height: 270, // Tinggi 200
                                    child: Center(
                                      child: Image.file(
                                        File(providerUser.image!.path),
                                        // Menjaga proporsi gambar
                                      ),
                                    ),
                                  )
                                : providerUser.dataUser?.image == null
                                    ? Image.asset(
                                        "images/default_user.png",
                                        width: MediaQuery.of(context)
                                            .size
                                            .width, // Lebar layar
                                        height: 270, // Tinggi 200
                                        fit: BoxFit.cover,
                                      )
                                    : SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width, // Lebar layar
                                        height: 270, // Tinggi 200
                                        child: Center(
                                          child: Image.network(
                                              "${providerUser.dataUser?.image}",
                                              fit: BoxFit
                                                  .cover, // Menjaga proporsi gambar
                                              errorBuilder:
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
                                                      .updateProfileUser(
                                                          context,
                                                          providerUser.image!);
                                                }
                                              },
                                              child: Image.asset(
                                                'images/default_user.png', // Path ke gambar placeholder lokal
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          }),
                                        ),
                                      ),

                        // Ikon kamera di kanan bawah
                        Positioned(
                          bottom: 10, // Memberikan jarak dari bawah
                          right: 10, // Memberikan jarak dari kanan
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
                            child: Container(
                              width: 50, // Lebar kotak
                              height: 50, // Tinggi kotak
                              decoration: BoxDecoration(
                                color: Colors.blue, // Warna kotak biru
                                borderRadius: BorderRadius.circular(
                                    8), // Sudut kotak yang melengkung
                              ),
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
                    Row(children: [
                      Expanded(
                        child: IntlPhoneField(
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(fontFamily: "Poppins"),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          initialCountryCode: providerUser.initialCodeCountry,
                          style: const TextStyle(fontFamily: "Poppins"),
                          dropdownTextStyle:
                              const TextStyle(fontFamily: "Poppins"),
                          disableLengthCheck: true,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          readOnly: true,
                          enabled: false,
                          controller: modifiedController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ]),
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
                      height: 15,
                    ),
                    if (providerUser.SelectedCountryController.text.isNotEmpty)
                      CustomTextField(
                        controller: providerUser.SelectedCountryController,
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value;
                            providerUser.SelectedCountryController.text = value;
                          });
                        },
                        textColor: Colors.black,
                      ),
                    if (providerUser.SelectedStateController.text.isNotEmpty)
                      CustomTextField(
                        controller: providerUser.SelectedStateController,
                        onChanged: (value) {
                          setState(() {
                            selectedState = value;
                            providerUser.SelectedStateController.text = value;
                          });
                        },
                        textColor: Colors.black,
                      ),
                    if (providerUser.SelectedCityController.text.isNotEmpty)
                      CustomTextField(
                        controller: providerUser.SelectedCityController,
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value;
                            selectedCity =  providerUser.SelectedCityController.text;
                          });
                        },
                        textColor: Colors.black,
                      ),
                    if (providerUser.SelectedDistrictController.text.isNotEmpty)
                      CustomTextField(
                        controller: providerUser.SelectedDistrictController,
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value;
                            selectedDistrict =  providerUser.SelectedDistrictController.text;
                          });
                        },
                        textColor: Colors.black,
                      ),
                    MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 55,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: primaryColor,
                        textColor: whiteColor,
                        onPressed: () async {
                          _navigateToMap();
                        },
                        child: Text(
                          S.of(context).silahkanPilihLokasi,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
          ),
        floatingActionButton: const CustomFAB(),
      );
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
  }


}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Color textColor;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        enabled: false,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: textColor),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: textColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: textColor, width: 2.0),
          ),
        ),
      ),
    );
  }
}
