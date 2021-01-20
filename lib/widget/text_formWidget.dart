import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rokit/utils/styles.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixText;
  final Widget suffix;
  final Function onChanged;
  final Function validator;
  TextInputType textInputType;
  final double height;
  final num maxLines;
  final bool obsecureText;
  final List<TextInputFormatter> inputFormatter;


  TextFormWidget(
      {this.controller, this.hintText, this.prefixText, this.suffix, this.onChanged, this.validator, this.textInputType, this.height, this.maxLines, this.obsecureText, this.inputFormatter});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == null ? 65.0 : height,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          //color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        maxLines: maxLines == null ? 1 : maxLines,
        keyboardType: textInputType == null ? TextInputType.text : textInputType,
        inputFormatters: inputFormatter,
        onChanged: onChanged,
        validator: validator,

        //inputFormatters: inputFormatter==null?[FilteringTextInputFormatter.singleLineFormatter]:,

        decoration: new InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow, width: 2.0),
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
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            disabledBorder: InputBorder.none,
            prefixText: prefixText == null ? "" : prefixText,
            suffix: suffix == null ? Text("") : suffix,
            contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintStyle: text_StyleRoboto(Colors.grey, 14.0, FontWeight.normal),
            hintText: hintText),
      ),
    );
  }
}
