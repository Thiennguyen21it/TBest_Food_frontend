import 'package:get/get.dart';

import '../Data/repository/recommended_product_repo.dart';
import '../models/product_models.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo
      recommendedProductRepo; // create object of RecommendProductRepo

  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = []; //create list of popular product
  List<dynamic> get recommendedProductList => _recommendedProductList; //getter

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //create function to get Recommended product list
  Future<void> getRecommendProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print("got product");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products!);
      // print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      //show error
      return Future.error(response.statusText.toString());
    }
  }
}