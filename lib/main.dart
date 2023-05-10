import 'package:flutter/material.dart';
import 'package:food_delivery/Controllers/cart_controller.dart';
import 'package:food_delivery/Controllers/popular_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:get/get.dart';
import 'Controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dependencies;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            title: 'Flutter Food App',
            // home: const SplashPage(),
            debugShowCheckedModeBanner: false,
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
            theme: ThemeData(
              primaryColor: AppColors.mainColor,
              fontFamily: 'Poppins',
            ),
            // home: SignInPage(),
          );
        });
      },
    );
  }
}
