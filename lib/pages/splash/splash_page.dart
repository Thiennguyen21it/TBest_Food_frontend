import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/constants/dimension.dart';
import 'package:get/get.dart';

import '../../Controllers/popular_product_controller.dart';
import '../../Controllers/recommended_product_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    // animation = Tween<double>(begin: 0, end: 1).animate(controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);

    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(RouteHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image.asset(
              "assets/images/logo part 1.png",
              width: Dimensions.splashImg,
            ),
          ),
        ),
        Center(
          child: Image.asset(
            "assets/images/logo part 2.png",
            width: Dimensions.splashImg,
          ),
        ),
      ]),
    );
  }
}
