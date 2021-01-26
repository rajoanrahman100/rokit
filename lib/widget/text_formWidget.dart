import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rokit/utils/styles.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixText;
  final Widget suffix;
  final Widget prefix;
  final Function onChanged;
  final Function validator;
  TextInputType textInputType;
  final double height;
  final num maxLines;
  final bool obsecureText;
  final bool isPassword;
  final bool isEmail;
  final bool isNumber;
  final Widget icon;
  final String errorText;
  final TextStyle hintStyle;
  final List<TextInputFormatter> inputFormatter;
  final String text;

  TextFormWidget(
      {this.controller,
      this.hintText,
      this.prefixText,
      this.suffix,
      this.prefix,
      this.onChanged,
      this.validator,
      this.textInputType,
      this.height,
      this.maxLines,
      this.obsecureText,
      this.isPassword = false,
      this.isEmail = false,
      this.isNumber = false,
      this.icon,
      this.errorText,
      this.hintStyle,
      this.inputFormatter,
      this.text});

  @override
  Widget build(BuildContext context) {
    TextInputType textInputType;

    if (isEmail) {
      textInputType = TextInputType.emailAddress;
    } else if (isNumber) {
      textInputType = TextInputType.number;
    } else {
      textInputType = TextInputType.text;
    }

    return TextFormField(
      initialValue: text,
      controller: controller,
      cursorColor: Colors.black,
      maxLines: maxLines == null ? 1 : maxLines,
      keyboardType: textInputType,
      inputFormatters: inputFormatter,
      onChanged: onChanged,
      validator: validator,
      obscureText: isPassword ? true : false,
      decoration: new InputDecoration(
          errorText: errorText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black87,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(14.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(14.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(14.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(14.0),
            ),
          ),
          disabledBorder: InputBorder.none,
          prefixIcon: prefix,
          suffix: suffix == null ? Text("") : suffix,
          suffixIcon: icon == null ? null : icon,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          hintStyle: text_StyleRoboto(Colors.grey, 16.0, FontWeight.w400),
          hintText: hintText),
    );
  }
}
