import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: 5,
        itemBuilder: (context, position) {
          return _buildPageItem(position);
        },
      ),
    );
  }

  Widget _buildPageItem(int index) {
    return Container(
      height: 220,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.yellowColor,
        image: const DecorationImage(
          image: AssetImage("assets/images/banh_chung.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
