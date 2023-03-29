import 'package:flutter/material.dart';
import 'package:food_delivery/utils/constants/dimension.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final TextOverflow overflow;

  const BigText(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        // fontFamily: 'JetBrainsMono',

        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
