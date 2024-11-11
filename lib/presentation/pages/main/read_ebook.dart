import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/networks/endpoint/api_endpoint.dart';

class ReadEbook extends StatefulWidget {
  final int? id;
  const ReadEbook({
    this.id,
    super.key,
  });

  @override
  State<ReadEbook> createState() => _ReadEbookState();
}

class _ReadEbookState extends State<ReadEbook> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderBook.initDetailEbook(context, id: widget.id);
      },
      child: Consumer<ProviderBook>(
          builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              value.dataEbook?.title ?? "",
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  value.dataEbook?.image == null
                      ? Container()
                      : Image.network(
                          "${ApiEndpoint.imageUrl}${value.dataEbook?.image ?? ""}",
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.fitWidth,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    value.dataEbook?.content ?? "",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                  Text("${value.dataEbook?.filePath}")
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
