import 'package:flutter/material.dart';
import 'package:res/controllers/popular_product_controller.dart';
//import 'package:res/pages/cart/cart_page.dart';
//import 'package:res/pages/home/food_page_body.dart';

import 'package:res/pages/home/main_food_page.dart';
import 'package:get/get.dart';
//import 'package:res/pages/popoular%20food/popular_food_detail.dart';
//import 'package:res/pages/popoular%20food/recommended_food_detail.dart';
import 'package:res/routes/route_helper.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      
      
      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}

