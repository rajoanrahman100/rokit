import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/text_formWidget.dart';


///Button Log widget per devices
class ButtonLog extends StatelessWidget {

  var text;
  var imageData;
  VoidCallback onTap;

  ButtonLog({this.text,this.imageData,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 30.0,
        width: 170.0,
        decoration: BoxDecoration(color: btnLogColor, borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imageData,height: 15.0,),
              Text(
                text,
                style: text_StyleRoboto(Colors.white, 14.0, FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



///Per device info dialog if any device is clicked
Widget showAlertDialog(context, {deviceName, deviceNetwork, deviceMac, status, batteryStatus}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Stack(alignment: Alignment.topRight, overflow: Overflow.visible, children: [
          Positioned(
            top: -20,
            child: IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: Icon(
                  Icons.cancel,
                  color: backColor2,
                  size: 35.0,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
          Container(
            height: 240.0,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [

                SizedBox(height: 10.0,),

                Text(
                  deviceName,
                  style: text_StyleRoboto(backColor2, 16.0, FontWeight.w500),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/wi-fi.png",
                            height: 12.0,
                          ),
                          Text("  Network", style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400)),
                        ],
                      ),
                      Text(deviceNetwork, style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 40.0,
                  color: Colors.blueGrey[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/connection.png",
                            height: 12.0,
                          ),
                          Text("  Last Beacon Status", style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400)),
                        ],
                      ),
                      Text(status, style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/battery.png",
                            height: 12.0,
                            width: 20.0,
                          ),
                          Text("  Battery Health", style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400)),
                        ],
                      ),
                      Text(batteryStatus, style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 40.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  color: Colors.blueGrey[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/macAddress.png",
                            height: 12.0,
                          ),
                          Text("  Mac Address", style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400)),
                        ],
                      ),
                      Text(deviceMac, style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ));
}



///Home Screen device type widget class
class HomeScreenDeviceUI extends StatelessWidget {

  String imageAsset;
  String sensorTypeName;
  int length;
  VoidCallback callback;
  List<Color> colors;
  Color backColor;

  HomeScreenDeviceUI({this.imageAsset,this.sensorTypeName,this.length,this.callback,this.colors, this.backColor});


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          callback();
        },
        child: Container(
          height: 200.0,
          padding: EdgeInsets.all(15.0),

          child: Stack(
            children: [

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 35.0, width: 35.0,decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: backColor,
                    ),
                      child: Center(child: Image.asset(imageAsset,height: 20.0,width: 20.0,)),
                    ),
                    SizedBox(height: 10.0,),
                    Text(sensorTypeName,style: text_StyleRoboto(appBack, 16.0, FontWeight.bold),),
                    Text("Sensor",style: text_StyleRoboto(appBack, 16.0, FontWeight.bold),),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(" $length",style: text_StyleRoboto(appBack, 12.0, FontWeight.w500),),
                    Icon(Icons.arrow_right_alt,color: appBack,)
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
          ),
        ),
      ),
    );
  }
}

///Circle Image with placeholder
// ignore: must_be_immutable
class CircleImagePlaceholder extends StatelessWidget {

  String imageData;
  double radius;

  CircleImagePlaceholder({this.imageData,this.radius});

  @override
  Widget build(BuildContext context) {
    return CircularProfileAvatar(
      imageData, //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
      radius: radius,
      placeHolder: (context, url) => Image.asset("assets/spinner.gif",height: 15,),
      errorWidget: (context,url,error)=>Icon(Icons.error_outline,size: 20.0,),
      backgroundColor: Colors.white,
      borderWidth: 1,
      borderColor: Colors.black54,
      elevation: 5.0,
      foregroundColor: Colors.brown.withOpacity(0.5),
      cacheImage: true,
      showInitialTextAbovePicture: false, // setting it true will show initials text above profile picture, default false
    );
  }
}






