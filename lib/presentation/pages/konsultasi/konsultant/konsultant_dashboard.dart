import 'package:coolappflutter/data/apps/app_assets.dart';
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_consultant.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/Histori_Consultant.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/Tab/tab_arsip.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/Tab/tab_request.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/Tab/tab_session.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/Tab/tab_wait.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/hisotry_komisen.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/history_curhat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/konsultant/history/history_konsul.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/Container/container_slider_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/Container/Continer_profiling.dart';

class KonsultantDashboard extends StatefulWidget {
  const KonsultantDashboard({super.key});

  @override
  State<KonsultantDashboard> createState() => _KonsultantDashboardState();
}

class _KonsultantDashboardState extends State<KonsultantDashboard> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    // Panggil fungsi getHomeConsultant
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ConsultantProvider>(context, listen: false);
      provider.getHomeConsultant(context);
    });
  }

  final List<Widget> _tabs = [
    TabSesiKonsultant(),
    TabRequestKonsultant(),
    TabWaitKonsultant(),
    TabArsipKonsultant(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConsultantProvider>(context);
    final homeConsultantData = provider.homeConsultantData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              S.of(context).Consultation,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Ikon tombol kembali
          onPressed: () {
            Nav.toAll(
                NavMenuScreen()); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Consumer<ConsultantProvider>(
              builder: (context, provider, _) {
                // Cek apakah provider sedang loading
                bool isLoading = provider.isLoadingStatus;
                bool isAvailable =
                    provider.homeConsultantData?.availableStatus == "1";

                return GestureDetector(
                  onTap: () async {
                    // if (!isLoading) {
                    //   // Hanya update status jika tidak sedang loading
                    //   int newStatus = isAvailable ? 0 : 1; // Toggle status
                    //   await provider.updateStatusProvider(context, newStatus);
                    // }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.green,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      S.of(context).Available,
                      style: TextStyle(
                        color: isLoading
                            ? Colors.grey // Teks abu-abu saat loading
                            : (Colors.green),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: Image.asset(
          //     AppAsset.icMark,
          //     height: 40,
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ContainerSliderHome(
              text: S.of(context).Affordable_Professional_Services,
              imageUrl: AppAsset.imgKonsultanDashboad,
              textColor: Colors.white,
              containerColor: Colors.orange,
              textSize: 19,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              S.of(context).Welcome_To_Consultation_Program,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              S.of(context).Guide_Followers,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContainerProfiling(
                  backgroundColor: Colors.lightBlueAccent,
                  borderColor: Colors.blue,
                  title: S.of(context).Consultation_History,
                  subtitle:
                      '${homeConsultantData?.totalHistoryConsultations ?? "0"} ${S.of(context).Session}',
                  onTap: () {
                    Nav.to(HisotryKonsultasi());
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ContainerProfiling(
                  backgroundColor: Color(0xFFF8DB1C),
                  borderColor: YellowColor,
                  title: S.of(context).Confession_History,
                  subtitle:
                      '${homeConsultantData?.totalHistoryCurhat ?? "0"} ${S.of(context).Session}',
                  onTap: () {
                    Nav.to(HisotryCurhat());
                  },
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Nav.to(HistoryKomisen());
              },
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: BlueColor, width: 2), // Warna garis tepi
                  borderRadius:
                      BorderRadius.circular(8), // Membulatkan sudut container
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.8),
                      primaryColor,
                    ],
                    begin: Alignment.topCenter, // Gradien dimulai dari atas
                    end: Alignment.bottomCenter, // Gradien berakhir di bawah
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).Total_Commission,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                     SizedBox(height: 5,),
                      Text(
                          'Rp.${homeConsultantData?.totalComission ?? "0"}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: BlueColor)),
                      SizedBox(height: 5,),
                      Text(
                        '${homeConsultantData?.totalHistoryComission ?? "0"} ${S.of(context).Session_Completed}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTab(index: 0, text: S.of(context).Active_session),
                  _buildTab(index: 1, text: S.of(context).Requests),
                  _buildTab(index: 2, text: S.of(context).Awaiting_Payment),
                  _buildTab(index: 3, text: S.of(context).Archives),
                ],
              ),
            ),
            Expanded(
              child: _tabs[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({required int index, required String text}) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : BlueColor,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: isSelected ? Colors.blue : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10),
        ),
      ),
    );
  }
}
