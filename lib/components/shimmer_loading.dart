import 'package:awesome_app/components/shimmer_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget shimmerGridPhotos() {
  return Container(
    margin: EdgeInsets.all(12),
    child: StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: ShimmerBox(),
          ),
        );
      },
      staggeredTileBuilder: (index) {
        return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
      },
    ),
  );
}
