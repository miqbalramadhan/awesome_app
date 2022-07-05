import 'package:awesome_app/models/photos_model.dart';
import 'package:awesome_app/values/colors.dart';
import 'package:awesome_app/values/constants.dart';
import 'package:awesome_app/values/styles.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Photos data;
  DetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double? _height;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: regular,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: widget.data.liked! ? Colors.red : white,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              _header(),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      height: _height! * .6,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(
            widget.data.src!.portrait.toString(),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(paddingBody),
      decoration: boxCard,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(5),
            child: Icon(Icons.person),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.photographer.toString(),
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.data.url.toString(),
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: dark,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
