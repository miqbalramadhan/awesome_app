import 'package:awesome_app/values/colors.dart';
import 'package:flutter/material.dart';

class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color? color;

  const ColoredSafeArea({required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? white,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
