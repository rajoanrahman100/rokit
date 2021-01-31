import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/screens/deviceScreen/pinTextField.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/dop_downList.dart';
import 'package:rokit/widget/text_formWidget.dart';

class AddDeviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => ProviderSensorData()),
        ChangeNotifierProvider(create: (_) => ProviderDevice()),
      ],
      child: AddDevice(),
    );
  }
}

class AddDevice extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var _deviceNameController = TextEditingController();
  var _deviceMacAddressController = TextEditingController();
  var _deviceAuthorCodeController = TextEditingController();

  TextEditingController _pinEditingController = TextEditingController();

  PinDecoration _pinDecoration = BoxLooseDecoration(enteredColor: Colors.deepOrange, hintText: '--------');

  String tyName = "";

  List<String> types = ["WINDOW", "DOOR"];

  @override
  Widget build(BuildContext context) {
    var providerDevice = Provider.of<ProviderDevice>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appBack,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      height: 150.0,
                      color: backColor2,
                    ),
                    Positioned(
                      top: 60.0,
                      bottom: 40.0,
                      left: 20.0,
                      right: 20.0,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Container(
                            //height: 550.0,
                            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30.0,
                                      width: 30.0,
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: backColor2, boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ]),
                                      child: Center(
                                          child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Add New Device",
                                      style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "Device Type",
                                  style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                DropDownField(
                                    value: tyName,
                                    filledColor: backColor2,
                                    hintText: "Select Device Type",
                                    hintStyle: text_StyleRoboto(Colors.white, 16.0, FontWeight.w400),
                                    textStyle: text_StyleRoboto(Colors.white, 16.0, FontWeight.w500),
                                    items: types,
                                    required: true,
                                    strict: true,
                                    setter: (newValue) {
                                      tyName = newValue;
                                    }),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "Mac Address",
                                  style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormWidget(
                                  text: _deviceMacAddressController.text,
                                  isEmail: true,
                                  hintText: "eg. mac address",
                                  hintStyle: text_StyleRoboto(Colors.grey, 16.0, FontWeight.w400),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Enter Your Mac Address";
                                    }

                                    _formKey.currentState.save();
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _deviceMacAddressController.text = value;
                                  },
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "Authorization Code",
                                  style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                PinInputTextField(
                                  pinLength: 8,
                                  decoration: _pinDecoration,
                                  controller: _pinEditingController,
                                  autoFocus: false,
                                  textInputAction: TextInputAction.done,
                                  onSubmit: (pin) {
                                    if (pin.length == 8) {
                                    } else {
                                      print("Invalidate OTP");

                                      ///Error toast will show here
                                      // showErrorToast("Invalid OTP");
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "Device Name",
                                  style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormWidget(
                                  text: _deviceNameController.text,
                                  isEmail: true,
                                  hintText: "eg. door 1",
                                  hintStyle: text_StyleRoboto(Colors.grey, 16.0, FontWeight.w400),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Enter Your Mac Address";
                                    }

                                    _formKey.currentState.save();
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    _deviceNameController.text = value;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState.validate()) {
                                      print("Type Name $tyName");
                                      providerDevice.addDevices(context, _deviceMacAddressController.text, tyName, _pinEditingController.text);
                                    }
                                  },
                                  child: Container(
                                    height: 50.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFFFF7957),
                                          Color(0xFFEF2F00),
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      "ADD",
                                      style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(decoration: TextDecoration.underline, color: headerColor, fontSize: 18.0),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
