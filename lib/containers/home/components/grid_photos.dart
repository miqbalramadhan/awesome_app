import 'package:awesome_app/models/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridPhotos extends StatefulWidget {
  final List<Photos> data;
  GridPhotos({Key? key, required this.data}) : super(key: key);

  @override
  State<GridPhotos> createState() => _GridPhotosState();
}

class _GridPhotosState extends State<GridPhotos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          Photos _photo = widget.data[index];
          return Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: _photo.src!.medium.toString(),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
        },
      ),
    );
  }
}
