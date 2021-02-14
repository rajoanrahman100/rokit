import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/data_model/user_profile_model.dart';
import 'package:rokit/providers_class/apiServiceProvider.dart';
import 'package:rokit/providers_class/provider_getUser.dart';
import 'package:rokit/screens/deviceScreen/addDevice.dart';
import 'package:rokit/screens/profileScreen/createProfile.dart';
import 'package:rokit/utils/all_widgetClass.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/home_screen_gridView.dart';
import 'package:rokit/widget/loader_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'deviceScreen/addedDoorDevicesList.dart';
import 'deviceScreen/addedWindowDevices.dart';


class HomeScreenPageWithCache extends StatefulWidget {
  @override
  _HomeScreenPageWithCacheState createState() => _HomeScreenPageWithCacheState();
}

class _HomeScreenPageWithCacheState extends State<HomeScreenPageWithCache> {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var userID;
  String _message = "";
  String authToken;

  @override
  void initState() {
    // TODO: implement initState

   // getUserToken();
    getMessage();
  }

  getUserID() async {
    userID = _auth.currentUser.uid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_USER_ID, userID);
  }

  getUserToken() async {

   await _auth.currentUser.getIdToken().then((value) => debugPrint("$value"));

  }
  getMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _firebaseMessaging.getToken().then((value) async {
      print("token value $value");
      await prefs.setString(KEY_TOKEN_ID, value);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() {
          _message = message["notification"]["title"];
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() {
          _message = message["notification"]["title"];
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          _message = message["notification"]["title"];
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  ///Declare Api Provider for getting User
  ApiServiceProvider apiServiceProvider=ApiServiceProvider();

  /// data==null route to profile screen
  callCreateProfilePage() {
    RouteGenerator.navigatePush(context, CreateProfileScreen());
  }

  ///data==null call this widget
  Widget callCompleteProfileNavigator() {
    return new FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 0)).then((value) => callCreateProfilePage()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return emptyWidget(context);
      },
    );
  }

  Widget emptyWidget(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {


    print("Route Back");

    return Scaffold(
      backgroundColor: appBack,
      body: FutureBuilder<UserProfileModel>(
        future: apiServiceProvider.getUser(),
        builder: (context,snapshot){

          if(snapshot.hasData){
            Data data=snapshot.data.data;
            if(data.isActive==true){
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  CircleImagePlaceholder(imageData: data.imageUrl,radius: 30.0,),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    "Welcome, ${data.name}",
                                    style: text_StyleRoboto(Colors.deepOrange, 18.0, FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                //_logOutAlert();
                                //RouteGenerator.navigatePush(context, NotificationsScreen());
                              },
                              child: Container(
                                height: 30.0,
                                width: 30.0,
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
                                      color: headerColor,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Installed Devices",
                                  style: text_StyleRoboto(Colors.black, 16.0, FontWeight.bold),
                                ),
                                Text(
                                  "Click to see log and settings",
                                  style: text_StyleRoboto(Colors.grey, 14.0, FontWeight.w500),
                                ),
                              ],
                            ),
                            IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          HomeScreenDeviceUI(
                            imageAsset: "assets/door.png",
                            sensorTypeName: "Door",
                            length: data.devices.totalDoor??0,
                            callback: () {
                              RouteGenerator.navigatePush(context, AddedDeviceScreen());
                            },
                            backColor: Color(0xFF3986FB),
                            colors: [
                              Color(0xFF0066FF),
                              Color(0xFF164DAB),
                            ],
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          HomeScreenDeviceUI(
                            imageAsset: "assets/window.png",
                            sensorTypeName: "Window",
                            length: data.devices.totalWindow??0,
                            backColor: Color(0xFF0A5771),
                            callback: () {
                              RouteGenerator.navigatePush(context, AddedWindowDeviceScreen());
                            },
                            colors: [
                              Color(0xFF0A5771),
                              Color(0xFF03384A),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          RouteGenerator.navigatePush(context, AddDeviceScreen());
                        },
                        child: Container(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline,size: 25.0,),
                              Text(
                                " Add a new device",
                                style: text_StyleRoboto(Colors.black, 14.0, FontWeight.w500),
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Available Devices",
                        style: text_StyleRoboto(Colors.black, 16.0, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          children: List.generate(adminItemsGridView.length, (index) {
                            return HomeItemsNewUI(
                              homeScreenGridView: adminItemsGridView[index],
                              callback: () {
                                print("Index $index");
                              },
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            else{
              return CreateProfileScreen();
            }
          }
          else{
            return showLoaderWidget();
          }
        },
      ),
    );
  }
}
