import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final dynamic borderRadius;
  ShimmerBox({
    this.width = 50,
    this.height = 50,
    this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: borderRadius == null
          ? _shimmer()
          : ClipRRect(
              borderRadius: borderRadius,
              child: _shimmer(),
            ),
    );
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        color: Colors.grey,
      ),
    );
  }
}
