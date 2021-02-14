import 'package:flutter/material.dart';
import 'package:rokit/utils/styles.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBack,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(color: backColor2),
            title: Text(
              "Edit Profile",
              style: text_StyleRoboto(backColor2, 18.0, FontWeight.w500),
            ),
            backgroundColor: appBack,
            actions: [
              Container(
                height: 25.0,
                width: 25.0,
                margin: EdgeInsets.only(right: 20.0),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
                child: Center(
                    child: Icon(
                  Icons.notifications,
                  color: Colors.black,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
