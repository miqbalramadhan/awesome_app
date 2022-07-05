import 'package:awesome_app/components/shimmer_box.dart';
import 'package:awesome_app/values/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget shimmerList({
  int count = 10,
  bool header = false,
  bool line = false,
  bool medium = false,
  bool card = false,
  desc: true,
}) {
  EdgeInsetsGeometry? padding;
  if (medium) {
    padding = EdgeInsets.symmetric(vertical: 20, horizontal: 10);
  }
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (header)
            ? Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: ShimmerBox(width: 200, height: 15),
              )
            : Container(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: count,
          itemBuilder: (context, i) {
            return Container(
              decoration: line == true
                  ? borderBottom
                  : card
                      ? boxCard
                      : null,
              padding: padding != null ? padding : EdgeInsets.all(10),
              margin: card ? EdgeInsets.only(bottom: 10) : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 150, height: 10),
                  (desc)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            ShimmerBox(width: double.infinity, height: 7),
                            SizedBox(height: 5),
                            ShimmerBox(width: 200, height: 10),
                          ],
                        )
                      : Container(),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}

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
