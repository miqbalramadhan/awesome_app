import 'package:awesome_app/models/photos_model.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Photos data;
  const ItemCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        child: Ink(
          width: double.infinity,
          height: 250,
          child: Image.network(data.src!.portrait.toString()),
        ),
      ),
    );
  }
}
