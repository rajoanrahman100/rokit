import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/providers_class/provider_sensor_data.dart';
import 'package:rokit/screens/deviceScreen/addDevice.dart';
import 'package:rokit/widget/custom_app_bar.dart';
import 'package:rokit/widget/loader_widget.dart';
import 'package:rokit/widget/no_data_found.dart';
import 'package:rokit/widget/text_formWidget.dart';

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
        appBar: RokkhiAppBar.basic(
          mTitle: "Added Device",
          iconThemeColor: Colors.deepOrangeAccent,
        ),
        body: Consumer<ProviderDevice>(
          builder: (_, data, child) => data.deviceDataModel == null
              ? showShimmerDesign(context)
              : data.deviceDataModel.data.length == 0
                  ? NoDataFoundWidget()
                  : ListView.builder(
                      itemCount: data.deviceDataModel.data.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(data.deviceDataModel.data[index].deviceName),
                        );
                      },
                    ),
        ),
        floatingActionButton: Consumer<ProviderDevice>(
          builder: (_, data, child) => data.deviceDataModel == null
              ? Container()
              : FloatingActionButton.extended(
                  onPressed: ()  async{
                    RouteGenerator.navigatePush(context, AddDeviceScreen());
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   context: context,
                    //   builder: (context) => Padding(
                    //     padding: MediaQuery.of(context).viewInsets,
                    //     child: Container(
                    //       height: 200.0,
                    //       child: Form(
                    //         key: _formKey,
                    //         child: Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             SizedBox(
                    //               height: 10.0,
                    //             ),
                    //             Text("Enter Device Mac Address"),
                    //             Padding(
                    //               padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    //               child: TextFormWidget(
                    //                 hintText: "device mac address",
                    //                 text: _controllerMacAddress.text,
                    //                 validator: (String value) {
                    //                   if (value.isEmpty) {
                    //                     return "your device mac address";
                    //                   }
                    //                   _formKey.currentState.save();
                    //                   return null;
                    //                 },
                    //                 onSaved: (String value) {
                    //                   _controllerMacAddress.text = value;
                    //                 },
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 15.0,
                    //             ),
                    //             RaisedButton(
                    //               onPressed: () async {
                    //                 if (_formKey.currentState.validate()) {
                    //                   await data.addDevices(_controllerMacAddress.text, context);
                    //                   await data.getAddedDevices();
                    //                   await data.notifyListeners();
                    //                 }
                    //               },
                    //               child: Text("add device"),
                    //             ),
                    //             SizedBox(
                    //               height: 20.0,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                  label: Text('Add Device'),
                  icon: Icon(Icons.devices),
                  backgroundColor: Colors.deepOrange,
                ),
        ));
  }
}
