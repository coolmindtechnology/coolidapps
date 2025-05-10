import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/result_detail.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuTentangProfil extends StatefulWidget {
  final DataProfiling? data;
  const MenuTentangProfil({super.key, this.data});

  @override
  State<MenuTentangProfil> createState() => _MenuTentangProfilState();
}

class _MenuTentangProfilState extends State<MenuTentangProfil> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderProfiling>(
      builder: (context, value, child) {
        return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).about_your_profile,
          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20,top: 20,left: 30,right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data,type: 'tipeKaya',));
                },
                text: S.of(context).rich_type,
                imagePath: 'images/profiling/icTipeKaya.png',
              ),
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data, type: 'tipeOtak'));
                },
                text: S.of(context).brain_type,
                imagePath: 'images/profiling/icTipeOtak.png',
              ),
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data, type: 'personality'));
                },
                text: S.of(context).personality,
                imagePath: 'images/profiling/icPersonality.png',
              ),
              if (value.detailProfiling?.tipeDarah != null)
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data, type: 'tipeDarah'));
                },
                text: S.of(context).blood_group,
                imagePath: 'images/profiling/icGolDarah.png',
              ),
              // ItemButton(
              //   onTap: () {
              //     Nav.to(ResultDetail(data: widget.data, type: 'komunikasi'));
              //   },
              //   text: S.of(context).communication,
              //   imagePath: 'images/profiling/icKomunikasi.png',
              // ),
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data, type: 'karir'));
                },
                text: S.of(context).career,
                imagePath: 'images/profiling/icKarir.png',
              ),
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data, type: 'polaBahagia'));
                },
                text: S.of(context).happiness_pattern,
                imagePath: 'images/profiling/icPolaBahagia.png',
              ),
              // ItemButton(
              //   onTap: () {
              //     Nav.to(ResultDetail(data: widget.data, type: 'finansial'));
              //   },
              //   text: S.of(context).financial,
              //   imagePath: 'images/profiling/icFinansial.png',
              // ),
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data, type: 'polaInteraksi'));
                },
                text: S.of(context).social_interaction_pattern,
                imagePath: 'images/profiling/icPolaInteraksi.png',
              ),
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data, type: 'family'));
                },
                text: S.of(context).family,
                imagePath: 'images/profiling/icFamily.png',
              ),
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data, type: 'polaHealing'));
                },
                text: S.of(context).healing_pattern,
                imagePath: 'images/profiling/IcPolaHealing.png',
              ),
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data, type: 'kebutuhan'));
                },
                text: S.of(context).kebutuhan,
                imagePath: 'images/profiling/icSpiritual.png',
              ),
              ItemButton(
                onTap: () {
                  Nav.to(ResultDetail(data: widget.data,type: 'finansial',));
                },
                text: S.of(context).financial,
                imagePath: 'images/profiling/icFinansial.png',
              ),




            ],
          ),
        ),
      ),
    ); }, );
  }
}

class ItemButton extends StatelessWidget {
  final String? imagePath;
  final String? text;
  final VoidCallback? onTap;
  const ItemButton({super.key,
  this.imagePath,this.text,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(imagePath ?? '',fit: BoxFit.cover,width: 30,),
            gapW10,
            Text(text ?? '',style: TextStyle(color: BlueColor,fontWeight: FontWeight.w600,fontSize: 18),),
            Spacer(),
            Icon(CupertinoIcons.forward,color: BlueColor,)
          ],
        ),
      ),
    );
  }
}
