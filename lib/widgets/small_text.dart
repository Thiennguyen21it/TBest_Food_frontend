import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  double height;

  SmallText({
    super.key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.height = 1.2,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
      ),
    );
  }
}
