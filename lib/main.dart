import 'package:flutter/material.dart';
import 'package:food_delivery/pages/Food/popular_food_detail.dart';
import 'package:food_delivery/pages/Food/recomend_food_detail.dart';
import 'package:food_delivery/pages/Home/main_food_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const PopularFoodDetail(),
    );
  }
}
