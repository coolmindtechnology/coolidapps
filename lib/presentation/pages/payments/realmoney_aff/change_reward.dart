import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/payments/componen/rekening_widget.dart';
import 'package:coolappflutter/presentation/pages/payments/componen/warning_pop.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/material.dart';

class ChangeReward extends StatefulWidget {
  const ChangeReward({super.key});

  @override
  State<ChangeReward> createState() => _ChangeRewardState();
}

class _ChangeRewardState extends State<ChangeReward> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Change Reward', style: TextStyle(color: whiteColor)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20 ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryColor)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Real Money dimiliki "),
                    Text('2.500 = Rp250.000')
                  ],
                ),
              ),
            ),
            gapH20,
            SizedBox(
              height: 200, // Menentukan tinggi Stack
              width: double.infinity, // Menentukan lebar Stack
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0, // Pastikan lebar mengikuti parent
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Real Money',style: TextStyle(color: DarkYellow,fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/konsultasi/icon_realmoney.png'),
                                gapW10,
                                Text('Min. 1000',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0, // Pastikan lebar mengikuti parent
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jumlah Rupiah',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/fluent_money-16-filled.png'),
                                gapW10,
                                Text('Min. 1000',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80, // Posisikan gambar lebih ke tengah
                    child: Image.asset(
                      'images/IcEquals.png', // Periksa apakah path benar
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            gapH20,
            RekeningInfoWidget(
              nama: 'Fadlan Zholifunnas Soemarta',
              tanggal: '12/09/2024',
              namaBank: 'Bank Central Asia',
              nomorRekening: '0918373103284210',
            ),
            Spacer(),
            GlobalButton(onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: WarningAffPop(),
                  );
                },
              );
      }, color: primaryColor, text: S.of(context).next)
          ],
        ),
      ),
    );
  }
}
