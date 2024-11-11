// ignore_for_file: deprecated_member_use

import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/main.dart';
import 'package:coolappflutter/presentation/pages/auth/login_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';

class NotificationUtils {
  /// Shows a snackbar with the given [message] at the bottom of the screen.
  ///
  /// The [message] parameter is the text to be displayed in the snackbar.
  ///
  /// The [backgroundColor] parameter is the background color of the snackbar.
  /// If not provided, the default background color is used.
  ///
  /// The [action] parameter is an optional action button to be displayed on the snackbar.
  ///
  /// This function does not return anything.
  static void showSnackbar(String message,
      {Color? backgroundColor, SnackBarAction? action}) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        action: action,
        content: Text(message),
      ),
    );
  }

  // Removes the current snackbar being displayed on the screen.
  static void removeSnackbar() {
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }

  // Shows a snackbar at the top of the screen with the given [value] in [context].
  //
  // The [onDismissed] parameter is a callback that will be invoked when the snackbar is dismissed.
  // This function is asynchronous and does not return anything.
  static Future<void> showInSnackBarOnTop(BuildContext context, String value,
      {Function()? onDismissed}) async {
    var duration = const Duration(seconds: 2);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 20,
          left: 20),
    ));
    await Future.delayed(duration, () {
      if (onDismissed != null) onDismissed();
    });
  }

  // Shows a simple dialog with the provided [message] and [widget].
  // The [onPress] function is triggered when the dialog button is pressed.
  // [textOnButton] is the text displayed on the dialog button.
  static Future<void> showSimpleDialog(
    BuildContext context,
    void Function() onPress, {
    String? message,
    Widget? widget,
    String? textOnButton,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: message != null
              ? Center(
                  child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ))
              : const SizedBox(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: widget ?? Container(),
          scrollable: true,
          actions: <Widget>[
            SizedBox(
              height: 54,
              child: ButtonPrimary(
                textOnButton ?? S.of(context).yes,
                expand: true,
                radius: 8,
                elevation: 0.0,
                onPress: onPress,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a simple dialog with the provided [message] and optional [content].
  ///
  /// The dialog displays two buttons: [textButton1] and [textButton2]. The
  /// [onPress1] and [onPress2] functions are triggered when the respective
  /// buttons are pressed.
  ///
  /// The [isLoading] parameter indicates whether the buttons should be
  /// disabled during a loading state. If [isLoading] is true, the buttons
  /// will be disabled.
  ///
  /// The [colorButon1] and [colorButton2] parameters allow customization of
  /// the button colors. If not provided, default colors will be used.
  ///
  /// The dialog has a rounded rectangular shape with a [message] displayed
  /// in the center. The [content] widget is displayed below the message.
  ///
  /// This function does not return anything.
  ///
  /// Example usage:
  /// ```dart
  /// showSimpleDialog2(
  ///   context,
  ///   'Are you sure?',
  ///   content: Text('This is the content
  static Future<void> showSimpleDialog2(BuildContext context, String message,
      {Widget? content,
      void Function()? onPress1,
      void Function()? onPress2,
      String? textButton1,
      String? textButton2,
      Color? colorButon1,
      Color? colorButton2,
      bool isLoading = false}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Center(
              child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            children: [
              content ?? Container(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ButtonPrimary(
                        textButton2 ?? 'Yes',
                        expand: false,
                        radius: 8,
                        onPress: isLoading ? null : onPress2,
                        color: colorButon1,
                        negativeColor: true,
                        border: 1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ButtonPrimary(
                        textButton1 ?? 'Cancel',
                        expand: false,
                        radius: 8,
                        border: 3,
                        // borderColor: dataGlobal.color.semanticError,
                        textColor: whiteColor,
                        borderColor: primaryColor,
                        onPress: isLoading ? null : onPress1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          scrollable: true,
        ),
      ),
    );
  }

  static Future<void> showSimpleDialogAudio(
      BuildContext context, String message,
      {Widget? content,
      void Function()? onPress1,
      void Function()? onPress2,
      String? textButton1,
      String? textButton2,
      Color? colorButon1,
      Color? colorButton2,
      bool isLoading = false}) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Center(
              child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            children: [
              content ?? Container(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ButtonPrimary(
                        textButton2 ?? 'Yes',
                        expand: false,
                        radius: 8,
                        onPress: isLoading ? null : onPress2,
                        color: colorButon1,
                        negativeColor: true,
                        border: 1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ButtonPrimary(
                        textButton1 ?? 'Cancel',
                        expand: false,
                        radius: 8,
                        border: 3,
                        // borderColor: dataGlobal.color.semanticError,
                        textColor: whiteColor,
                        borderColor: primaryColor,
                        onPress: isLoading ? null : onPress1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          scrollable: true,
        ),
      ),
    );
  }

  Future showBlockableDialog(
      BuildContext context, String title, String message, bool block,
      {String? message2,
      String? text,
      VoidCallback? onOk,
      String? text2,
      VoidCallback? onOk2}) {
    return showDialog(
      context: context,
      barrierDismissible: !block,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return !block;
        },
        child: BlockableDialog(
          title: title,
          message: message,
          message2: message2,
          text: text,
          text2: text2,
          onOk: onOk,
          onOk2: onOk2,
        ),
      ),
    );
  }

  // Shows an error dialog with the provided [widget] and optional [textButton].
  static Future<void> showDialogError(
      BuildContext context, void Function() onPress,
      {Widget? widget, String? textButton}) async {
    await showDialog(
      context: context,
      barrierDismissible:
          false, // Memastikan dialog tidak dapat ditutup dengan mengklik di luar
      builder: (context) => WillPopScope(
        onWillPop: () async => false, // Menonaktifkan tombol back
        child: AlertDialog(
          title: Center(
            child: Image.asset(
              "assets/icons/material-symbols-light_error-outline.png",
              width: 50,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: widget ?? Container(),
          scrollable: true,
          actions: <Widget>[
            SizedBox(
              height: 54,
              child: ButtonPrimary(
                textButton ?? 'Ok',
                expand: true,
                radius: 10,
                onPress: onPress,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a dialog with a success message and an optional widget.
  ///
  /// The [context] parameter is the BuildContext of the widget that is
  /// displaying the dialog.
  ///
  /// The [onPress] parameter is a callback function that is triggered when
  /// the dialog's action button is pressed.
  ///
  /// The [widget] parameter is an optional widget that can be displayed
  /// inside the dialog's content.
  ///
  /// The [textButton] parameter is the text that will be displayed on the
  /// dialog's action button. If not provided, the default text is 'Ok'.
  ///
  /// This function does not return anything.
  ///
  /// Example usage:
  /// ```dart
  /// showDialogSuccess(
  ///   context,
  ///   () {
  ///     // Handle onPress logic here
  ///   },
  ///   widget: Text('Success message'),
  ///   textButton: 'Submit',
  /// );
  /// //edit 7 nov
  static Future<void> showDialogSuccessOtp(
      BuildContext context, void Function() onPress,
      {Widget? widget, String? textButton}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Center(
              child: Image.asset(
            "assets/icons/verify.png",
            width: 50,
          )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: widget ?? Container(),
          scrollable: true,
          actions: <Widget>[
            SizedBox(
              height: 54,
              child: ButtonPrimary(
                textButton ?? 'Ok',
                expand: true,
                radius: 10,
                onPress: () {
                  Nav.toAll(const LoginScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> showDialogSuccess(
      BuildContext context, void Function() onPress,
      {Widget? widget, String? textButton}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Center(
              child: Image.asset(
            "assets/icons/verify.png",
            width: 50,
          )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: widget ?? Container(),
          scrollable: true,
          actions: <Widget>[
            SizedBox(
              height: 54,
              child: ButtonPrimary(
                textButton ?? 'Ok',
                expand: true,
                radius: 10,
                onPress: onPress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlockableDialog extends StatefulWidget {
  final String title;
  final String? message;
  final String? message2;
  final String? text;
  final String? text2;
  final VoidCallback? onOk;
  final VoidCallback? onOk2;

  const BlockableDialog({
    super.key,
    required this.title,
    required this.message,
    this.message2,
    required this.text,
    required this.text2,
    required this.onOk,
    required this.onOk2,
  });

  @override
  State<BlockableDialog> createState() => _BlockableDialogState();
}

class _BlockableDialogState extends State<BlockableDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: Text(widget.title),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.message != null) ...[
            Text(widget.message!),
            if (widget.message2 != null) ...[
              const SizedBox(height: 12),
              Text(widget.message2!),
            ],
            const SizedBox(height: 24),
          ],
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                widget.onOk != null
                    ? Expanded(
                        child: ButtonPrimary(
                          widget.text ?? 'OK',
                          expand: false,
                          onPress: widget.onOk,
                          negativeColor: true,
                          elevation: 0,
                          radius: 50,
                          border: 1,
                        ),
                      )
                    : const SizedBox(),
                widget.onOk2 != null
                    ? const SizedBox(width: 8)
                    : const SizedBox(),
                widget.onOk2 != null
                    ? Expanded(
                        child: ButtonPrimary(
                          widget.text2 ?? 'OK2',
                          expand: false,
                          radius: 50,
                          onPress: widget.onOk2,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
