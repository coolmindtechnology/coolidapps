import 'package:flutter/material.dart';

class CardConsultant extends StatelessWidget {
  final String topic; // Teks untuk Topik
  final String topicSelected; // Teks untuk Topik yang Dipilih
  final String consultationTime; // Teks untuk Waktu Konsultasi
  final String consultationTimeSelected; // Teks untuk Waktu Konsultasi yang Dipilih
  final VoidCallback? onTap; // Fungsi opsional untuk InkWell

  const CardConsultant({
    Key? key,
    required this.topic,
    required this.topicSelected,
    required this.consultationTime,
    required this.consultationTimeSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Card Tema Dipilih
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic,
                  overflow : TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  topicSelected,
                  overflow : TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 16.0),

        // Card Waktu Konsultasi
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
                      consultationTime,
                      overflow : TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      consultationTimeSelected,
                      overflow : TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // InkWell hanya ditampilkan jika onTap tidak null
                if (onTap != null)
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: Image.asset('images/konsultasi/Icon_loop.png'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
