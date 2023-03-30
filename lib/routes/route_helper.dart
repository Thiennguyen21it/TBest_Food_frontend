import 'package:food_delivery/pages/Food/recomend_food_detail.dart';
import 'package:get/get.dart';

import '../pages/Food/popular_food_detail.dart';
import '../pages/Home/main_food_page.dart';

class RouteHelper {
  static const String initial = '/'; //home page
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial() => initial;
  static String getPopularFood(int pageId) => "$popularFood?pageId=$pageId";
  static String getRecommendedFood(int pageId) =>
      "$recommendedFood?pageId=$pageId";

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
        return PopularFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),
    //get recommended food detail page
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return RecommendFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),
  ];
}
