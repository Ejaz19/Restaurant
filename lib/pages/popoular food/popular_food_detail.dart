import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:res/controllers/cart_controller.dart';
import 'package:res/controllers/popular_product_controller.dart';
//import 'package:res/pages/cart/cart_page.dart';
import 'package:res/pages/home/main_food_page.dart';
import 'package:res/routes/route_helper.dart';
import 'package:res/widgets/app_icon.dart';
import 'package:res/utils/dimensions.dart';
import '../../utils/app_constants.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../utils/colors.dart';
import '../../widgets/expandable_text_widget.dart';
//import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
   const PopularFoodDetail({Key? key,required this.pageId}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //backgroud image
          Positioned(
            left: 0,
            right: 0,
             child: Container(
              width: double.maxFinite,
              height: Dimensions.popoularFoodImgSize,
              decoration: BoxDecoration(
                
               image: DecorationImage(
                fit:BoxFit.cover,
                image: NetworkImage(AppConstants.BASE_URI+AppConstants.UPLOAD_URL+product.img!) )
              ),

            ),),
            //icon widget
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(()=>MainFoodPage());
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios)),


               GetBuilder<PopularProductController>(builder: (controller){
                return GestureDetector(
                  onTap: () {
                    if(controller.totalItems>=1)
                    Get.toNamed(RouteHelper.getCartPage());
 
                  },
                  child: Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_checkout_outlined),
                      controller.totalItems>=1?
                      Positioned(
                        top: 0,right:0,
                        
                          child: AppIcon(icon: Icons.circle,size: 20,
                          IconColor: Colors.transparent,
                          backgroundColor: AppColors.mainColor,),
                        
                        ):
                      Container(),
                      controller.totalItems>=1?
                      Positioned(
                        right: 3,top: 0,
                        child: SmallText(text: Get.find<PopularProductController>().totalItems.toString(),
                        size: 6, color: Colors.white,
                        ),
                      ):
                      Container()
                     ],
                  ),
                );
               })
              ],
            )),
            //introduction of food
          Positioned(
           left: 0,
           right: 0,
           bottom: 0,
           top: Dimensions.popoularFoodImgSize-20,
          child: Container(
            padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.width20),
                topRight: Radius.circular(Dimensions.width20),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppColumn(text: product.name!),
                SizedBox(height: Dimensions.height20,),
                BigText(text: "Introduction"),
                SizedBox(height: Dimensions.height10,),
                Expanded
                (child: SingleChildScrollView
                (child: ExpandableTextWidget(text: product.description!)))
              ],
            )
          ))
          //text of introduction
          
        
        ],
      ),
      bottomNavigationBar: 
      GetBuilder<PopularProductController>(builder: (popularProduct){
         return Container(
        height: Dimensions.bottonHeightBar,
        padding: EdgeInsets.only(top: Dimensions.height30,
        bottom: Dimensions.height30,
        left: Dimensions.width20,right: Dimensions.width20,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20*2),
            topRight: Radius.circular(Dimensions.radius20*2),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20,
              bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      popularProduct.setQuantity(false);
                    },
                    child: Icon(Icons.remove,color: AppColors.signColor,)),
                  SizedBox(width: Dimensions.height10/2,),
                  BigText(text: popularProduct.inCartItems.toString()),
                  SizedBox(width: Dimensions.height10/2,),
                  GestureDetector(
                    onTap: () {
                      popularProduct.setQuantity(true);
                    },
                    child: Icon(Icons.add,color: AppColors.signColor,))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                popularProduct.addItem(product);
              },
              child: Container(
                 padding: EdgeInsets.only(top: Dimensions.height20,
                bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),color: AppColors.mainColor),
                
                  child: BigText
                  (text: "\$ ${product.price!} | Add to cart",color: Colors.white,),
              ),
            )
          ],
        ),
      );
      },),
    );
  }
}