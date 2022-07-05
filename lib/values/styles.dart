import 'package:awesome_app/values/colors.dart';
import 'package:flutter/material.dart';

final boxCard = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5),
  border: Border.all(width: 0.5, color: Colors.black.withOpacity(0.3)),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.03),
      spreadRadius: 0,
      blurRadius: 3,
      offset: Offset(0, 4),
    ),
  ],
);
final borderBottom = BoxDecoration(
    border: Border(bottom: BorderSide(width: 1, color: dark.withOpacity(0.2))));

final boxCardNoRadius = BoxDecoration(
  color: Colors.white,
  border: Border.all(width: 0.5, color: dark.withOpacity(0.3)),
  boxShadow: [
    BoxShadow(
      color: dark.withOpacity(0.03),
      spreadRadius: 0,
      blurRadius: 3,
      offset: Offset(0, 4),
    ),
  ],
);
