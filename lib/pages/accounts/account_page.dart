import 'package:flutter/material.dart';
import 'package:food_delivery/Controllers/auth_controller.dart';
import 'package:food_delivery/Controllers/cart_controller.dart';
import 'package:food_delivery/Controllers/user_controller.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:food_delivery/utils/constants/dimension.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userIsLoggedIn();

    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfor();
      print("User have loggin");
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.mainColor,
          title: const Center(
            child: BigText(
              text: "Profile",
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            //profile image
                            AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height15 * 5,
                              size: Dimensions.height15 * 10,
                            ),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //name
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height15 * 1.5,
                                        size: Dimensions.height15 * 3,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.name,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //phone number
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height15 * 1.5,
                                        size: Dimensions.height15 * 3,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.phone,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //email
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height15 * 1.5,
                                        size: Dimensions.height15 * 3,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.email,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //address
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height15 * 1.5,
                                        size: Dimensions.height15 * 3,
                                      ),
                                      bigText: const BigText(
                                        text: "Fill in your address",
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //bio
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height15 * 1.5,
                                        size: Dimensions.height15 * 3,
                                      ),
                                      bigText: const BigText(
                                        text: "bio",
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userIsLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.offAllNamed(
                                              RouteHelper.getSignInPage());
                                        } else {
                                          print("you are loggout");
                                        }
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height15 * 1.5,
                                          size: Dimensions.height15 * 3,
                                        ),
                                        bigText: const BigText(
                                          text: "Logout",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const CustomLoader())
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //image
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 8,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              top: Dimensions.height20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/signintocontinue.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        //tap to sign in line
                        BigText(
                          text: "Sign in to continue ",
                          size: 24,
                          color: AppColors.paraColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: Dimensions.width20 * 15,
                            height: Dimensions.height20 * 3,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                                top: Dimensions.height20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: BigText(
                                text: "Sign in",
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ));
  }
}
