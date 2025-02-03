import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class ListProfilingContainer extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? leading;

  const ListProfilingContainer({
    super.key,
    this.title,
    this.subtitle,
    this.onTap,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 80,
        decoration: BoxDecoration(
          color: BlueColor, // Warna biru
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) leading!, // Menampilkan leading jika ada
            if (title != null)
              Text(
                _formatTitle(title!),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            if (subtitle != null) const SizedBox(height: 10),
            if (subtitle != null)
              Text(
                subtitle!.toUpperCase(),
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk memotong title jika lebih dari 5 huruf
  String _formatTitle(String title) {
    if (title.length > 7) {
      return '${title.toUpperCase().substring(0, 8)}...';
    }
    return title;
  }
}

// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:flutter/material.dart';

// class ListProfilingContainer extends StatelessWidget {
//   final String? title;
//   final String? subtitle;
//   final VoidCallback? onTap;
//   final Widget? leading;

//   const ListProfilingContainer({
//     super.key,
//     this.title,
//     this.subtitle,
//     this.onTap,
//     this.leading, // Menambahkan parameter leading
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: 80,
//         height: 80,
//         decoration: BoxDecoration(
//           color: BlueColor, // Warna biru
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (leading != null) leading!, // Menampilkan leading jika ada
//             if (title != null)
//               Text(title!,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis),
//             if (subtitle != null) const SizedBox(height: 10),
//             if (subtitle != null)
//               Text(subtitle!,
//                   style: const TextStyle(color: Colors.white70, fontSize: 12),
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis),
//           ],
//         ),
//       ),
//     );
//   }
// }
