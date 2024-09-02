import 'package:cool_app/data/data_global.dart';
import 'package:cool_app/data/networks/endpoint/api_endpoint.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenQr extends StatefulWidget {
  const ScreenQr({super.key});

  @override
  State<ScreenQr> createState() => _ScreenQrState();
}

class _ScreenQrState extends State<ScreenQr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.of(context).qr_code,
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
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
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                S.of(context).show_qr_code,
                style:
                    TextStyle(fontSize: 14, color: greyColor.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
