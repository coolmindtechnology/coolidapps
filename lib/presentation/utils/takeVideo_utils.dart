// ignore_for_file: file_names

import 'package:cool_app/presentation/utils/nav_utils.dart';
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
                    // Nav.back();
                  }
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
                  if (kDebugMode) {
                    print("Gallery selected");
                  }
                  file = await _compressVideo(ImageSource.gallery);
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
        quality: VideoQuality.MediumQuality,
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

/// Compresses a video file at the given `path` using the `VideoCompress.compressVideo`
/// method. If the compression is successful, returns an `XFile` object representing
/// the compressed video. Otherwise, returns `null`.
///
/// - Parameter path: The path of the video file to be compressed.
/// - Returns: An `XFile` object representing the compressed video, or `null` if
///   the compression fails.
Future<XFile?> _compressVideoCamera(String path) async {
  MediaInfo? info = await VideoCompress.compressVideo(
    path,
    quality: VideoQuality.MediumQuality,
  );
  if (info != null) {
    return XFile(info.path!);
  } else {
    // Handle compression failure
    return null;
  }
}
