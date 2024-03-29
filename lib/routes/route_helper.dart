import 'package:food_delivery/pages/Food/recomend_food_detail.dart';
import 'package:food_delivery/pages/Home/home_page.dart';
import 'package:food_delivery/pages/address/add_address_page.dart';
import 'package:get/get.dart';

import '../pages/Food/popular_food_detail.dart';
import '../pages/address/pick_address_map.dart';
import '../pages/auth/sign_in_page.dart';
import '../pages/cart/cart_page.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initial = '/'; //home page
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";

  static String getSignInPage() => signIn;
  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      "$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage() => cartPage;
  static String getAddressPage() => addAddress;
  static String getPickAddressPage() => pickAddressMap;

  static List<GetPage> routes = [
    //get splash page
    GetPage(
      name: splashPage,
      page: () {
        return const SplashPage();
      },
    ),
    //get home page
    GetPage(
        name: initial,
        page: () {
          return const HomePage();
        },
        transition: Transition.fade),
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
    //get sign in page
    GetPage(
      name: signIn,
      page: () {
        return const SignInPage();
      },
      transition: Transition.fadeIn,
    ),

    //get add address page
    GetPage(
      name: addAddress,
      page: () {
        return const AddAdressPage();
      },
      transition: Transition.fadeIn,
    ),
    //get pick address page
    GetPage(
      name: pickAddressMap,
      page: () {
        PickAddressMap _pickAddress = Get.arguments;
        return _pickAddress;
      },
      transition: Transition.fadeIn,
    ),
  ];
}
