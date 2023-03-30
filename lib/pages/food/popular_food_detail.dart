import 'package:flutter/material.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/constants/dimension.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../../Controllers/popular_product_controller.dart';
import '../../utils/constants/color_constants.dart';
import '../../widgets/big_text.dart';

class PopularFoodDetail extends StatefulWidget {
  int pageId;

  PopularFoodDetail({super.key, required this.pageId});

  @override
  State<PopularFoodDetail> createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[widget.pageId];
    // print("page is id " + widget.pageId.toString());
    // print("product is " + product.name);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //backgroup image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: NetworkImage(AppConstants.BASE_URL +
              //         AppConstants.POPULAR_PRODUCT_URI +
              //         product.img),
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
          ),
          //back button and cart button
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.getInitial()),
                  // onTap: () => Navigator.pop(context),
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                const AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
          ),
          //showing the food name and introduce
          Positioned(
            left: 0,
            right: 0,
            top: Dimensions.popularFoodImgSize - Dimensions.width20,
            bottom: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name,
                  ),
                  SizedBox(height: Dimensions.height20),
                  const BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20),
                  //Expandable text widget
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(
                        text: product.description!,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomBarHeight,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius30),
            topRight: Radius.circular(Dimensions.radius30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //modify quantity of food
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                bottom: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(width: Dimensions.width10 * 0.5),
                  const BigText(text: "0"),
                  SizedBox(width: Dimensions.width10 * 0.5),
                  Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ],
              ),
            ),
            //add to cart
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.height15,
                bottom: Dimensions.height15,
                left: Dimensions.width15,
                right: Dimensions.width15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
              ),
              child: BigText(
                text: " \$ ${product.price}  | Add to cart  ",
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
