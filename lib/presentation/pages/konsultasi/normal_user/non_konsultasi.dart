import 'package:coolappflutter/generated/l10n.dart';
import 'package:flutter/material.dart';

class NoneKonsul extends StatelessWidget {
  const NoneKonsul({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/konsultasi/none_list.png'),
          SizedBox(height: 10,),
          Text(S.of(context).No_sessions,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 20),),
          SizedBox(height: 10,),
          Text(S.of(context).Start_consulting_now,style: TextStyle(color: Colors.grey),)

        ],
      ),
    );
  }
}
