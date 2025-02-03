import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurhatConsultantCrad extends StatelessWidget {
  final String? imagePath;
  final String? name;
  final String? title;
  final String? subtitle;
  final String? timeRemaining;
  final VoidCallback? onTap;

  CurhatConsultantCrad({
    this.imagePath,
    this.name,
    this.title,
    this.subtitle,
    this.timeRemaining,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          radius: 30, // Ukuran lingkaran
          backgroundColor: Colors.orange, // Warna lingkaran oranye
          child: imagePath != null
              ? ClipOval(
            child: Image.asset(
              imagePath!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          )
              : Icon(Icons.person, color: Colors.white), // Ikon default
        ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              name ?? 'Nama tidak tersedia',
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(width: 10),
          Text(
            title ?? 'Judul tidak tersedia',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.orange,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),

      subtitle: Text(subtitle ?? 'Informasi tidak tersedia',overflow: TextOverflow.ellipsis,maxLines: 3,),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // Membatasi ukuran trailing
        children: [
          Text(timeRemaining ?? '0',style: TextStyle(fontSize: 10),),
          Icon(CupertinoIcons.forward),
        ],
      ),
      onTap: onTap,
    );
  }
}
