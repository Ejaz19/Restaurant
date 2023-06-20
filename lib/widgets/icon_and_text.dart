import 'package:res/utils/dimensions.dart';

import 'package:flutter/material.dart';
import 'package:res/widgets/small_text.dart';
class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;
  final double size;
  const IconAndText({super.key, required this.icon, 
  required this.text,
    this.color = Colors.black,
   required this.iconColor, 
   required this.size
   });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,size: Dimensions.iconSize24,),
        SizedBox(width: 1,),
        SmallText(text: text,color: color,),
      ],
    );
  }
}