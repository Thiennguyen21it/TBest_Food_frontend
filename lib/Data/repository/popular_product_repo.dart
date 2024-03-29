import 'package:food_delivery/Data/api/api_client.dart';
import 'package:food_delivery/utils/constants/app_constants.dart';
import 'package:get/get.dart';

//call api method(function) here
class PopularProductRepo extends GetxService {
  final ApitClient apitClient;
  PopularProductRepo({required this.apitClient});

  Future<Response> getPopularProductList() async {
    return await apitClient
        .getData(AppConstants.POPULAR_PRODUCT_URI); //end point url
  }
}
