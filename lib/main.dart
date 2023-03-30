import 'package:flutter/material.dart';
import 'package:food_delivery/Controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/Food/popular_food_detail.dart';
import 'package:food_delivery/pages/Home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
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
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendProductList();

    return GetMaterialApp(
      title: 'Flutter Food App',
      debugShowCheckedModeBanner: false,
      home: const MainFoodPage(),
      initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes,
    );
  }
}
