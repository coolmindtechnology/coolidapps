import 'package:coolappflutter/generated/l10n.dart';
import 'package:flutter/material.dart';

class CardCurhat extends StatelessWidget {
  final String CurhatTimeSelected; // Teks untuk Waktu Konsultasi yang Dipilih
  final String? type; // Menentukan jenis tampilan (curhat atau konsultasi)
  final VoidCallback? onTap; // Fungsi opsional untuk InkWell

  const CardCurhat({
    Key? key,
    required this.CurhatTimeSelected,
    this.type,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menentukan teks berdasarkan nilai type
    String titleText;
    if (type == "consultation") {
      titleText = S.of(context).Consultation_time;
    } else {
      titleText = S.of(context).Confiding_Time;
    }

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      CurhatTimeSelected,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                if (onTap != null)
                  InkWell(
                    onTap: onTap,
                    child: Image.asset('images/konsultasi/Icon_loop.png'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
