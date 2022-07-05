import 'package:awesome_app/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class RegularTextField extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final FilteringTextInputFormatter? textInputFormatter;
  final TextInputFormatter? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSaved;
  final Function? onSubmitted;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;
  final String? labelText;
  final bool? enabled;
  final InputDecoration? decoration;
  final Widget? suffixIcon;
  final bool? readOnly;
  double? width;
  RegularTextField({
    Key? key,
    this.width,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.textInputFormatter,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.labelText,
    this.enabled,
    this.decoration,
    this.suffixIcon,
    this.readOnly,
    this.onSubmitted,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    if (suffixIcon != null) {
      return _textFieldWithIcon();
    }
    return Container(
      // height: height * 0.1,
      child: TextFormField(
        autofocus: false,
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        enabled: enabled,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        cursorColor: regular,
        maxLines: maxLines == null ? 1 : maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: width! * 0.025, horizontal: width! * 0.025),
          labelText: labelText,
          labelStyle:
              TextStyle(color: focusNode!.hasFocus ? regular : Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: regular, width: 1.0),
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
        ),
      ),
    );
  }

  Widget _textFieldWithIcon() {
    return Container(
      // height: height * 0.1,
      child: TextFormField(
        autofocus: false,
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        enabled: enabled,
        keyboardType: keyboardType,
        cursorColor: regular,
        maxLines: maxLines == null ? 1 : maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: width! * 0.025, horizontal: width! * 0.025),
          labelText: labelText,
          labelStyle:
              TextStyle(color: focusNode!.hasFocus ? regular : Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: regular, width: 1.0),
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          suffixIcon: suffixIcon == null
              ? Container(
                  width: 0,
                  height: 0,
                )
              : suffixIcon,
        ),
      ),
    );
  }
}
