import 'dart:convert';

import 'package:food_delivery/models/cart_models.dart';
import 'package:food_delivery/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedpreferences;

  CartRepo({required this.sharedpreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    sharedpreferences.remove(AppConstants.CART_LIST);
    sharedpreferences.remove(AppConstants.CART_HISTORY_LIST);
    var time = DateTime.now().toString();
    cart = [];
    //convert object(cartlist) to string
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    //
    sharedpreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedpreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedpreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedpreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside get cart list : " + carts.toString());
    }
    List<CartModel> cartList = [];

    //convert string to object(cartlist)
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedpreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      // cartHistory = [];
      cartHistory =
          sharedpreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedpreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedpreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print(" history list : " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedpreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print("the length of cart history list : " +
        getCartHistoryList().length.toString());
    for (int i = 0; i < getCartHistoryList().length; i++) {
      print("the time for the order is : " + getCartHistoryList()[i].time!);
    }
  }

  void removeCart() {
    cart = [];
    sharedpreferences.remove(AppConstants.CART_LIST);
  }
}
