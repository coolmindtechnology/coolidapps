// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_utils.dart';
import '../../../utils/notification_utils.dart';
import '../../../widgets/button_primary.dart';
import '../../../widgets/custom_input_field.dart';

class InputCodeRefPofilling extends StatefulWidget {
  const InputCodeRefPofilling({super.key});

  @override
  State<InputCodeRefPofilling> createState() => _InputCodeRefPofillingState();
}

class _InputCodeRefPofillingState extends State<InputCodeRefPofilling> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProviderProfiling()),
        ],
        child: Consumer<ProviderProfiling>(
            builder: (BuildContext context, valuePro, Widget? child) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  S.of(context).Support_Your_Preferred_Promoter,
                  // "Dukung Promotor Pilihan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      !valuePro.isLoading
                          ? Container(
                              height: MediaQuery.sizeOf(context).height / 2.8,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0),
                                  bottom: Radius.circular(10.0),
                                ),
                                color: Colors.blue,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          S
                                              .of(context)
                                              .Support_Your_Preferred_Promoter,
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        Text(
                                          S
                                              .of(context)
                                              .Please_select_the_promoter_you_wish_to_support,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset("images/folder.png")
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(S.of(context).not_found,
                                        // "Mohon maaf, sepertinya belum ada promotor terdekat dalam jangkauan anda",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            valuePro.fetchAffiliates();
                                            valuePro.isLoading = true;
                                          },
                                          child: Text(
                                            S.of(context).lanjut,
                                            // "Lanjut Tanpa Code"
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10.0),
                                  bottom: Radius.circular(10.0),
                                ),
                                color: Colors.white,
                              ),
                              child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 2.5,
                                  child: valuePro.affiliates.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: valuePro.affiliates.length,
                                          itemBuilder: (context, index) {
                                            final affiliate =
                                                valuePro.affiliates[index];

                                            dynamic isSelected =
                                                valuePro.selectedIndex == index;
                                            debugPrint(isSelected.toString());
                                            return Container(
                                              color: isSelected
                                                  ? primaryColor
                                                  : whiteColor,
                                              child: ListTile(
                                                onTap: () {
                                                  valuePro
                                                      .setSelectedIndex(index);
                                                  valuePro.colorChange();
                                                  valuePro.controllerProfillingCode
                                                          .text =
                                                      affiliate[
                                                          'refferal_code'];
                                                },
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      affiliate['picture']),
                                                ),
                                                title: Text(affiliate['name']),
                                                subtitle:
                                                    Text(affiliate['address']),
                                                trailing: IconButton(
                                                  icon: const Icon(Icons.copy),
                                                  onPressed: () {
                                                    valuePro.setSelectedIndex(
                                                        index);
                                                    valuePro.colorChange();
                                                    valuePro.controllerProfillingCode
                                                            .text =
                                                        affiliate[
                                                            'refferal_code'];
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                      text: affiliate[
                                                          'refferal_code'],
                                                    ));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '${S.of(context).referral_code_copied} ${affiliate['refferal_code']}',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Text(S.of(context).no_data),
                                        )),
                            ),
                      Stack(
                        children: [
                          const Divider(
                            color: Colors.blue,
                          ),
                          Center(
                            child: Container(
                              width: 50,
                              color: Colors.white,
                              child: Text(
                                S.of(context).Or,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).Support_Your_Preferred_Promoter,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                S.of(context).Enter_referal_code,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      CustomInputField(
                        textEditingController:
                            valuePro.controllerProfillingCode,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return S.of(context).cannot_be_empty;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          child: ButtonPrimary(
                            S.of(context).next,
                            expand: true,
                            radius: 8,
                            elevation: 0.0,
                            onPress: () async {
                              if (valuePro
                                  .controllerProfillingCode.text.isNotEmpty) {
                                await valuePro.upgradeToMember(
                                    context, valuePro.controllerProfillingCode);
                              } else {
                                NotificationUtils.showSnackbar(
                                    S.of(context).cannot_be_empty,
                                    backgroundColor: primaryColor);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
