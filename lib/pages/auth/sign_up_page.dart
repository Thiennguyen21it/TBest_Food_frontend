import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:food_delivery/utils/constants/dimension.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/auth_controller.dart';
import '../../base/show_custom_snackbar.dart';
import '../../routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    var signUpImages = [
      "g.png",
      "f.png",
      "t.png",
    ];

    void _registaion(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Please type your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Please type your phone number", title: "Phone");
      } else if (phone.length < 11) {
        showCustomSnackBar("Your phone number must be 11 characters",
            title: "Not valid phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Please type your email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Please type valid email",
            title: "Not valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Please type your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password must be at least 6 characters",
            title: "Password");
      } else {
        //registaion method
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("susccess registration");
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading // isLoading = true
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
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          obscureText: false,
                          iconColor: AppColors.mainColor,
                          hintText: "Name",
                          textController: nameController,
                          icon: Icons.person,
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
                          obscureText: false,
                          hintText: "Email",
                          textController: emailController,
                          icon: Icons.email,
                          iconColor: AppColors.mainColor,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          obscureText: true,
                          hintText: "Password",
                          textController: passwordController,
                          icon: Icons.lock,
                          iconColor: AppColors.mainColor,
                        ),
                        SizedBox(height: Dimensions.height45),
                        //sign up button
                        GestureDetector(
                          onTap: () {
                            //registaion
                            _registaion(_authController);
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
                                text: "Sign Up",
                                color: Colors.white,
                                size: Dimensions.font26,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height10),
                        RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.back();
                                    },
                                  text: "Sign In",
                                  style: TextStyle(
                                    color: AppColors.mainBlackColor,
                                    fontSize: Dimensions.font20,
                                    // fontWeight: FontWeight.bold
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        //sign up options
                        RichText(
                            text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            },
                          text: "Sign up using one of the following options",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: Dimensions.font16),
                        )),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Wrap(
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: Dimensions.radius30,
                                      backgroundImage: AssetImage(
                                          "assets/images/${signUpImages[index]}"),
                                    ),
                                  )),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        )
                      ],
                    ),
                  )
                : const CustomLoader(); //false
          },
        ));
  }
}
