import 'package:flutter/material.dart';
import 'package:res/utils/dimensions.dart';
import 'package:res/widgets/big_text.dart';
import 'food_page_body.dart';
import 'package:res/widgets/small_text.dart';

import 'package:res/utils/colors.dart';
class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  
  @override
  Widget build(BuildContext context) {
    //print("height of this device is"+MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Column(
        children: [
          //header
          Container(
            margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                   children: [
                    BigText(text: "Unites States",color: AppColors.mainColor,size: 30,),
                    Row(
                      children: [
                        SmallText(text: "Las Vegas",color: Colors.black54,),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    )
                   ],
                ),
                Container(
                 
                  width: Dimensions.width45,
                  height: Dimensions.height45,
                  child: Icon(Icons.search,color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                ),
              ],
              
            ),
          ),
          //body
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          ),),
        ],
      ),
    );
  }
}