import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/result_detail.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/result_under17.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuTentangProfilUnder17 extends StatefulWidget {
  final DataProfiling? data;
  const MenuTentangProfilUnder17({super.key, this.data});

  @override
  State<MenuTentangProfilUnder17> createState() => _MenuTentangProfilUnder17State();
}

class _MenuTentangProfilUnder17State extends State<MenuTentangProfilUnder17> {
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
                      Nav.to(ResultDetailUnder17(
                        data: widget.data,
                        type: 'tipeKaya',
                      ));
                    },
                    text: S.of(context).rich_type,
                    imagePath: 'images/profiling/icTipeKaya.png',
                  ),
                  ItemButton(
                    onTap: () {
                      Nav.to(ResultDetailUnder17(data: widget.data, type: 'tipeOtak'));
                    },
                    text: S.of(context).brain_type,
                    imagePath: 'images/profiling/icTipeOtak.png',
                  ),
                  ItemButton(
                    onTap: () {
                      Nav.to(ResultDetailUnder17(data: widget.data, type: 'personality'));
                    },
                    text: S.of(context).personality,
                    imagePath: 'images/profiling/icPersonality.png',
                  ),
                  ItemButton(
                    onTap: () {
                      Nav.to(ResultDetailUnder17(data: widget.data, type: 'karir'));
                    },
                    text: S.of(context).career,
                    imagePath: 'images/profiling/icKarir.png',
                  ),
                  ItemButton(
                    onTap: () {
                      Nav.to(ResultDetailUnder17(data: widget.data, type: 'polaBahagia'));
                    },
                    text: S.of(context).happiness_pattern,
                    imagePath: 'images/profiling/icPolaBahagia.png',
                  ),
                  ItemButton(
                    onTap: () {
                      Nav.to(ResultDetailUnder17(data: widget.data, type: 'polaInteraksi'));
                    },
                    text: S.of(context).social_interaction_pattern,
                    imagePath: 'images/profiling/icPolaInteraksi.png',
                  ),
                  ItemButton(
                    onTap: () {
                      Nav.to(ResultDetailUnder17(data: widget.data, type: 'family'));
                    },
                    text: S.of(context).family,
                    imagePath: 'images/profiling/icFamily.png',
                  ),
                  ItemButton(
                    onTap: () {
                      Nav.to(ResultDetailUnder17(data: widget.data, type: 'polaHealing'));
                    },
                    text: S.of(context).healing_pattern,
                    imagePath: 'images/profiling/IcPolaHealing.png',
                  ),
                  ItemButton(
                    onTap: () {
                      Nav.to(ResultDetailUnder17(data: widget.data, type: 'kebutuhan'));
                    },
                    text: S.of(context).kebutuhan,
                    imagePath: 'images/profiling/icSpiritual.png',
                  ),
                  ItemButton(
                    onTap: () {
                      Nav.to(ResultDetailUnder17(data: widget.data,type: 'finansial',));
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
