import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/provider/provider_affiliate.dart';
import 'package:cool_app/presentation/pages/afiliate/screen_input_rekening.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../theme/color_utils.dart';
import '../../widgets/refresh_icon_widget.dart';

class SettingAffiliate extends StatefulWidget {
  const SettingAffiliate({super.key});

  @override
  State<SettingAffiliate> createState() => _SettingAffiliateState();
}

class _SettingAffiliateState extends State<SettingAffiliate> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    Future.microtask(
        () => context.read<ProviderAffiliate>().getHomeAff(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAffiliate>(
        builder: (BuildContext context, value, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            S.of(context).setting,
            style: TextStyle(color: whiteColor),
          ),
          backgroundColor: primaryColor,
        ),
        body: CustomMaterialIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            Provider.of<ProviderAffiliate>(context, listen: false)
                .getHomeAff(context);
            return Future<void>.delayed(const Duration(seconds: 1));
          },
          indicatorBuilder:
              (BuildContext context, IndicatorController controller) {
            return const RefreshIconWidget();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).bank_account,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Nav.to(ScreenInputRekening(
                        dataBank: value.dataAffiliasi,
                        onUpdate: () {
                          value.getHomeAff(context);
                        },
                      ));
                    },
                    child: TextFormField(
                      enabled: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.arrow_forward_ios, color: greyColor),
                        // prefixIcon: Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8),
                        //   child: Image.asset(
                        //     "assets/icons/visa_icon.png",
                        //     width: 32,
                        //     height: 32,
                        //   ),
                        // ),
                        hintText: value.dataAffiliasi?.bankName ?? "-",
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
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "${dataGlobal.dataUser?.name ?? "-"}",
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
                    S.of(context).email,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: dataGlobal.dataUser?.email ?? "-",
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
                  TextFormField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "${dataGlobal.dataUser?.phoneNumber}",
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
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: primaryColor,
                    textColor: Colors.white,
                    height: 54,
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      // if (_formKey.currentState?.validate() ?? false) {
                      //   await providerUser.updateUser(context);
                      // }
                    },
                    child: Text(S.of(context).save),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
