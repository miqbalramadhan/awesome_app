import 'package:awesome_app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  final bool showImage;
  final double aspecRatio;
  final String title;
  final String body;
  final String btnTitle;
  final VoidCallback? press;
  final String image;
  final double width;
  final bool fullScreen;
  NotFound({
    this.showImage = true,
    this.aspecRatio = 1,
    this.title = "Oops...",
    this.body = "Data Not Found",
    this.btnTitle = "Try Again",
    this.press,
    this.image = "assets/images/error.png",
    this.width = 150,
    this.fullScreen = false,
  });
  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return Container(
        height: MediaQuery.of(context).size.height * .7,
        child: _center(),
      );
    }
    return _center();
  }

  Widget _center() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showImage == false
              ? Container()
              : Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: aspecRatio == 1
                      ? AspectRatio(
                          aspectRatio: 8,
                          child: Image.asset(
                            image,
                            height: width,
                            width: width,
                          ),
                        )
                      : Image.asset(
                          image,
                          height: width,
                          width: width,
                        ),
                ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textScaleFactor: 1.0,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            body,
            textScaleFactor: 1.0,
          ),
          TextButton(
            onPressed: () {
              press!();
            },
            child: Text(
              btnTitle,
              style: TextStyle(
                color: regular,
              ),
              textScaleFactor: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
