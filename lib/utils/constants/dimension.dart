import 'package:get/get.dart';

class Dimensions {
  //dynamic height
  static double screenHeight = Get.context!.height;

  static double pageViewHeight = screenHeight / 2.64;
  static double pageViewContainerHeight = screenHeight / 3.84;
  static double pageViewTextContainerHeight = screenHeight / 7.03;

  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.75;
  //dynamic width
  static double screenWidth = Get.context!.width;

  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;
  static double width45 = screenHeight / 28.13;

  //radius
  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  //fonts
  static double font20 = screenHeight / 42.2;

  //icon size
  static double iconSize24 = screenHeight / 35.16;
}