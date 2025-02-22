import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/apps/app_strings.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailBacaEbook extends StatefulWidget {
  const DetailBacaEbook({super.key});

  @override
  State<DetailBacaEbook> createState() => _DetailBacaEbookState();
}

class _DetailBacaEbookState extends State<DetailBacaEbook> {
  bool isDarkTheme = false;
  String editableText = Labels.loremData;
  TextSelection? selection;

  @override
  void initState() {
    super.initState();
  }

  void triger() {
    isDarkTheme = !isDarkTheme;
    setState(() {});
  }

  void navigateToEditPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotePage(initialText: editableText),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        editableText = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ProviderBook>(context);
    return Scaffold(
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkTheme ? Colors.black : primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("images/buku/arrowleft.png"),
        ),
        title: const Text(
          "Judul Buku",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              triger();
              themeProvider.toggleTheme(value);
            },
            activeColor: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.asset(
                "images/buku/img-cover-b.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                "Judul chapter",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
            Text(
              "Hal. 1 - 72",
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selection = null;
                  });
                },
                child: SelectableText(
                  editableText,
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                    backgroundColor: selection != null
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.transparent,
                  ),
                  onSelectionChanged: (TextSelection newSelection, cause) {
                    setState(() {
                      selection =
                          newSelection.baseOffset != newSelection.extentOffset
                              ? newSelection
                              : null;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToEditPage,
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class EditNotePage extends StatefulWidget {
  final String initialText;
  const EditNotePage({super.key, required this.initialText});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

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
          "Judul Buku",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.asset(
                "images/buku/img-cover-b.png",
                fit: BoxFit.cover,
              ),
            ),
            gapH16,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Tambah Note",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Judul Chapter/hal.1"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(5), // Menghilangkan border radius
                side: BorderSide(
                    color: Colors.transparent), // Menghilangkan border
              ),
              backgroundColor: primaryColor),
          onPressed: () {
            Navigator.pop(context, _controller.text);
          },
          child: const Text(
            "Tambah Note",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context, _controller.text);
      //   },
      //   child: const Icon(Icons.save),
      // ),
    );
  }
}

// class DetailBacaEbook extends StatefulWidget {
//   const DetailBacaEbook({super.key});

//   @override
//   State<DetailBacaEbook> createState() => _DetailBacaEbookState();
// }

// class _DetailBacaEbookState extends State<DetailBacaEbook> {
//   bool isDarkTheme = false;
//   @override
//   void initState() {
//     super.initState();
//   }

//   triger() {
//     isDarkTheme = !isDarkTheme;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ProviderBook>(context);
//     return Scaffold(
//       backgroundColor: isDarkTheme == true ? Colors.black : Colors.white,
//       appBar: AppBar(
//         backgroundColor: isDarkTheme == true ? Colors.black : primaryColor,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Image.asset("images/buku/arrowleft.png")),
//         title: Text(
//           "Judul Buku",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: false,
//         actions: [
//           Switch(
//             value: themeProvider.isDarkMode,
//             onChanged: (value) {
//               triger();
//               setState(() {});
//               themeProvider.toggleTheme(value);
//             },
//             activeColor: Colors.white,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         // padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             SizedBox(
//                 height: 250,
//                 width: double.infinity,
//                 child: Image.asset(
//                   "images/buku/img-cover-b.png",
//                   fit: BoxFit.cover,
//                 )),
//             gapH16,
//             Padding(
//               padding: const EdgeInsets.only(left: 15, bottom: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Judul chapter",
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color:
//                             isDarkTheme == true ? Colors.white : Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               "Hal. 1 - 72",
//               style: TextStyle(
//                   color: isDarkTheme == true ? Colors.white : Colors.black),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Text(
//                 Labels.loremData,
//                 style: TextStyle(
//                     color: isDarkTheme == true ? Colors.white : Colors.black),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
