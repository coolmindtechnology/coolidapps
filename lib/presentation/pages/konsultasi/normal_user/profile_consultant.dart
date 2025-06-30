import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/Container_Follower.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/apps/app_sizes.dart';
import '../../konsultasi/normal_user/profile_card.dart';
import '../../profiling/screen_hasil_kepribadian_dibawah17.dart';

class ProfileConsultant extends StatefulWidget {
  final String id;
  const ProfileConsultant({super.key,required this.id});

  @override
  State<ProfileConsultant> createState() => _ProfileConsultantState();
}

class _ProfileConsultantState extends State<ProfileConsultant> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () async {
        final provider = await Provider.of<ConsultantProvider>(context, listen: false);
        await provider.getDetailConsultantData(context, widget.id);
        await provider.getTopicConsultantData(context, widget.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsultantProvider>(
      builder: (context, value, child) {
        bool loading = value.isLoadingDetailConsultant || value.isLoadingTopicConsultant;
        return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).Consultant_Profile,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    Colors.white,
                  ],
                  stops: [0.1, 0.35],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: loading ? Column(
                    children: [
                      shimmerContainer(height: 250, width: double.infinity),
                      gapH20,
                      shimmerButton(),
                      gapH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: shimmerButton()),
                          gapW10,
                          Expanded(child: shimmerButton()),
                        ],
                      ),
                      gapH32,
                      shimmerIconRow(),
                      gapH20,
                      shimmerButton(),
                      gapH32,
                      shimmerButton(),
                    ],
                  ) : RefreshIndicator(
                    onRefresh: () async {
                      final provider = Provider.of<ConsultantProvider>(context, listen: false);
                      await provider.getDetailConsultantData(context, widget.id);
                      await provider.getTopicConsultantData(context, widget.id);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileCard(
                            imagePath: value.detailConsultantData?.image ?? "",
                            name: value.detailConsultantData?.name ?? "",
                            title: value.detailConsultantData?.typeBrain ?? "",
                            bloodType: value.detailConsultantData?.typeBlood ?? "",
                            location: value.detailConsultantData?.address ?? "",
                            warnastatus: Colors.white,
                        ),
                        ContainerProfile(
                          title1: value.detailConsultantData?.sessionSuccess.toString() ?? "0",
                          subtitle1: S.of(context).Session,
                          title2: value.detailConsultantData?.rating.toString() ?? "0",
                          subtitle2: S.of(context).rating,
                          title3:  value.detailConsultantData?.follower.toString() ?? "0",
                          subtitle3: S.of(context).followers,
                        ),
                        GlobalButton(
                            onPressed: () async {
                              await value.followConsultant(
                                context,
                                widget.id,
                                (value.detailConsultantData?.isFollow ?? false) ? "0" : "1",
                              );

                              await value.getDetailConsultantData(context, widget.id);
                            },
                            color: primaryColor,
                          text: (value.detailConsultantData?.isFollow ?? false)
                              ? S.of(context).unfollow
                              : S.of(context).Follow_on_Coolchat, ),
                        SizedBox(
                          height: 30,
                        ),
                        if(value.topicConsultantData == null || value.topicConsultantData!.isEmpty)
                        Text(
                          S.of(context).Related_Topics,
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(S.of(context).Related_Topics,style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 20),),
                        gapH20,
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2, // Sesuaikan rasio lebar/tinggi
                            ),
                            itemCount: value.topicConsultantData?.length ?? 0,
                            itemBuilder: (context, index) {
                              final data = value.topicConsultantData![index];
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.8),
                                      Colors.lightBlueAccent.shade100,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data?.title ?? "",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        '+ ${data?.count ?? "0"} ${S.of(context).Discussing_This}',
                                        style: TextStyle( fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}


// Class untuk container follower
class ContainerProfile extends StatelessWidget {
  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;
  final String title3;
  final String subtitle3;

  const ContainerProfile({
    Key? key,
    required this.title1,
    required this.subtitle1,
    required this.title2,
    required this.subtitle2,
    required this.title3,
    required this.subtitle3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // Latar belakang putih
          borderRadius: BorderRadius.circular(8), // Sudut container dibulatkan
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Bayangan lembut
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 5), //
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(title1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis),
                    Text(subtitle1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ],
            ),
            Container(
              height: 50,
              width: 1,
              color: Colors.grey,
            ),

            // Row kedua
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.star, color: Colors.yellow,),
                        gapW4,
                        Text(title2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Text(subtitle2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ],
            ),
            Container(
              height: 50,
              width: 1,
              color: Colors.grey,
            ),

            // Row ketiga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(title3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis),
                    Text(subtitle3, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

