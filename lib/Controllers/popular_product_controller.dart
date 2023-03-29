import 'package:food_delivery/Data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../models/product_models.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo
      popularProductRepo; //create object of PopularProductRepo

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = []; //create list of popular product
  List<dynamic> get popularProductList => _popularProductList; //getter

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //create function to get popular product list
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got product");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products!);
      // print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      //show error
      return Future.error(response.statusText.toString());
    }
  }
}
