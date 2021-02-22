import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/utils/all_widgetClass.dart';
import 'package:rokit/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceNotificationScreen extends StatelessWidget {
  var id;
  var deviceName;

  DeviceNotificationScreen({this.id, this.deviceName});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderDevice()),
      ],
      child: DeviceNotification(id: id, deviceName: deviceName),
    );
  }
}

class DeviceNotification extends StatefulWidget {
  var id;
  var deviceName;

  DeviceNotification({this.id, this.deviceName});

  @override
  _DeviceNotificationState createState() => _DeviceNotificationState();
}

class _DeviceNotificationState extends State<DeviceNotification> {
  bool isSwitched = false;
  bool isSwitchedEmergency = false;
  bool startPressed = false;
  bool endPressed = false;

  var startTime;
  var endTime;

  var sharedStart;
  var sharedEnd;

  DateTime selectedTimeDateTime;
  DateTime endTimeDateTime;


  showSharedPrefData()async{
    var prefs=await SharedPreferences.getInstance();

    setState(() {
      sharedStart=prefs.get("start time");
      sharedEnd=prefs.get("end time");
      print("start time ${prefs.get("start time")}") ;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    showSharedPrefData();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> callBack() {
      Navigator.pop(context, true);
    }

    var providerDevice = Provider.of<ProviderDevice>(context, listen: false);

    return WillPopScope(
      onWillPop: () => callBack(),
      child: Scaffold(
        backgroundColor: appBack,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(color: backColor2),
              title: Text(
                "${widget.deviceName}",
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  //height: MediaQuery.of(context).size.height / 1.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Image.asset(
                        "assets/alertSetting.png",
                        height: 30,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Notification and Alert Settings",
                        style: text_StyleRoboto(backColor2, 16.0, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        decoration: BoxDecoration(color: appBack, borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.notifications,
                                      color: backColor2,
                                      size: 16.0,
                                    ),
                                    Text(
                                      " Notification for this device",
                                      style: text_StyleRoboto(backColor2, 14.0, FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Switch(
                                      value: isSwitched,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                        });
                                      },
                                      activeTrackColor: Colors.green,
                                      activeColor: Colors.green,
                                    ),
                                    isSwitched
                                        ? Text(
                                            "Enable",
                                            style: text_StyleRoboto(Colors.green, 14.0, FontWeight.bold),
                                          )
                                        : Text(
                                            "Disable",
                                            style: text_StyleRoboto(Colors.red, 14.0, FontWeight.bold),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.notifications,
                                      color: backColor2,
                                      size: 16.0,
                                    ),
                                    Text(
                                      " Notification time period",
                                      style: text_StyleRoboto(backColor2, 14.0, FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    " Set a period for notification for this device",
                                    style: text_StyleRoboto(Colors.grey, 12.0, FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            " Start ",
                                            style: text_StyleRoboto(backColor2, 14.0, FontWeight.w500),
                                          ),
                                          GestureDetector(
                                            onTap: () async{
                                              startPressed = true;

                                              var prefs=await SharedPreferences.getInstance();

                                              DatePicker.showTime12hPicker(context, showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
                                                setState(() {
                                                  selectedTimeDateTime = date;
                                                  var fromTime=DateFormat.jm().format(selectedTimeDateTime).toString();
                                                  startTime = DateFormat('Hms').format(selectedTimeDateTime).toString();
                                                  prefs.setString("start time", fromTime);
                                                  print("Start Time $fromTime");
                                                });
                                              }, currentTime: DateTime(2008, 12, 31, 23, 12, 34));
                                            },
                                            child: Container(
                                              height: 25.0,
                                              width: 70.0,
                                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                                              color: Colors.grey[200],
                                              child: Center(child:  Text(" $sharedStart ")),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "End ",
                                            style: text_StyleRoboto(backColor2, 14.0, FontWeight.w500),
                                          ),
                                          GestureDetector(
                                            onTap: () async{
                                              endPressed = true;

                                              var prefs=await SharedPreferences.getInstance();


                                              DatePicker.showTime12hPicker(context, showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
                                                setState(() {
                                                  endTimeDateTime = date;
                                                  var toTime=DateFormat.jm().format(endTimeDateTime).toString();

                                                  endTime = DateFormat('Hms').format(endTimeDateTime).toString();

                                                  prefs.setString("end time", toTime);
                                                  print("End Time $endTime");
                                                  providerDevice.setNotificationTime(startTime, endTime);
                                                });
                                              }, currentTime: DateTime(2008, 12, 31, 23, 12, 34));
                                            },
                                            child: Container(
                                              height: 25.0,
                                              width: 70.0,
                                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                                              color: Colors.grey[200],
                                              child: Center(
                                                child: Text("$sharedEnd"),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.notifications_active,
                                      color: backColor2,
                                      size: 16.0,
                                    ),
                                    Text(
                                      " Emergency alert for this device",
                                      style: text_StyleRoboto(backColor2, 14.0, FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    " Enable if you want to get emergency alert",
                                    style: text_StyleRoboto(Colors.grey, 12.0, FontWeight.w500),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Switch(
                                      value: isSwitchedEmergency,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitchedEmergency = value;
                                        });
                                      },
                                      activeTrackColor: Colors.green,
                                      activeColor: Colors.green,
                                    ),
                                    isSwitchedEmergency
                                        ? Text(
                                            "Enable",
                                            style: text_StyleRoboto(Colors.green, 14.0, FontWeight.bold),
                                          )
                                        : Text(
                                            "Disable",
                                            style: text_StyleRoboto(Colors.red, 14.0, FontWeight.bold),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        decoration: BoxDecoration(color: appBack, borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Device Maintenance Guide for User  ",
                              style: text_StyleRoboto(backColor2, 14.0, FontWeight.w500),
                            ),
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              color: backColor2,
                              size: 18.0,
                            )
                          ],
                        ),
                      ),

                      // Consumer<ProviderDevice>(
                      //   builder: (_, data, child) => ButtonLog(
                      //     onTap: () {
                      //       data.deleteDevice(widget.id, context);
                      //       print("Device ID: ${widget.id}");
                      //     },
                      //     imageData: "assets/deletDevice.png",
                      //     text: "  Delete This Device",
                      //   ),
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
