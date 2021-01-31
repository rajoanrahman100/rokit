import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/providers_class/provider_getUser.dart';
import 'package:rokit/providers_class/provider_sensor_data.dart';
import 'package:rokit/screens/deviceScreen/addedDoorDevicesList.dart';
import 'package:rokit/screens/profileScreen/createProfile.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/home_screen_gridView.dart';
import 'package:rokit/widget/loader_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rokit/screens/deviceScreen/addDevice.dart';

import 'deviceScreen/addedWindowDevices.dart';

class HomeScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderSensorData()),
        ChangeNotifierProvider(create: (_) => ProviderDevice()),
        ChangeNotifierProvider(create: (_) => ProviderUser()),
      ],
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FirebaseAuth _auth = FirebaseAuth.instance;

  var userID;

  final _formKey = GlobalKey<FormState>();

  var _controllerMacAddress = TextEditingController();
  var _editControllerMacAddress = TextEditingController();

  String _message = "";

  // registerToken() {
  //   _firebaseMessaging.getToken().then((value) {
  //     print("token:- $value");
  //   });
  // }

  getUserID() async {
    userID = _auth.currentUser.uid;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(KEY_USER_ID, userID);
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

  @override
  void initState() {
    // TODO: implement initState

    //getUserID();
     //getUserToken();
     getMessage();
  }

  @override
  Widget build(BuildContext context) {
    var providerSensorList = Provider.of<ProviderSensorData>(context, listen: false);
    var providerDevice = Provider.of<ProviderDevice>(context, listen: false);
    var providerUser = Provider.of<ProviderUser>(context, listen: false);

    //providerSensorList.getAllSensorsData();

    providerUser.getUserDetails();
    //providerDevice.getAddedDevices();

    return SafeArea(
      child: Scaffold(
        backgroundColor: appBack,
        body: Consumer<ProviderUser>(
          builder: (_, data, child) => data.userProfileModel != null
              ? data.userProfileModel.isSuccess == false
                  ? callCompleteProfileNavigator()
                  : SingleChildScrollView(
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
                                        CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Welcome, ${data.userProfileModel.data.name}",
                                          style: text_StyleRoboto(Colors.deepOrange, 18.0, FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                   Container(height: 30.0, width: 30.0,decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ]
                                    ),
                                      child: Center(child: Icon(Icons.notifications,color: headerColor,)),
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
                                      Text("Connected Devices",style: text_StyleRoboto(Colors.black, 16.0, FontWeight.bold),),
                                      Text("Click to see log and settings",style: text_StyleRoboto(Colors.grey, 14.0, FontWeight.w500),),
                                    ],
                                  ),
                                  IconButton(icon: Icon(Icons.more_horiz), onPressed:(){})
                                ],
                              ),
                            ),

                            SizedBox(height: 15.0,),

                            Row(
                              children: [

                                Expanded(

                                  child: GestureDetector(
                                    onTap: (){
                                      RouteGenerator.navigatePush(context, AddedDeviceScreen());
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
                                                    color: Color(0xFF3986FB),
                                                ),
                                                  child: Center(child: Image.asset("assets/door.png",height: 20.0,width: 20.0,)),
                                                ),

                                                SizedBox(height: 10.0,),

                                                Text("Door",style: text_StyleRoboto(appBack, 16.0, FontWeight.bold),),
                                                Text("Sensor",style: text_StyleRoboto(appBack, 16.0, FontWeight.bold),),
                                              ],
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                data.userProfileModel.data.doors.isEmpty?Text("${0}",style: text_StyleRoboto(appBack, 12.0, FontWeight.w500)):Text("${data.userProfileModel.data.doors.length}",style: text_StyleRoboto(appBack, 12.0, FontWeight.w500),),
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
                                          colors: [
                                            Color(0xFF0066FF),
                                            Color(0xFF164DAB),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 15.0,),

                                Expanded(

                                  child: GestureDetector(
                                    onTap: (){
                                      RouteGenerator.navigatePush(context, AddedWindowDeviceScreen());
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
                                                  color: Color(0xFF925FFB),
                                                ),
                                                  child: Center(child: Image.asset("assets/window.png",height: 20.0,width: 20.0,)),
                                                ),

                                                SizedBox(height: 10.0,),

                                                Text("Window",style: text_StyleRoboto(appBack, 16.0, FontWeight.bold),),
                                                Text("Sensor",style: text_StyleRoboto(appBack, 16.0, FontWeight.bold),),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                data.userProfileModel.data.windows.isEmpty?Text("${0}",style: text_StyleRoboto(appBack, 12.0, FontWeight.w500)):Text("${data.userProfileModel.data.windows.length}",style: text_StyleRoboto(appBack, 12.0, FontWeight.w500),),

                                                Icon(Icons.arrow_right_alt,color: appBack,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFF7836FF),
                                            Color(0xFF5318CB),
                                          ],
                                        ),
                                      ),
                                      ),
                                  ),
                                  ),


                              ],
                            ),

                            SizedBox(height: 15.0,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    RouteGenerator.navigatePush(context, AddDeviceScreen());
                                  },
                                  child: Container(height: 30.0, width: 30.0,decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: headerColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ]
                                  ),
                                    child: Center(child: Icon(Icons.add,color: Colors.white,)),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 15.0,),

                            Text("Available Devices",style: text_StyleRoboto(Colors.black, 16.0, FontWeight.bold),),

                            SizedBox(height: 15.0,),


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


                            // Text(data.userProfileModel.data.name),
                            // Text(data.userProfileModel.data.address),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     data.userProfileModel.data.windows.isEmpty?Text("Total Device: ${0}"):Text("Total Device: ${data.userProfileModel.data.windows.length}"),
                            //     GestureDetector(onTap: (){
                            //       RouteGenerator.navigatePush(context, AddedDeviceScreen());
                            //     },child: Text("See All"))
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                  )
              : showLoaderWidget(),
        ),

        // floatingActionButton: Consumer<ProviderDevice>(
        //   builder: (_, data, child) => data.deviceDataModel == null
        //       ? Container()
        //       : FloatingActionButton.extended(
        //           onPressed: () async {
        //             showModalBottomSheet(
        //               isScrollControlled: true,
        //               context: context,
        //               builder: (context) => Padding(
        //                 padding: MediaQuery.of(context).viewInsets,
        //                 child: Container(
        //                   height: 200.0,
        //                   child: Form(
        //                     key: _formKey,
        //                     child: Column(
        //                       mainAxisSize: MainAxisSize.min,
        //                       children: [
        //                         SizedBox(
        //                           height: 10.0,
        //                         ),
        //                         Text("Enter Device Mac Address"),
        //                         Padding(
        //                           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        //                           child: TextFormWidget(
        //                             hintText: "device mac address",
        //                             text: _controllerMacAddress.text,
        //                             validator: (String value) {
        //                               if (value.isEmpty) {
        //                                 return "your device mac address";
        //                               }
        //                               _formKey.currentState.save();
        //                               return null;
        //                             },
        //                             onSaved: (String value) {
        //                               _controllerMacAddress.text = value;
        //                             },
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: 15.0,
        //                         ),
        //                         RaisedButton(
        //                           onPressed: () async {
        //                             if (_formKey.currentState.validate()) {
        //                               await data.addDevices(_controllerMacAddress.text, context);
        //                               await data.getAddedDevices();
        //                               await data.notifyListeners();
        //                             }
        //                           },
        //                           child: Text("add device"),
        //                         ),
        //                         SizedBox(
        //                           height: 20.0,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //           label: Text('Add Device'),
        //           icon: Icon(Icons.devices),
        //           backgroundColor: Colors.deepOrange,
        //         ),
        // )
      ),
    );
  }

  callCreateProfilePage() {
    RouteGenerator.navigatePush(context, CreateProfileScreen());
  }

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

  Future signOut() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      setState(() async {
        await _auth.signOut();
        RouteGenerator.clearBackStack(context, SignInScreenRoute);
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _logOutAlert() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              title: Text("Do you want to logout from the app?"),
              actions: <Widget>[
                FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("No")),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, true);

                      signOut();
                    },
                    child: Text("Yes")),
              ],
            ));
  }
}
