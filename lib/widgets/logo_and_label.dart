import 'package:flutter/material.dart';

import '../constants/colors.dart';

class LogoAndLabel extends StatelessWidget {
  static const String _logoText = 'цвркутан';
  static const String _sloganText = 'Само уради то.';
  static const String _imagePath = 'assets/images/logo-blue.png';

  const LogoAndLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Image(
          image: AssetImage(_imagePath),
          width: 100,
        ),
        Text(
          _logoText,
          style: TextStyle(fontSize: 26, color: primaryColor),
          textAlign: TextAlign.start,
        ),
        Text(
          _sloganText,
          style: TextStyle(
              fontSize: 18, color: primaryColor, fontStyle: FontStyle.italic),
          textAlign: TextAlign.start,
        )
      ],
    );
  }
}
