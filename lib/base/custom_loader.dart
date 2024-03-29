import 'package:flutter/material.dart';
import 'package:food_delivery/Controllers/auth_controller.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:food_delivery/utils/constants/dimension.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    print("I am printing loading state " +
        Get.find<AuthController>().isLoading.toString());
    return Center(
      child: Container(
          height: Dimensions.height20 * 5,
          width: Dimensions.width20 * 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.width20 * 2.5),
              color: AppColors.mainColor),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: Colors.white,
          )),
    );
  }
}
