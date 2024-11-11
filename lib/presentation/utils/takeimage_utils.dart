import 'dart:io';
import 'dart:typed_data';

import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img; // Add this line

// Asynchronously takes an image using the camera or gallery, compresses it, and returns the selected image as an XFile.
Future<XFile?> takeImage(BuildContext context) async {
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
                    XFile? pickedImage =
                        await _pickAndCompressImage(ImageSource.camera);
                    Nav.back();
                    if (pickedImage != null) {
                      file = pickedImage;
                    }
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera")),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: TextButton.icon(
                  onPressed: () async {
                    XFile? pickedImage =
                        await _pickAndCompressImage(ImageSource.gallery);
                    Nav.back();
                    if (pickedImage != null) {
                      file = pickedImage;
                    }
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text("Galery")),
            )
          ],
        ),
      ),
    ),
  );
  return file;
}

// Picks an image from the specified source, compresses it, and returns the compressed image as an XFile.
Future<XFile?> _pickAndCompressImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? pickedFile = await picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 5); // Adjust source as needed

  if (pickedFile != null) {
    Uint8List? imageBytes = await pickedFile.readAsBytes();
    img.Image? originalImage = img.decodeImage(imageBytes);
    img.Image compressedImage = img.copyResize(originalImage!,
        width: 500); // Adjust compression as needed

    var compressedFile =
        await File('${pickedFile.path}_compressed.jpg').create();
    compressedFile.writeAsBytesSync(img.encodeJpg(compressedImage));

    return XFile(compressedFile.path);
  } else {
    return null;
  }
}
