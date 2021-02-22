import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/getX_class/homeController.dart';
import 'package:rokit/screens/deviceScreen/addDevice.dart';
import 'package:rokit/screens/deviceScreen/addedDoorDevicesList.dart';
import 'package:rokit/screens/deviceScreen/addedWindowDevices.dart';
import 'package:rokit/screens/profileScreen/createProfile.dart';
import 'package:rokit/utils/all_widgetClass.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/homeAppBarWidget.dart';
import 'package:rokit/widget/home_screen_gridView.dart';
import 'package:rokit/widget/loader_widget.dart';

class HomeScreenWithGetx extends StatefulWidget {

  @override
  _HomeScreenWithGetxState createState() => _HomeScreenWithGetxState();
}

class _HomeScreenWithGetxState extends State<HomeScreenWithGetx> {
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Obx(() {
            return controller.postloading.value
                ? showLoaderWidget()
                : controller.userProfileModel.value.data.isActive==false?CreateProfileScreen() :SingleChildScrollView(
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
                                      CircleImagePlaceholder(
                                        imageData: controller.userProfileModel.value.data.imageUrl,
                                        radius: 30.0,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Welcome, ${controller.userProfileModel.value.data.name}",
                                        style: text_StyleRoboto(Colors.deepOrange, 18.0, FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // _logOutAlert(context);
                                    //RouteGenerator.navigatePush(context, NotificationsScreen());
                                  },
                                  child: HomeAppBarWidgets(
                                    iconData: Icons.logout,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    signOut(context);
                                    //_logOutAlert();
                                    //RouteGenerator.navigatePush(context, NotificationsScreen());
                                  },
                                  child: HomeAppBarWidgets(
                                    iconData: Icons.notifications,
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
                                length: controller.totalDoor.value ?? 0,
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
                                length: controller.userProfileModel.value.data.devices.totalWindow ?? 0,
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
                            onTap: () {
                              RouteGenerator.navigatePush(context, AddDeviceScreen());
                            },
                            child: Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 25.0,
                                  ),
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
                            height: 10.0,
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
          }))
        ],
      ),
    );
  }

  Future signOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut().whenComplete(() => RouteGenerator.clearBackStack(context, SignInScreenRoute));
  }
}
