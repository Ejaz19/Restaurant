import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:res/controllers/popular_product_controller.dart';
import 'package:res/controllers/recommended_product_controller.dart';
//import 'package:res/pages/popoular%20food/popular_food_detail.dart';
import 'package:res/utils/dimensions.dart';
import 'package:res/widgets/big_text.dart';
import 'package:res/widgets/small_text.dart';
import 'package:res/widgets/icon_and_text.dart';
import 'package:res/utils/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:dots_indicator/dots_indicator.dart';

import '../../models/product_models.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../widgets/app_column.dart';
class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});
  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.87);
  var _currPageValue = 0.0;
  double _scalefactor = 0.8;
  double _height = 220;
  
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue =  pageController.page!;
        //print("current page value is" +_currPageValue.toString());
      });

    });
  } 
  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }
 @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //container
        
      GetBuilder<PopularProductController>(builder: (popularProducts){
        return popularProducts.isLoaded?Container(
          height: Dimensions.pageView,
          
            
            child: PageView.builder(
              controller: pageController,
              itemCount: popularProducts.popularProductList.length,
              itemBuilder: (context, position) {
                return _buildPageItem(position, popularProducts.popularProductList[position]);
              },
            ),
          
        ):
        CircularProgressIndicator(
          color: AppColors.mainBlackColor,
        );
      }),
        
          
       //dots indicator
      GetBuilder<PopularProductController>(builder: (popularProducts) {
   return DotsIndicator(
          dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        );
}),

    
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end ,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color: Colors.black26,),
                
              ),
              SizedBox(width:Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing",),
              )
            ],
          ),
        ),
        SizedBox(height: Dimensions.height10,),
        //list of food and images
        //recommended food
        Container(
          height: 750,
          child:
           GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
            //print("getting data");
            return recommendedProduct.isLoaded?ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context,index){
              //print("getting data again");
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getRecommendedFood(index));
              },
              child: Container(
                
               margin: EdgeInsets.only(left: Dimensions.width20,
               right: Dimensions.width20,bottom: Dimensions.height20),
               child: Row(
                children: [
                  //image section
                  Container(
                    width: Dimensions.listviewimgsize120,
                    height: Dimensions.listviewimgsize120,
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white38,
                      image: DecorationImage(image: NetworkImage(
              AppConstants.BASE_URI+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!),
                      fit: BoxFit.cover,)
                    ),
                  ),
                  // image desription section
                  Expanded(
                    child: Container(
                      height: Dimensions.listviewTextContsize100,
                      
                     // margin: EdgeInsets.only(left: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20),
                          bottomRight: Radius.circular(Dimensions.radius20),),
                          color: Colors.white,
                    
                        ),
                        child: Padding(padding: EdgeInsets.only(left: Dimensions.width10,),
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          
                          children: [
                            BigText(text: recommendedProduct.recommendedProductList[index].name,color: AppColors.mainBlackColor),
                            SizedBox(height: Dimensions.height5,),
                            SmallText(text: "With Indian characteristics"),
                            SizedBox(height: Dimensions.height5,),
                            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   
                    children: [
                      IconAndText(icon: Icons.circle_sharp,
                      
                       text: "Normal", 
                       size: Dimensions.iconSize24,
                       
                       iconColor: AppColors.iconColor1),
                      // SizedBox(width: 2),
                       IconAndText(icon: Icons.location_on,
                       size: Dimensions.iconSize24,
                       text: "1.7km", 
                       iconColor: AppColors.mainColor),
                       //SizedBox(width: 2),
                       IconAndText(icon: Icons.access_alarms_rounded,
                       size: Dimensions.iconSize24,
                       text: "32 min", 
                       iconColor: AppColors.iconColor1),
                
                    ],
                     ),
                   ],
                         ),
                        ),
                        
                    ),
                  ),
                ],
               ),
              ),
            );
          }):
          CircularProgressIndicator(
            color: AppColors.mainBlackColor,
          );
           }),
        
        
        ),
      ],
    );
    
     
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
   Matrix4 matrix = new Matrix4.identity();
   if(index == _currPageValue.floor()){
    var currScale = 1-(_currPageValue-index)*(1 - _scalefactor);
    var currTrans = _height*(1-currScale)/2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
   }
   else if(index == _currPageValue.floor()+1){
    var currScale = _scalefactor+(_currPageValue-index+1)*(1 - _scalefactor);
    var currTrans = _height*(1-currScale)/2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
   }
   else if(index == _currPageValue.floor()-1){
   var currScale = 1-(_currPageValue-index)*(1 - _scalefactor);
    var currTrans = _height*(1-currScale)/2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
   }
   else{
    var currScale = 0.8;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scalefactor)/2, 0);
   }
 return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){

              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
                  height: Dimensions.pageViewContainer,
                  margin: EdgeInsets.only(left: Dimensions.width5,right: Dimensions.width5),
                  decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            color: index.isEven?Color(0xFF69c5df):Color(0xFF9894cc),
                   image: DecorationImage(
                   fit: BoxFit.cover,
             image: NetworkImage(
              AppConstants.BASE_URI+AppConstants.UPLOAD_URL+popularProduct.img!),
            )
                  ),
                ),
          ),
       Align(
        alignment: Alignment.bottomCenter,
         
           child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(left: Dimensions.width45,right: Dimensions.width30,bottom: Dimensions.height30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: 0.5,
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                )
              ]
              ),
              child: Container(
             
                padding: EdgeInsets.only(top: Dimensions.height15,left: Dimensions.width15,right: Dimensions.width15,bottom: Dimensions.height15),
                child: AppColumn(text: popularProduct.name!),
              ),
             ),
         
          ),
        ],
      ),
    );
    
  }
}