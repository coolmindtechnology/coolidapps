import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoaderView extends StatelessWidget {
  final Widget child;
  final bool showLoader;

  const LoaderView({super.key, required this.child, required this.showLoader});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showLoader,
      progressIndicator: const SpinKitFadingCircle(
        color: Colors.red,
        size: 50.0,
      ),
      child: child,
    );
  }
}
