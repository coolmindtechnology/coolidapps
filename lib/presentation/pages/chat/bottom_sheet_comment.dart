import 'package:coolappflutter/data/models/data_post.dart';
import 'package:coolappflutter/data/provider/provider_cool_chat.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../theme/color_utils.dart';
import '../../utils/circular_progress_widget.dart';

class BottomSheetComment extends StatefulWidget {
  final DataPost? data;
  const BottomSheetComment(this.data, {super.key});

  @override
  State<BottomSheetComment> createState() => _BottomSheetCommentState();
}

class _BottomSheetCommentState extends State<BottomSheetComment> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderCoolChat();
      },
      child: Consumer<ProviderCoolChat>(
        builder: (BuildContext context, value, Widget? child) =>
            SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: greyColor.withOpacity(0.2),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: value.etComment,
                  decoration: InputDecoration(
                      hintText: S.of(context).what_to_discuss,
                      hintStyle: TextStyle(color: greyColor.withOpacity(0.5)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "images/chat/vn.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          "images/chat/video.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          "images/chat/gambar.png",
                          width: 24,
                          height: 24,
                        )
                      ],
                    ),
                    value.isComment
                        ? CircularProgressWidget(
                            color: primaryColor,
                          )
                        : MaterialButton(
                            elevation: 0,
                            minWidth: 75,
                            height: 28,
                            color: primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {
                              value.commentPost(widget.data?.id ?? 0,
                                  value.etComment.text, 1);
                              //     onUpdate: () {
                              //   Nav.back();
                              //   // value.getListComment(
                              //   //     data.id.toString());
                              //   // value.getListPost();
                              // });
                            },
                            child: Text(S.of(context).posting),
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
