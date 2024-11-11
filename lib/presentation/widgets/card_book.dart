import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/data/response/res_list_ebook.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/read_book.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';

class CardBook extends StatefulWidget {
  const CardBook(
      {super.key, required this.data, required this.provider, this.onUpdate});

  final DataBook data;
  final ProviderBook provider;
  final Function? onUpdate;

  @override
  State<CardBook> createState() => _CardBookState();
}

class _CardBookState extends State<CardBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: greyColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                      width: 70,
                      height: 90,
                      child: Image.network("${widget.data.imagePath ?? ""}")),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.title ?? "",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.data.summary.toString() ?? "",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 3,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
          (widget.data.isPremium.toString() == "0") ||
                  (widget.data.isPremium.toString() == "1" &&
                      widget.data.logEbook != null &&
                      widget.data.logEbook?.status.toString() == "1")
              ? ButtonPrimary(
                  S.of(context).read,
                  onPress: () async {
                    Nav.to(ReadBook(
                        "${widget.data.filePath}", "${widget.data.title}"));
                  },
                  textStyle: const TextStyle(fontWeight: FontWeight.w300),
                  textSize: 12,
                  negativeColor: true,
                  border: 1,
                  elevation: 0,
                  radius: 10,
                )
              : GestureDetector(
                  onTap: () {
                    NotificationUtils.showSimpleDialog2(context,
                        "${S.of(context).pay_to_see_more}, ${S.of(context).just} Rp ${widget.data.price ?? ""}",
                        textButton1: S.of(context).yes_continue,
                        textButton2: S.of(context).no, onPress2: () {
                      Nav.back();
                    }, onPress1: () async {
                      Nav.back();
                      await widget.provider
                          .createLogEbook(context, widget.data.id ?? 0)
                          .then((_) {
                        widget.provider.paymentEbook(
                            context,
                            widget.data.id ?? 0,
                            widget.data.price ?? "",
                            "Ebook - ${widget.data.title}", onUpdate: () {
                          widget.onUpdate!();
                        });
                      });
                    }, colorButon1: primaryColor, colorButton2: Colors.white);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: ImageIcon(
                      AssetImage(
                        "images/brain/Lock.png",
                      ),
                      color: Color(0XFFF2994A),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
