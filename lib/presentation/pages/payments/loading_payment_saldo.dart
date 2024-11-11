import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/screen_feature_kepribadian.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/circular_progress_widget.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPaymentSaldo extends StatefulWidget {
  const LoadingPaymentSaldo({
    super.key,
    required this.id,
    required this.onUpdate,
    this.isMultiple = false,
  });
  final String id;
  final Function() onUpdate;
  final bool isMultiple;

  @override
  State<LoadingPaymentSaldo> createState() => _LoadingPaymentSaldoState();
}

class _LoadingPaymentSaldoState extends State<LoadingPaymentSaldo> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ProviderProfiling.udpatePaymentProfiling(context, widget.id),
      child: Consumer<ProviderProfiling>(builder: (context, provider, child) {
        if (provider.isPayProfilingWithSaldo) {
          return const Scaffold(
            body: Center(
              child: CircularProgressWidget(),
            ),
          );
        }
        if (provider.resUpdateTransactionProfiling?.success == true) {
          return _buildSuccessWidget(
              context, widget.onUpdate, widget.isMultiple);
        } else {
          return _buildFailedWidget(
              context, widget.onUpdate, widget.isMultiple);
        }
      }),
    );
  }

  Widget _buildSuccessWidget(
      BuildContext context, Function() onUpdate, bool isMultiple) {
    onUpdate();
    Future.delayed(const Duration(seconds: 3), () {
      // Nav.replace(const ScreenFeatureKepribadian());
      // Nav.toAll(const NavMenuScreen());
      Nav.back();
      if (isMultiple) {
        Nav.back();
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                "assets/icons/success.png",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S.of(context).payment_with_cool_balance_was_successful,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: greenColor),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text("Halaman ini akan menutup secara otomatis")
          ],
        ),
      ),
    );
  }

  Widget _buildFailedWidget(
      BuildContext context, Function() onUpdate, bool isMultiple) {
    onUpdate();
    Future.delayed(const Duration(seconds: 3), () {
      // Nav.replace(const ScreenFeatureKepribadian());
      // Nav.toAll(const NavMenuScreen());
      Nav.back();
      Nav.back();
      if (isMultiple) {
        Nav.back();
      }
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Icon(
                Icons.cancel,
                color: Colors.red,
                size: 110,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Pembayaran dengan saldo gagal, silahkan coba lagi",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text("Halaman ini akan menutup secara otomatis")
          ],
        ),
      ),
    );
  }
}
