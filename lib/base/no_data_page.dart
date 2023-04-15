import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imagePath;
  const NoDataPage(
      {super.key,
      required this.text,
      this.imagePath = "assets/images/empty_cart.png"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imagePath,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.3,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Theme.of(context).disabledColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
