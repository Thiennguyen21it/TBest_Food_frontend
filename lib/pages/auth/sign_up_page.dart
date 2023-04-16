import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:food_delivery/utils/constants/dimension.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  backgroundImage: AssetImage("assets/images/logo part 1.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
              iconColor: AppColors.mainColor,
              hintText: "Name",
              textController: nameController,
              icon: Icons.person,
            ),
            SizedBox(height: Dimensions.height45),
            Container(
              width: Dimensions.screenWidth * 0.75,
              height: Dimensions.screenHeight / 13,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radius30),
              ),
              child: Center(
                child: BigText(
                  text: "Sign Up",
                  color: Colors.white,
                  size: Dimensions.font26,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            RichText(
                text: TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.back();
                },
              text: "Already have an account? ",
              style: TextStyle(
                  color: Colors.grey[600], fontSize: Dimensions.font20),
            )),
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
                  color: Colors.grey[600], fontSize: Dimensions.font16),
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
      ),
    );
  }
}
