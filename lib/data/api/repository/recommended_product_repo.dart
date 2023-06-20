import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../api_client.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODCUT_URI);
  }
}