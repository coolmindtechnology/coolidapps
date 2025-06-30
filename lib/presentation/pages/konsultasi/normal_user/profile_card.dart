import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String? imagePath;
  final String? name;
  final String? title;
  final String? bloodType;
  final String? location;
  final String? time;
  final String? timeRemaining;
  final Color? timeColor;
  final String? status;
  final Color? warnastatus;
  final VoidCallback? onTap;

  const ProfileCard({
    super.key,
    this.imagePath,
    this.name,
    this.title,
    this.bloodType,
    this.location,
    this.time,
    this.timeRemaining,
    this.timeColor,
    this.status,
    this.warnastatus,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 50, // Perbesar ukuran sesuai kebutuhan
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imagePath != null && imagePath!.isNotEmpty
                    ? NetworkImage(imagePath!)
                    : AssetImage('images/default_user.png') as ImageProvider,
                fit: BoxFit.cover, // Pastikan gambar terisi penuh dalam lingkaran
              ),
            ),
          ),
          title: Row(
            children: [
              if (name != null)
                Text(name!, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12)),
              if (title != null) SizedBox(width: 20),
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _getColorForType(title!),
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          subtitle: Column(
            children: [
              if (bloodType != null)
                Row(
                  children: [
                    Icon(Icons.water_drop_outlined,
                        color: Colors.grey, size: 18),
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
              if (location != null)
                Row(
                  children: [
                    Icon(Icons.pin_drop_outlined, color: Colors.grey, size: 18),
                    SizedBox(width: 5),
                    Text(
                      location!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              if (time != null)
                Row(
                  children: [
                    Icon(CupertinoIcons.clock, color: Colors.grey, size: 18),
                    SizedBox(width: 5),
                    Text(
                      time!,
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
          trailing: onTap != null ? Icon(CupertinoIcons.forward) : null,
          onTap: onTap,
        ),
        // Tampilkan Container hanya jika status, warnastatus, timeRemaining, dan timeColor tidak null

        if (status != null &&
            warnastatus != null &&
            timeRemaining != null &&
            timeColor != null)
          status != "false"
              ? Container(
            width: double.infinity,
            height: 20,
            decoration: BoxDecoration(
              color: warnastatus,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    status != "false" ? status! : "",
                    style: TextStyle(
                        color: timeColor, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    status != "false" ? timeRemaining! : "",
                    style: TextStyle(
                        color: timeColor, fontWeight: FontWeight.w500),
                  ),


                ],
              ),
            ),
          )
              : Container()
      ],
    );
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'emotion in':
      case 'emotion out':
      case 'emotion':
        return Colors.green;
      case 'logic in':
      case 'logic out':
      case 'logic':
        return Colors.yellow;
      case 'master':
        return Colors.black;
      case 'creative in':
      case 'creative out':
      case 'creative':
        return Colors.orange;
      case 'action in':
      case 'action out':
      case 'action':
        return Colors.red;
      default:
        return Colors.grey; // Warna default jika type tidak cocok
    }
  }
}