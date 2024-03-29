import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:food_delivery/utils/constants/dimension.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../Controllers/auth_controller.dart';
import '../../base/show_custom_snackbar.dart';
import '../../models/signup_body_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    void _login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar("Please type your phone number", title: "Phone");
      } else if (phone.length < 11) {
        showCustomSnackBar("Your phone number must be 11 characters",
            title: "Not valid phone number");
      } else if (password.isEmpty) {
        showCustomSnackBar("Please type your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password must be at least 6 characters",
            title: "Password");
      } else {
        //registaion method

        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getCartPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        //logo
                        SizedBox(
                          height: Dimensions.screenHeight * 0.25,
                          child: const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/images/logo part 1.png"),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                        //Welcome back
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                    fontSize: Dimensions.font20 * 3.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Sign into your account ~",
                                  style: TextStyle(
                                    fontSize: Dimensions.font20,
                                    color: Colors.grey[500],
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          obscureText: false,
                          hintText: "Phone ",
                          textController: phoneController,
                          icon: Icons.phone,
                          iconColor: AppColors.mainColor,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          obscureText: true,
                          hintText: "Password",
                          textController: passwordController,
                          icon: Icons.lock,
                          iconColor: AppColors.yellowColor,
                        ),
                        SizedBox(height: Dimensions.height10),

                        SizedBox(height: Dimensions.height45),
                        //Sign in button
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth * 0.75,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                            ),
                            child: Center(
                              child: BigText(
                                text: "Sign In",
                                color: Colors.white,
                                size: Dimensions.font26,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        //Dont have an account
                        RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => const SignUpPage(),
                                          transition: Transition.fade);
                                    },
                                  text: "Create",
                                  style: TextStyle(
                                      color: AppColors.mainBlackColor,
                                      fontSize: Dimensions.font20,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        )
                      ],
                    ),
                  )
                : const CustomLoader();
          },
        ));
  }
}
