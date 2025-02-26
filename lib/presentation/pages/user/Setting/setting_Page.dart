import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/home_affiliate.dart';
import 'package:coolappflutter/presentation/pages/afiliate/result_rekening_bank.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Report/Report_Page.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Security/Security_Page.dart';
import 'package:coolappflutter/presentation/pages/user/change_language.dart';
import 'package:coolappflutter/presentation/pages/user/Setting/Delete_Account/delete_account.dart';
import 'package:coolappflutter/presentation/pages/user/delete_account.dart';
import 'package:coolappflutter/presentation/pages/user/update_password.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting_page extends StatefulWidget {
  final void Function()? onLanguageChanged;
  const Setting_page({super.key, this.onLanguageChanged});

  @override
  State<Setting_page> createState() => _Setting_pageState();
}

class _Setting_pageState extends State<Setting_page> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (BuildContext context) {
      return ProviderUser.initMemberArea(context);
    }, child: Consumer<ProviderUser>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            S.of(context).setting,
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).Account,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              // ItemSetting(
              //   title: S.of(context).Security,
              //   onTap: () {
              //     Nav.to(SecurityPage());
              //   },
              // ),
              // ItemSetting(
              //   title: S.of(context).Notification_Settings,
              //   onTap: () {},
              // ),
              // ItemSetting(
              //   title: S.of(context).language,
              //   onTap: () {
              //     Nav.to(ChangeLanguange(
              //       onChanged: () {
              //         setState(() {
              //           widget.onLanguageChanged!();
              //         });
              //       },
              //     ));
              //   },
              // ),
              ItemSetting(
                title: S.of(context).bank_account,
                onTap: () {
                  Nav.to(HomeAffiliate());
                },
              ),
              ItemSetting(
                title: S.of(context).change_password,
                onTap: () {
                  Nav.to(UpdatePassword());
                  setState(() {});
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                S.of(context).About_Us_And_Help,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              ItemSetting(
                title: S.of(context).Report_Issue_Usage,
                onTap: () {
                  Nav.to(ReportPage());
                },
              ),
              // ItemSetting(
              //   title: S.of(context).Help,
              //   onTap: () {},
              // ),
              // ItemSetting(
              //   title: S.of(context).Terms_and_Conditions,
              //   onTap: () {},
              // ),
              ItemSetting(
                title: S.of(context).delete_account,
                image: "disclaimer.png",
                onTap: () {
                  Nav.to(DeletedAccount());
                  setState(() {});
                },
              ),
              Spacer(),
              Center(
                child: Text(S.of(context).App_Version),
              )
            ],
          ),
        ),
      );
    }));
  }
}

class ItemSetting extends StatelessWidget {
  final String title;
  final String? image;
  final void Function()? onTap;
  const ItemSetting({
    super.key,
    required this.title,
    this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: SizedBox(
        width: 24,
        child: Center(
          child: Image.asset(
            "images/menu/arrow.png",
            width: 8,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
