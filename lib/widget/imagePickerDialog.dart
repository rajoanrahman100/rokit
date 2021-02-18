import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rokit/utils/styles.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget showAlertDialogImageChoose(BuildContext context, Future<dynamic> callbackCapture(), Future<dynamic> callbackGallery()) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Stack(children: <Widget>[
                    Container(
                      height: 80.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                callbackCapture();
                                Navigator.pop(context);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/camera.png",
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Camera",
                                    style: text_StyleRoboto(Colors.black, 14.0, FontWeight.w500),
                                  )
                                ],
                              )),
                          GestureDetector(
                              onTap: () {
                                callbackGallery();
                                Navigator.pop(context);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/gallery.png",
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Gallery",
                                    style: text_StyleRoboto(Colors.black, 14.0, FontWeight.w500),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ));
      });
}


Widget showImageChoose(BuildContext context, Future<dynamic> callbackCapture(), Future<dynamic> callbackGallery()) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))),
    isDismissible: true,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
        height: 130.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                callbackCapture();
              },
              child: Row(
                children: [
                  Image.asset("assets/cam.png",height: 20,width: 20.0,),
                  SizedBox(width: 15.0,),
                  Text("Camera",style: text_StyleRoboto(headerColor, 16.0, FontWeight.w500),)
                ],
              ),
            ),

            SizedBox(height: 15.0,),

            GestureDetector(
              onTap: (){
                callbackGallery();
              },
              child: Row(
                children: [
                  Image.asset("assets/gallery.png",height: 20,width: 20.0,),
                  SizedBox(width: 15.0,),
                  Text("Gallery",style: text_StyleRoboto(headerColor, 16.0, FontWeight.w500),)
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
