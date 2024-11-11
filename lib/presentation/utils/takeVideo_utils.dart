import 'dart:async';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:permission_handler/permission_handler.dart';
import '../pages/chat/take_video_and12.dart';

XFile? fileAnd12;
String? android12;

Future<XFile?> takeVideo(BuildContext context, {String? androidVersion}) async {
  XFile? file;
  await showModalBottomSheet(
    context: context,
    builder: (context) => BottomSheet(
      onClosing: () {},
      builder: (context) => Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: TextButton.icon(
                onPressed: () async {
                  // Tampilkan dialog sedang upload
                  _showUploadingDialog(context);

                  if (kDebugMode) {
                    print("Android version: $androidVersion");
                  }
                  android12 = androidVersion;
                  if (androidVersion == "12") {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CameraExample(
                          onUpdate: (XFile data) async {
                            file = data;
                            if (file?.path != null) {
                              file = await _compressVideoCamera(file!.path);
                            }
                            if (kDebugMode) {
                              print("dataaa $file");
                            }
                          },
                        ),
                      ),
                    );
                  } else {
                    file = await _compressVideo(ImageSource.camera);
                  }

                  // Selesaikan upload dan hilangkan dialog
                  Navigator.pop(context); // Menghilangkan dialog upload
                  Nav.back();
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: TextButton.icon(
                onPressed: () async {
                  // Tampilkan dialog sedang upload
                  _showUploadingDialog(context);

                  if (kDebugMode) {
                    print("Gallery selected");
                  }
                  file = await _compressVideo(ImageSource.gallery);

                  // Selesaikan upload dan hilangkan dialog
                  Navigator.pop(context); // Menghilangkan dialog upload
                  Nav.back();
                },
                icon: const Icon(Icons.photo),
                label: const Text("Gallery"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  return file;
}

Future<XFile?> _compressVideo(ImageSource source) async {
  final status = await Permission.camera.request();
  final micStatus = await Permission.microphone.request();

  if (status.isGranted && micStatus.isGranted) {
    XFile? pickedFile = await ImagePicker().pickVideo(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (pickedFile != null) {
      MediaInfo? info = await VideoCompress.compressVideo(
        pickedFile.path,
        quality: VideoQuality.LowQuality,
      );
      if (info != null) {
        return XFile(info.path!);
      } else {
        // Handle compression failure
        return null;
      }
    } else {
      return null;
    }
  } else {
    // Handle permission denied
    if (kDebugMode) {
      print('Camera or Microphone permission denied');
    }
    return null;
  }
}

Future<XFile?> _compressVideoCamera(String path) async {
  MediaInfo? info = await VideoCompress.compressVideo(
    path,
    quality: VideoQuality.LowQuality,
  );
  if (info != null) {
    return XFile(info.path!);
  } else {
    // Handle compression failure
    return null;
  }
}

/// Fungsi untuk menampilkan dialog sedang proses upload
void _showUploadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Tidak bisa di dismiss dengan klik di luar
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false, // Disable tombol back
        child: AlertDialog(
          title: Text(S.of(context).uploading_in_progress),
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(S.of(context).please_wait),
            ],
          ),
        ),
      );
    },
  );
}
