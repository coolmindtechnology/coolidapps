// import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/response/profiling/res_list_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/dialog_download.dart';
import 'package:coolappflutter/presentation/pages/profiling/results/pdf_download.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateScreen extends StatefulWidget {
  final DataProfiling? data;
  final String? shareCode;
  const CertificateScreen({super.key, this.data, this.shareCode});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  bool _isLoading = true;
  PDFDocument? doc;

  Future<void> getPdf() async {
    doc = await PDFDocument.fromURL(
        ApiEndpoint.sertifikatProfiling(widget.data?.idLogResult),
        headers: {"Authorization": dataGlobal.token});
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderProfiling();
      },
      child: Consumer<ProviderProfiling>(builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).certificate,
              style: TextStyle(color: whiteColor),
            ),
            actions: [
              InkWell(
                child: Image.asset(
                  "assets/icons/upload.png",
                  width: 24,
                  color: whiteColor,
                ),
                onTap: () {
                  value.shareCertificate(context, widget.shareCode ?? "");
                  // Provider.of<ProviderProfiling>(context, listen: false)
                  //     .shareCertificate(context, widget.shareCode ?? "");
                },
              ),
              const SizedBox(
                width: 24,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Center(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 200, child: PDFViewer(document: doc!))),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 54,
                  child: ButtonPrimary(
                    S.of(context).download,
                    onPress: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          isDismissible: false,
                          context: context,
                          builder: (context) {
                            return DownloadProgressDialog(
                                url: ApiEndpoint.donwnloadCertificatrPdf(
                                    widget.data?.idLogResult ?? ""),
                                name:
                                    "${widget.data?.profilingName}_CoolProfiling_Certificate.pdf");
                          });
                    },
                    expand: true,
                    radius: 10,
                    imageLeft: Row(
                      children: [
                        Image.asset(
                          "assets/icons/download.png",
                          width: 24,
                          color: whiteColor,
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
