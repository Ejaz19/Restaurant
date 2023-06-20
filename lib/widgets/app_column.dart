import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';

import 'big_text.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'icon_and_text.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, 
  required this.text});

  @override
  Widget build(BuildContext context) {

    return Column(
              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: text, ),
                  SizedBox(height: Dimensions.height15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Wrap(
                        children: List.generate(5, (index) => Icon(Icons.star,
                        color: AppColors.mainColor,size: 15,
                        )),
                      ),
                      SizedBox(width: Dimensions.width5,),
                      SmallText(text: "4.5"),
                      SizedBox(width: Dimensions.width10,),
                      SmallText(text: "1278"),
                      SizedBox(width: Dimensions.width5,),
                      SmallText(text: "Comments"),
                    ],
                  ),
                 SizedBox(height: Dimensions.height10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconAndText(icon: Icons.circle_sharp,
                    size: Dimensions.iconSize24,
                     text: "Normal", 
                     iconColor: AppColors.iconColor1),
                     SizedBox(width: Dimensions.width5,),
                     IconAndText(icon: Icons.location_on,
                     size: Dimensions.iconSize24,
                     text: "1.7km", 
                     iconColor: AppColors.mainColor),
                     SizedBox(width: Dimensions.width5),
                     IconAndText(icon: Icons.access_alarms_rounded,
                     size: Dimensions.iconSize24,
                     text: "32 min", 
                     iconColor: AppColors.iconColor1),
    
                  ],
                ),
                
                ],);
  }
}