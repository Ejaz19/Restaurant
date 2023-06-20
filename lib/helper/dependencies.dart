import 'package:get/get.dart';
import 'package:res/controllers/cart_controller.dart';
import 'package:res/controllers/popular_product_controller.dart';
import 'package:res/data/api/api_client.dart';
import 'package:res/data/api/repository/cart_repo.dart';
import 'package:res/data/api/repository/popular_product_repo.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/api/repository/recommended_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init()async{
  //api client
 Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URI));


//repos
 Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
 Get.lazyPut(() => CartRepo());

 //controllers
 Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
 Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
 Get.lazyPut(() => CartController(cartRepo: Get.find()));
}