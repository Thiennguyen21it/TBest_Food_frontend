import 'package:food_delivery/pages/Food/recomend_food_detail.dart';
import 'package:get/get.dart';

import '../pages/Food/popular_food_detail.dart';
import '../pages/Home/main_food_page.dart';
import '../pages/cart/cart_page.dart';

class RouteHelper {
  static const String initial = '/'; //home page
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      "$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage() => cartPage;
  static List<GetPage> routes = [
    //get home page
    GetPage(
        name: initial,
        page: () {
          return const MainFoodPage();
        }),
    //get popular food detail page
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    //get recommended food detail page
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    //get cart page
    GetPage(
      name: cartPage,
      page: () {
        return const CartPage();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
