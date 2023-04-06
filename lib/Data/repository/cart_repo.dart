import 'dart:convert';

import 'package:food_delivery/models/cart_models.dart';
import 'package:food_delivery/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedpreferences;

  CartRepo({required this.sharedpreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    //convert object(cartlist) to string
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });
    sharedpreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedpreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedpreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedpreferences.getStringList(AppConstants.CART_LIST)!;
      // print("inside get cart list" + carts.toString());
    }
    List<CartModel> cartList = [];

    //convert string to object(cartlist)
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  void addToCartHistory() {}
}
