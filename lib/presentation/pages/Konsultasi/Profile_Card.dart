import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String title;
  final String bloodType;
  final String location;
  final String time;
  final String timeRemaining;
  final Color timeColor;
  final String status;
  final Color warnastatus;
  final VoidCallback? onTap; // Tambahkan properti onTap

  ProfileCard({
    required this.imagePath,
    required this.name,
    required this.title,
    required this.bloodType,
    required this.location,
    required this.time,
    required this.timeRemaining,
    required this.timeColor,
    required this.status,
    required this.warnastatus,
    this.onTap, // Jadikan opsional
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(imagePath),
          title: Row(
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.water_drop_outlined, color: Colors.grey, size: 18),
                  SizedBox(width: 5),
                  Text(
                    'Golongan Darah $bloodType',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.pin_drop_outlined, color: Colors.grey, size: 18),
                  SizedBox(width: 5),
                  Text(
                    location,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(CupertinoIcons.clock, color: Colors.grey, size: 18),
                  SizedBox(width: 5),
                  Text(
                    time,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Icon(CupertinoIcons.forward),
          onTap: onTap, // Gunakan properti onTap
        ),
        Container(
          width: double.infinity,
          height: 20,
          decoration: BoxDecoration(
            color: warnastatus,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status,
                  style: TextStyle(color: timeColor, fontWeight: FontWeight.w500),
                ),
                Text(
                  timeRemaining,
                  style: TextStyle(color: timeColor, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
