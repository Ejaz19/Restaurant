import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
//import 'package:res/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color IconColor;
  final double size;
  final double iconSize;

  const AppIcon({super.key, required this.icon, 
   this.backgroundColor = const Color(0xFFfcf4e4), 
   this.IconColor = const Color(0xFF756d54), 
   this.size =40,  this.iconSize = 16,
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor,
      ),
      child: Icon(icon,
      color: IconColor,
      size: iconSize,
      )
    );
  }
}