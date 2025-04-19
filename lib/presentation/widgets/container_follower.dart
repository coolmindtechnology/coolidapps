import 'package:flutter/material.dart';

// Class untuk container follower
class ContainerFollower extends StatelessWidget {
  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;
  final String title3;
  final String subtitle3;

  const ContainerFollower({
    Key? key,
    required this.title1,
    required this.subtitle1,
    required this.title2,
    required this.subtitle2,
    required this.title3,
    required this.subtitle3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Latar belakang putih
        borderRadius: BorderRadius.circular(8), // Sudut container dibulatkan
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Bayangan lembut
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 5),  //
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(subtitle1),
                ],
              ),
            ],
          ),
          Container(
            height: 50,
            width: 1,
            color: Colors.grey,
          ),

          // Row kedua
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(subtitle2),
                ],
              ),
            ],
          ),
          Container(
            height: 50,
            width: 1,
            color: Colors.grey,
          ),

          // Row ketiga
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title3,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(subtitle3),
                ],
              ),
            ],
          ),
        ],
      )
    );
  }
}
