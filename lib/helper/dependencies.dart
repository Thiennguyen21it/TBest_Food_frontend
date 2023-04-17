import 'dart:ui';

import 'package:food_delivery/Controllers/popular_product_controller.dart';
import 'package:food_delivery/Data/api/api_client.dart';
import 'package:food_delivery/Data/repository/auth_repo.dart';
import 'package:food_delivery/Data/repository/cart_repo.dart';
import 'package:food_delivery/Data/repository/popular_product_repo.dart';
import 'package:food_delivery/Data/repository/recommended_product_repo.dart';
import 'package:food_delivery/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/auth_controller.dart';
import '../Controllers/cart_controller.dart';
import '../Controllers/recommended_product_controller.dart';

//it control all the dependencies
Future<void> init() async {
  final sharedpreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedpreferences);

  //api client
  Get.lazyPut(
    (() =>
        ApitClient(appBaseUrl: AppConstants.BASE_URL)), // get data from server
  );
  //repository
  Get.lazyPut((() => PopularProductRepo(apitClient: Get.find())) //
      );
  Get.lazyPut((() => RecommendedProductRepo(apitClient: Get.find())) //
      );
  Get.lazyPut(() => CartRepo(sharedpreferences: Get.find()));

  Get.lazyPut(
      () => AuthRepo(apitClient: Get.find(), sharedPreferences: Get.find()));

//controllers
  Get.lazyPut((() => PopularProductController(popularProductRepo: Get.find())));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));

  Get.lazyPut(
    () => CartController(cartRepo: Get.find()),
  );
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
}
