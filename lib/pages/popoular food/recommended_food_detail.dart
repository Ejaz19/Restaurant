import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:res/controllers/popular_product_controller.dart';
//import 'package:res/pages/cart/cart_page.dart';
import 'package:res/utils/colors.dart';
import 'package:res/utils/dimensions.dart';
import 'package:res/widgets/app_icon.dart';
import 'package:res/widgets/big_text.dart';
import 'package:res/widgets/expandable_text_widget.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../widgets/small_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               GestureDetector(
                onTap: () {
                 Get.toNamed(RouteHelper.getInitial()); 
                },
                child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(builder: (controller){
                return GestureDetector(
                    onTap: () {
                    if(controller.totalItems>=1)
                    Get.toNamed(RouteHelper.getCartPage());
 
                  
                  },
                  child: Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_checkout_outlined),
                      Get.find<PopularProductController>().totalItems>=1?
                      Positioned(
                        top: 0,right:0,
                        
                          child: AppIcon(icon: Icons.circle,size: 20,
                          IconColor: Colors.transparent,
                          backgroundColor: AppColors.mainColor,),
                        
                        ):
                      Container(),
                      Get.find<PopularProductController>().totalItems>=1?
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
               //AppIcon(icon: Icons.shopping_basket_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                
               
                child: Center(child: BigText( size: Dimensions.fonstSize26,   text: product.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10,),
                decoration: BoxDecoration(
                   color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
              )
              ),
           pinned: true,
            backgroundColor: Colors.grey,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URI+AppConstants.UPLOAD_URL+product.img!,
              width: double.maxFinite,
              fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: product.description),
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20)
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
       return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.setQuantity(false);
                  },
                  child:  AppIcon(
                  iconSize: Dimensions.iconSize24,
                  IconColor: Colors.white,  
                backgroundColor: AppColors.mainColor,  icon: Icons.remove),
                ),
                BigText(text: " \$ ${product.price!}  X  ${controller.inCartItems} ",color: AppColors.mainBlackColor, size: Dimensions.fonstSize26,),
                GestureDetector(
                  onTap: () {
                    controller.setQuantity(true);
                  },
                  child:  AppIcon(
                  iconSize: Dimensions.iconSize24,
                  IconColor: Colors.white,  
                backgroundColor: AppColors.mainColor,  icon: Icons.add),
                ),
              ],
            ),
          ),
           Container(
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
              child: Icon(
                Icons.favorite,
                color: AppColors.mainColor,
              )
            ),
            GestureDetector(
              onTap: () {
                controller.addItem(product);
              },
              child: Container(
               padding: EdgeInsets.only(top: Dimensions.height20,
              bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
              child: BigText(text: "\$ ${product.price!} | Add to cart",color: Colors.white,),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius20),color: AppColors.mainColor),
            ),
            )
          ],
        ),
      ),
        ],
      );
      }),
    );
  }
}