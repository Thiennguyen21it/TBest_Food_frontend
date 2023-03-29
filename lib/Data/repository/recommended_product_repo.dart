import 'package:food_delivery/Data/api/api_client.dart';
import 'package:food_delivery/utils/constants/app_constants.dart';
import 'package:get/get.dart';

//call api method(function) here
class RecommendedProductRepo extends GetxService {
  final ApitClient apitClient;

  RecommendedProductRepo({required this.apitClient});

  Future<Response> getRecommendedProductList() async {
    return await apitClient
        .getData(AppConstants.RECOMMENDED_PRODUCT_URI); //end point url
  }
}
