// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Ganti library PDF

class PdfViewer extends StatefulWidget {
  final String? url;
  final String? file;

  const PdfViewer(this.url, this.file, {super.key});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool _isLoading = true;
  String title = "PDF Reader";
  final GlobalKey<SfPdfViewerState> _pdfViewerKey =
      GlobalKey<SfPdfViewerState>();

  Future<void> getPdf() async {
    title = basename(widget.url!);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    if (kDebugMode) {
      print("link ${widget.url}");
    }
    getPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.file ?? "",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SfPdfViewer.network(
                    widget.url!,
                    key: _pdfViewerKey,
                  ),
                ),
                PageInputNumber(
                  pdfViewerKey: _pdfViewerKey,
                ),
              ],
            ),
    );
  }
}

class PageInputNumber extends StatelessWidget {
  final GlobalKey<SfPdfViewerState> pdfViewerKey;

  const PageInputNumber({super.key, required this.pdfViewerKey});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Go to page:'),
        const SizedBox(width: 10),
        SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            String inputText = controller.text.trim();
            if (inputText.isNotEmpty) {
              // int pageNumber = int.tryParse(inputText) ?? 1;
              // pageNumber = pageNumber.clamp(1, pdfViewerKey.currentState?.pageCount ?? 0);
              // pdfViewerKey.currentState?.jumpToPage(pageNumber);
              // controller.clear();
            }
          },
          child: const Text('Go'),
        ),
      ],
    );
  }
}

// // ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

// // import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
// import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';

// class PdfViewer extends StatefulWidget {
//   final String? url;
//   final String? file;

//   const PdfViewer(this.url, this.file, {Key? key}) : super(key: key);

//   @override
//   _PdfViewerState createState() => _PdfViewerState();
// }

// class _PdfViewerState extends State<PdfViewer> {
//   bool _isLoading = true;
//   PDFDocument? doc;
//   String title = "PDF Reader";
//   int currentPage = 0;
//   PageController pageController = PageController();

//   Future<void> getPdf() async {
//     title = basename(widget.url!);
//     doc = await PDFDocument.fromURL(widget.url!);

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   void onPageChanged(int index) {
//     setState(() {
//       currentPage = index;
//     });
//   }

//   @override
//   void initState() {
//     if (kDebugMode) {
//       print("link ${widget.url}");
//     }
//     getPdf();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.file ?? "",
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Center(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 children: [
//                   Expanded(
//                       child: PDFViewer(
//                     document: doc!,
//                     controller: pageController,
//                   )),
//                   PageInputNumber(
//                     currentPage: currentPage + 1, // Display 1-based page number
//                     totalPages: doc?.count ?? 0,
//                     onPageChanged: onPageChanged,
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

// class PageInputNumber extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final Function(int) onPageChanged;

//   const PageInputNumber({
//     super.key,
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController controller = TextEditingController();

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text('Go to page:'),
//         const SizedBox(width: 10),
//         SizedBox(
//           width: 80,
//           child: TextField(
//             controller: controller,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           onPressed: () {
//             String inputText = controller.text.trim();
//             if (inputText.isNotEmpty) {
//               int pageNumber = int.tryParse(inputText) ??
//                   1; // Default to page 1 if parsing fails
//               pageNumber = pageNumber.clamp(
//                   1, totalPages); // Ensure page number is within valid range
//               onPageChanged(
//                   pageNumber - 1); // Notify parent widget (zero-based index)
//               controller.clear(); // Clear input field after navigation
//             }
//           },
//           child: const Text('Go'),
//         ),
//       ],
//     );
//   }
// }
