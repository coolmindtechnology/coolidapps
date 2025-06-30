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
        padding: const EdgeInsets.only(bottom: 20,top: 20,left: 10,right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "tipe_kaya",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'tipeKaya'));
                  }
                },
                text: S.of(context).rich_type,
                imagePath: 'images/profiling/icTipeKaya.png',
              ),
              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "tipe_otak",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'tipeOtak'));
                  }
                },
                text: S.of(context).brain_type,
                imagePath: 'images/profiling/icTipeOtak.png',
              ),
              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "personality",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'personality'));
                  }
                },
                text: S.of(context).personality,
                imagePath: 'images/profiling/icPersonality.png',
              ),

              if (value.detailProfiling?.tipeDarah != null)
                ItemButton(
                  isLoading: value.isDetail,
                  onTap: () async {
                    await context.read<ProviderProfiling>().getDetailProfiling(
                      context,
                      widget.data?.idLogResult.toString() ?? "",
                      "tipe_darah",
                    );
                    if (value.isDetail == false && value.isSuccesgetdetail == true) {
                      Nav.to(ResultDetail(data: widget.data, type: 'tipeDarah'));
                    }
                  },
                  text: S.of(context).blood_group,
                  imagePath: 'images/profiling/icGolDarah.png',
                ),

              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "karir",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'karir'));
                  }
                },
                text: S.of(context).career,
                imagePath: 'images/profiling/icKarir.png',
              ),
              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "pola_bahagia",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'polaBahagia'));
                  }
                },
                text: S.of(context).happiness_pattern,
                imagePath: 'images/profiling/icPolaBahagia.png',
              ),
              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "pola_interaksi",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'polaInteraksi'));
                  }
                },
                text: S.of(context).social_interaction_pattern,
                imagePath: 'images/profiling/icPolaInteraksi.png',
              ),
              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "family",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'family'));
                  }
                },
                text: S.of(context).family,
                imagePath: 'images/profiling/icFamily.png',
              ),
              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "pola_healing",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'polaHealing'));
                  }
                },
                text: S.of(context).healing_pattern,
                imagePath: 'images/profiling/IcPolaHealing.png',
              ),
              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "kebutuhan",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'kebutuhan'));
                  }
                },
                text: S.of(context).kebutuhan,
                imagePath: 'images/profiling/icSpiritual.png',
              ),
              ItemButton(
                isLoading: value.isDetail,
                onTap: () async {
                  await context.read<ProviderProfiling>().getDetailProfiling(
                    context,
                    widget.data?.idLogResult.toString() ?? "",
                    "finansial",
                  );
                  if (value.isDetail == false && value.isSuccesgetdetail == true) {
                    Nav.to(ResultDetail(data: widget.data, type: 'finansial'));
                  }
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
  final bool isLoading;
  final VoidCallback? onTap;
  const ItemButton({super.key,
  this.imagePath,this.text,this.onTap,required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: isLoading ? Colors.black12 : Colors.white,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: isLoading ? null : onTap,
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
        ),
      ),
    );
  }
}
