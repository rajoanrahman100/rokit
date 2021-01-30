import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/providers_class/provider_sensor_data.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/loader_widget.dart';
import 'package:rokit/widget/no_data_found.dart';

class AddedDeviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderSensorData()),
        ChangeNotifierProvider(create: (_) => ProviderDevice()),
      ],
      child: AddedDevice(),
    );
  }
}

class AddedDevice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var providerDevice = Provider.of<ProviderDevice>(context, listen: false);

    providerDevice.getAddedDevices();

    final _formKey = GlobalKey<FormState>();

    var _controllerMacAddress = TextEditingController();

    return Scaffold(
        backgroundColor: appBack,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: 150.0,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 30.0),
                  decoration: BoxDecoration(color: backColor2, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Device List",
                        style: text_StyleRoboto(Colors.white, 18.0, FontWeight.w500),
                      ),
                      Container(
                        height: 25.0,
                        width: 25.0,
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
                Consumer<ProviderDevice>(
                  builder: (_, data, child) => data.deviceDataModel == null
                      ? showShimmerDesign(context)
                      : data.deviceDataModel.data.length == 0
                          ? NoDataFoundWidget()
                          : Expanded(
                              child: ListView.builder(
                                itemCount: data.deviceDataModel.data.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                                    height: 110.0,
                                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0), boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ]),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/window2.png",
                                                    height: 14.0,
                                                    width: 14.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    "${data.deviceDataModel.data[index].deviceMacAddress}",
                                                    style: text_StyleRoboto(backColor2, 14.0, FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "CLOSE",
                                                    style: text_StyleRoboto(Colors.red, 10.0, FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Image.asset(
                                                    "assets/batery.png",
                                                    height: 20.0,
                                                    width: 18.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    "80%",
                                                    style: text_StyleRoboto(backColor2, 14.0, FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),

                                        SizedBox(height: 30.0,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 30.0,
                                              width: 100.0,
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                color: Color(0xFF4F6772),
                                                onPressed: () {},
                                                child: Text(
                                                  "Setting",
                                                  textAlign: TextAlign.center,
                                                  style: text_StyleRoboto(Colors.white, 14.0, FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              height: 30.0,
                                              width: 100.0,
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                color: Color(0xFF4F6772),
                                                onPressed: () {},
                                                child: Text(
                                                  "Log",
                                                  textAlign: TextAlign.center,
                                                  style: text_StyleRoboto(Colors.white, 14.0, FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                  // return ListTile(
                                  //   title: Text("Name: ${data.deviceDataModel.data[index].deviceMacAddress}"),
                                  //   subtitle: Text("Name: ${data.deviceDataModel.data[index].deviceType}"),
                                  //   trailing: IconButton(
                                  //       icon: Icon(Icons.delete_forever),
                                  //       onPressed: () async {
                                  //         await data.deleteDevice(data.deviceDataModel.data[index].id, context);
                                  //         await data.getAddedDevices();
                                  //       }),
                                  // );
                                },
                              ),
                            ),
                )
              ],
            ),
          ),
        ));
  }
}

// Consumer<ProviderDevice>(
// builder: (_, data, child) => data.deviceDataModel == null
// ? showShimmerDesign(context)
// : data.deviceDataModel.data.length == 0
// ? NoDataFoundWidget()
//     : ListView.builder(
// itemCount: data.deviceDataModel.data.length,
// itemBuilder: (_, index) {
// return ListTile(
// title: Text("Name: ${data.deviceDataModel.data[index].deviceMacAddress}"),
// subtitle: Text("Name: ${data.deviceDataModel.data[index].deviceType}"),
// trailing: IconButton(icon: Icon(Icons.delete_forever), onPressed: ()async{
// await data.deleteDevice(data.deviceDataModel.data[index].id,context);
// await data.getAddedDevices();
//
// }),
// );
// },
// ),
// )
