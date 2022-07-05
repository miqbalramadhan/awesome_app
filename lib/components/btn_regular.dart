import 'package:awesome_app/values/colors.dart';
import 'package:awesome_app/values/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegularButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  double width;
  final double height;
  final double fontSize;
  final String type;
  final Color textColor;
  final Color color;
  RegularButton({
    required this.text,
    required this.press,
    this.width = 1,
    this.textColor = Colors.white,
    this.color = dark,
    this.height = 45,
    this.fontSize = 16,
    this.type = "fill",
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (width <= 1) {
      width = size.width * width;
    }
    if (type == "fill") {
      return Container(
        // margin: EdgeInsets.symmetric(vertical: 10),
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: press,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
              ),
              textScaleFactor: 1.0,
            ),
          ),
        ),
      );
    } else if (type == "Outline") {
      return Container(
        width: width,
        height: height,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 2, color: color),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
            textScaleFactor: 1.0,
          ),
          onPressed: press,
        ),
      );
    } else {
      return Container(
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: color),
          onPressed: press,
          child: Text(
            text,
            textScaleFactor: 1.0,
          ),
        ),
      );
    }
  }
}
