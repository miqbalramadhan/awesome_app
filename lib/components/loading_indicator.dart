import 'package:awesome_app/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool fullScreen;
  LoadingIndicator({this.fullScreen = false});
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
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(regular),
      ),
    );
  }
}
