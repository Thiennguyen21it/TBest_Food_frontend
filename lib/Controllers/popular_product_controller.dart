import 'package:flutter/material.dart';
import 'package:food_delivery/Controllers/cart_controller.dart';
import 'package:food_delivery/Data/repository/popular_product_repo.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:get/get.dart';

import '../models/product_models.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo
      popularProductRepo; //create object of PopularProductRepo

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = []; //create list of popular product
  List<dynamic> get popularProductList => _popularProductList; //getter
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  //create function to get popular product list
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      // print("got popular product");
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

  void setQuatity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if (quantity > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    //if exist
    //get from storage _inCartItems
  }

  void addItem(ProductModel product) {
    if (_quantity > 0) {
      _cart.addItem(product, _quantity);
      _cart.items.forEach((key, value) {
        print("the id is " +
            value.id.toString() +
            " the quantity is " +
            value.quantity.toString());
      });
    } else {
      Get.snackbar(
        "Item count",
        "You should at least add an item in the cart !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
    }
  }
}
