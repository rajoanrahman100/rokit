import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/providers_class/provider_sensor_data.dart';
import 'package:rokit/utils/all_widgetClass.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:rokit/widget/loader_widget.dart';
import 'package:rokit/widget/no_data_found.dart';

class DoorDevicesLogScreen extends StatelessWidget {
  String deviceMacAddress;
  String doorStatus;
  String deviceName;

  DoorDevicesLogScreen({this.deviceMacAddress, this.doorStatus, this.deviceName});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderSensorData()),
        ChangeNotifierProvider(create: (_) => ProviderDevice()),
      ],
      child: DoorDevicesLog(
        deviceMacAddress: deviceMacAddress,
        doorStatus: doorStatus,
        deviceName: deviceName,
      ),
    );
  }
}

class DoorDevicesLog extends StatefulWidget {
  String deviceMacAddress;
  String doorStatus;
  String deviceName;

  DoorDevicesLog({this.deviceMacAddress, this.doorStatus, this.deviceName});

  @override
  _DoorDevicesLogState createState() => _DoorDevicesLogState();
}

class _DoorDevicesLogState extends State<DoorDevicesLog> {
  DateTime selectedMonth = DateTime.now();

  String monthText = "";

  String endDateText = "";
  String startDateText = "";

  final DateFormat dateFormatMonth = DateFormat('MMM');

  final DateFormat dateFormat = DateFormat("d");

  var dateTime = DateTime.now();

  String currentTime;

  @override
  void initState() {
    currentTime = DateFormat.yMd().format(dateTime).toString();

    print("Current Time $currentTime");
  }

  @override
  Widget build(BuildContext context) {
    var providerSensor = Provider.of<ProviderSensorData>(context, listen: false);

    providerSensor.getAllSensorsData(widget.deviceMacAddress, widget.doorStatus, currentTime, currentTime);

    print("${widget.deviceMacAddress}  ${widget.doorStatus}");

    return Scaffold(
      backgroundColor: appBack,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),

        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(color: backColor2),
            title: Text("Device Log", style: text_StyleRoboto(backColor2, 18.0, FontWeight.w500),),
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
          margin: EdgeInsets.only(left: 18.0, right: 18.0, top: 20.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          height: MediaQuery.of(context).size.height / 1.2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Image.asset(
                "assets/logs.png",
                height: 30.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                " ${widget.deviceName}",
                style: text_StyleRoboto(backColor2, 16.0, FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              Consumer<ProviderSensorData>(
                builder: (_, data, child) => Container(
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "From  ",
                            style: text_StyleRoboto(backColor2, 14.0, FontWeight.w500),
                          ),
                          Container(
                            height: 30.0,
                            child: RaisedButton(
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2019, 1),
                                    lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute))
                                    .then((value) {
                                  if (value == null) {
                                    startDateText = endDateText;
                                    data.setStartDate(currentTime);
                                    print("Start Date $currentTime");
                                    //showErrorToast("No Date Select");
                                    return;
                                  } else {
                                    startDateText = DateFormat.yMd().format(value).toString();
                                    data.setStartDate(startDateText);

                                    providerSensor.sensorsListModel == null
                                        ? showSuccessToast("Sensor log data is loading....")
                                        : providerSensor.getAllSensorsData(widget.deviceMacAddress, widget.doorStatus, startDateText, endDateText);

                                    print("Start Date $startDateText");
                                    return;
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  data.startDate == null ? Text(currentTime) : Text(data.startDate),
                                  Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: backColor2,
                                  )
                                ],
                              ),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: backColor2)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "To  ",
                            style: text_StyleRoboto(backColor2, 14.0, FontWeight.w500),
                          ),
                          Container(
                            height: 30.0,
                            child: RaisedButton(
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2019, 1),
                                    lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute))
                                    .then((value) {
                                  if (value == null) {
                                    showErrorToast("No Date Select");
                                    return;
                                  } else {
                                    endDateText = DateFormat.yMd().format(value).toString();

                                    data.setEndDate(endDateText);

                                    data.sensorsListModel == null
                                        ? showSuccessToast("Sensor data is loading..")
                                        : data.getAllSensorsData(widget.deviceMacAddress, widget.doorStatus, startDateText, endDateText);

                                    print("End Date $endDateText  Start Date $startDateText");

                                    return;
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  data.endDate == null ? Text("$currentTime") : Text("${data.endDate}"),
                                  Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: backColor2,
                                  )
                                ],
                              ),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: backColor2)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " Time",
                    style: text_StyleRoboto(backColor2, 16.0, FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45.0),
                    child: Text(
                      "Event",
                      style: text_StyleRoboto(backColor2, 16.0, FontWeight.bold),
                    ),
                  ),
                  Text(
                    "  Battery",
                    style: text_StyleRoboto(backColor2, 16.0, FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: Consumer<ProviderSensorData>(
                    builder: (_, data, child) => data.sensorsListModel == null
                        ? showShimmerDesign(context)
                        : data.sensorsListModel.data.length == 0
                        ? NoDataFoundWidget()
                        : Container(
                      child: ListView.builder(
                        itemCount: data.sensorsListModel.data.length,
                        itemBuilder: (_, index) {
                          return Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        " ${DateFormat.jm().format(DateTime.parse(data.sensorsListModel.data[index].createdDate))}",
                                        style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400),
                                      ),
                                      Text(
                                        data.sensorsListModel.data[index].status,
                                        style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400),
                                      ),
                                      Text(
                                        "${data.sensorsListModel.data[index].batteryStatus} ",
                                        style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: backColor2,
                                )
                              ],
                            ),
                          );
                          // return ListTile(
                          //   title: Text("${DateFormat('EEE, MMM d').add_jm().format(DateTime.parse(data.sensorsListModel.data[index].createdDate))}"),
                          // );
                        },
                      ),
                    )),
              ),
              // SizedBox(
              //   height: 20.0,
              // ),
              // ButtonLog(
              //   imageData: "assets/clearLog.png",
              //   text: "  Clear Log",
              // ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        )
    );
  }
}
