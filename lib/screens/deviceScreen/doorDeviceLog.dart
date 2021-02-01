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
import 'package:rokit/widget/date_picker_dialog.dart';
import 'package:rokit/widget/loader_widget.dart';
import 'package:rokit/widget/month_picker_dialog.dart';
import 'package:rokit/widget/no_data_found.dart';

class DoorDevicesLogScreen extends StatelessWidget {
  String deviceMacAddress;
  String doorStatus;

  DoorDevicesLogScreen({this.deviceMacAddress, this.doorStatus});

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
      ),
    );
  }
}

class DoorDevicesLog extends StatelessWidget {
  String deviceMacAddress;
  String doorStatus;

  DoorDevicesLog({this.deviceMacAddress, this.doorStatus});

  DateTime selectedMonth = DateTime.now();

  String monthText="";
  String date_Text="";

  final DateFormat dateFormatMonth = DateFormat('MMM');
  final DateFormat dateFormat = DateFormat("d");


  var dateTime=DateTime.now();


  @override
  Widget build(BuildContext context) {
    var providerSensor = Provider.of<ProviderSensorData>(context, listen: false);

    providerSensor.getAllSensorsData(deviceMacAddress, doorStatus);

    print("$deviceMacAddress  $doorStatus");

    return Scaffold(
      backgroundColor: appBack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    height: 170.0,
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(color: backColor2, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Device Log",
                          style: text_StyleRoboto(Colors.white, 18.0, FontWeight.w500),
                        ),
                        Container(
                          height: 25.0,
                          width: 25.0,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.1),
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
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 130.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: MediaQuery.of(context).size.height / 1.2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        children: [

                          SizedBox(height: 20.0,),

                          Image.asset("assets/logs.png",height: 30.0,),

                          SizedBox(height: 10.0,),


                          Text("Dining Room Window Logs",style: text_StyleRoboto(backColor2, 16.0, FontWeight.w500),),

                          SizedBox(height: 20.0,),


                          Consumer<ProviderSensorData>(
                            builder:(_,data,child)=> Container(
                              height: 60.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Month  ",
                                        style: text_StyleRoboto(backColor2, 14.0, FontWeight.w500),
                                      ),
                                      Container(
                                        height: 30.0,
                                        child: RaisedButton(
                                          onPressed: (){
                                            showMonthPicker(context: context, firstDate: DateTime(DateTime.now().year - 1, 5), lastDate: DateTime(DateTime.now().year + 2, 9), initialDate: selectedMonth)
                                                .then((date) {
                                              if (date == null) {
                                                showErrorToast("No Month Picked");
                                                return;
                                              } else {
                                                monthText = dateFormatMonth.format(date).toString();
                                                data.setMonthDatePickerValue(monthText);
                                              }
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              data.monthDatePicker==null? Text(dateFormatMonth.format(DateTime.now()).toString()) :Text(data.monthDatePicker),
                                              Icon(Icons.arrow_drop_down_outlined,color: backColor2,)
                                            ],
                                          ),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              side:BorderSide(color: backColor2)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  SizedBox(width: 20.0,),


                                  Row(
                                    children: [
                                      Text(
                                        "Date  ",
                                        style: text_StyleRoboto(backColor2, 14.0, FontWeight.w500),
                                      ),
                                      Container(
                                        height: 30.0,
                                        child: RaisedButton(

                                          onPressed: (){
                                           showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2019, 1),
                                                lastDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,DateTime.now().hour,DateTime.now().minute)).then((value) {
                                                  date_Text=dateFormat.format(value).toString();

                                                  data.setStartDate(date_Text);

                                                  print("Date $date_Text");
                                           });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                             data.startDate==null ?Text("${DateTime.now().day}"):Text("${data.startDate}"),
                                              Icon(Icons.arrow_drop_down_outlined,color: backColor2,)
                                            ],
                                          ),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              side:BorderSide(color: backColor2)
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),

                          Container(height: 10.0,),

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
                                                              "${DateFormat.jm().format(DateTime.parse(data.sensorsListModel.data[index].createdDate))}",
                                                              style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400),
                                                            ),
                                                            Text(
                                                              data.sensorsListModel.data[index].doorStatus,
                                                              style: text_StyleRoboto(backColor2, 14.0, FontWeight.w400),
                                                            ),
                                                            Text(
                                                              data.sensorsListModel.data[index].batteryStatus,
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

                          SizedBox(height: 20.0,),

                          ButtonLog(imageData: "assets/clearLog.png",text: "  Clear Log",),
                          
                          SizedBox(height: 20.0,),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

