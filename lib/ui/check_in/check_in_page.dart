import 'package:flutter/material.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double figureLeft = screenWidth * (0.4 - 120 / screenWidth / 2);
    double figureBottom = screenHeight * 0.01;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          "assets/images/bg_street_day.jpg",
          fit: BoxFit.cover,
        ),
        Positioned(
          width: 120.0,
          height: 120.0,
          left: figureLeft,
          bottom: figureBottom,
          child: Image.asset(
            "assets/images/man_on_duty.png",
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
