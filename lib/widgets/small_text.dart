import 'package:flutter/material.dart';
// ignore: must_be_immutable
class SmallText extends StatelessWidget {
   Color? color;
  final String text;
  double size;
  double height;
 // TextOverflow overFlow;
    SmallText({super.key,
   required this.text,
   this.height = 1.2,
   this.size = 12,
   this.color = const Color(0xFFccc7c5),
   //this.overFlow = TextOverflow.ellipsis,
   });

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        //maxLines: 1,
        //overflow: overFlow,
        style: TextStyle(
          color: color,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
    );
  }
}