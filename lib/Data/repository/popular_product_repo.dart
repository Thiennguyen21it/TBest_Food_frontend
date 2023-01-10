import 'package:food_delivery/Data/api/api_client.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApitClient apitClient;
  PopularProductRepo({required this.apitClient});

  Future<Response> getPopularProductList() async {
    return await apitClient.getData("https://www");
  }
}
