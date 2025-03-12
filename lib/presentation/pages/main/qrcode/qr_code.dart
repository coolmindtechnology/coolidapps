import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/widgets/refresh_icon_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage>
    with SingleTickerProviderStateMixin {

   String imageUrl = 'https://cool-new.dschazy.com/api/generate-qrcode?size=300&margin=10&text=https://cool-app.udadeveloper.com/login';
String token = dataGlobal.token;
  late TabController _tabController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool showUrl = false; // State untuk menampilkan URL
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _refreshImage();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshImage() async {
    // Simulate network fetch delay
    // await Future.delayed(Duration(seconds: 2));

    // Refresh the image by updating the state
    setState(() {
      imageUrl =
      '${ApiEndpoint.getMyAffiliateQR}?size=300&margin=10&timestamp=${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("images/buku/arrowleft.png")),
        title: Text(
          "Kode QR",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF4CCBF4),
        // bottom: TabBar(
        //   controller: _tabController,
        //   indicatorColor: Colors.white,
        //   labelColor: Colors.black,
        //   unselectedLabelColor: Colors.black54,
        //   labelStyle: TextStyle(fontWeight: FontWeight.bold),
        //   tabs: [
        //     Tab(
        //       icon: Icon(Icons.qr_code, color: Colors.black),
        //       text: 'Kode Saya',
        //     ),
        //     Tab(
        //       icon: Icon(Icons.qr_code_scanner, color: Colors.black),
        //       text: 'Scan QR',
        //     ),
        //   ],
        // ),
      ),
      body: CustomMaterialIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          _refreshImage();
         return Future<void>.delayed(const Duration(seconds: 1));
        },
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return const RefreshIconWidget();
        },
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMyQRCodeTab(),
                  _buildQRScannerTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: FloatingActionButton(
      //   onPressed: () {
      //     _refreshImage();
      //   },
      //   child: const Icon(Icons.refresh),
      // )
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Color(0xFF93F1FB), // Warna TabBar
      // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabButton("Kode Saya", Icons.qr_code, 0),
          // SizedBox(width: 10),
          _buildTabButton("Scan QR", Icons.qr_code_scanner, 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, IconData icon, int index) {
    bool isSelected = _tabController.index == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tabController.animateTo(index);
          });
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFDBFEFD) : Color(0xFF93F1FB),
            // borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(color: Color(0xFF4CCBF4))
                : Border.all(color: Colors.transparent), // Outline warna grey
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyQRCodeTab() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Silakan Scan QR Gunakan CoolApp",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Container(
          margin: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey), // Outline warna grey
          ),
          child: Column(
            children: [
              gapH10,
              if (dataGlobal.dataUser?.isAffiliate == 1)
              Center(
                child: Image.network(
                  imageUrl,
                  headers: {'Authorization': token},
                  width: 200,
                  height: 200,
                  loadingBuilder: (BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressWidget(
                        value: loadingProgress
                            .expectedTotalBytes !=
                            null
                            ? loadingProgress
                            .cumulativeBytesLoaded /
                            loadingProgress
                                .expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder:
                      (context, exception, stackTrace) {
                    return Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icons/material-symbols-light_error-outline.png",
                              width: 100,
                            ),
                            Text(
                              S.of(context).failed_load_qr_code,
                            ),
                          ],
                        ));
                  },
                  // placeholderBuilder: (context) {
                  //   return const Center(
                  //     child: SizedBox(
                  //       height: 200,
                  //       width: 200,
                  //       child: CircularProgressWidget(),
                  //     ),
                  //   );
                  // },
                ),
              ),
              if (dataGlobal.dataUser?.isAffiliate == 0)
                SvgPicture.network(
                  "${ApiEndpoint.qrCode}/${dataGlobal.dataUser?.phoneNumber}",
                  headers: {'Authorization': dataGlobal.token},
                  width: 200,
                  height: 200,
                  placeholderBuilder: (context) {
                    return const SizedBox(
                      height: 200,
                      width: 200,
                      child: CircularProgressWidget(),
                    );
                  },
                ),
              // QrImageView(
              //   embeddedImage: AssetImage("images/qrcode/logoqr.png"),
              //   data: "Nama: Budi",
              //   version: QrVersions.auto,
              //   size: 300.0,
              // ),
              gapH16,
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text("Kode User Anda : KAYH2829"),
              //       gapW10,
              //       Icon(
              //         Icons.copy_sharp,
              //         size: 15,
              //       ),
              //     ]),
              if (dataGlobal.dataUser?.isAffiliate == 1)
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                    "Tunjukan QR Code Ini untuk mempermudah proses affiliasi anda."),
              ),
              gapH10,
            ],
          ),
        ),
        gapH20,
        _buildInviteCard(),
      ],
    );
  }

  Widget _buildInviteCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF4CCBF4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Undang teman anda!",
                style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: Icon(
                  showUrl ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    showUrl = !showUrl;
                  });
                },
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          if (showUrl) _buildUrlBox(),
        ],
      ),
    );
  }

  Widget _buildUrlBox() {
    String url = "https://affiliate/cool.com";

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              url,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            child: Image.asset("images/qrcode/sharee.png"),
            onTap: () {
              Share.share(url);
            },
          ),
          gapW4,
          GestureDetector(
            child: Image.asset("images/qrcode/copyy.png"),
            onTap: () {
              Clipboard.setData(ClipboardData(text: url));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("URL disalin!")),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQRScannerTab() {
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.blue, // Warna biru untuk petak deteksi
            borderRadius: 10, // Radius sudut petak
            borderLength: 30, // Panjang garis sudut petak
            borderWidth: 5, // Ketebalan garis petak
            cutOutSize: 250, // Ukuran area pemindaian QR
          ),
        ),
        gapH20,
        Positioned(left: 10, right: 10, bottom: 10, child: _buildInviteCard()),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      Navigator.pop(context, scanData.code);
    });
  }
}
