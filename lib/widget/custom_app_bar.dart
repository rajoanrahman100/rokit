import 'package:flutter/material.dart';
import 'package:rokit/utils/styles.dart';

import 'custom_text_view.dart';

class RokkhiAppBar extends AppBar {
  String mTitle;
  TextStyle mTitleTextStyle;
  List<Widget> mAction;
  Widget mLeading;
  Color backColor;
  Color iconThemeColor;

  /*
  /// this is just a sample of appBar. customize appBar with named param like
  /// with default constructor.name()
   */
  RokkhiAppBar(
      {this.mTitle,
      this.mTitleTextStyle,
      this.mAction,
      this.mLeading,
      this.backColor,this.iconThemeColor})
      : super(
            leading: mLeading != null ? mLeading : null,
            elevation: 1.0,
            backgroundColor: backColor,
            iconTheme:IconThemeData(color: iconThemeColor),
            title: CustomText.small(mTitle != null ? mTitle : appName,
                textStyle: mTitleTextStyle != null
                    ? mTitleTextStyle
                    : TextStyle(
                        color: appDefaultColor, fontSize: 22.00)),
            actions: mAction);

  RokkhiAppBar.basic({this.mTitle,this.iconThemeColor,this.mAction,})
      : super(
      iconTheme:IconThemeData(color: iconThemeColor),
          title: CustomText.small(mTitle != null ? mTitle : appName,
              textStyle: TextStyle(
                  color: appDefaultColor, fontSize: 17.00)),
          elevation: 1.0,
          backgroundColor: Colors.white,
      actions: mAction
        );
}
