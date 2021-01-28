import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/screens/deviceScreen/pinTextField.dart';
import 'package:rokit/utils/styles.dart';
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

  var _deviceTypeController=TextEditingController();
  var _deviceMacAddressController=TextEditingController();
  var _deviceAuthorCodeController=TextEditingController();

  TextEditingController _pinEditingController = TextEditingController();



  PinDecoration _pinDecoration = BoxLooseDecoration(enteredColor: Colors.deepOrange, hintText: '--------');


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
                      color: headerColor,
                    ),
                    Positioned(
                      top: 80.0,
                      bottom: 80.0,
                      left: 20.0,
                      right: 20.0,
                      child: Form(
                        key: _formKey,
                        child: Container(

                          padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Add New Device",style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),),
                                ],
                              ),

                              SizedBox(height:60.0 ,),

                              Text("Device Type",style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),),
                              SizedBox(height:10.0 ,),

                              TextFormWidget(
                                height: 50,
                                text: _deviceTypeController.text,
                                isEmail: true,
                                hintText: "eg. Dhanmondi,dhaka",
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Enter Your Address";
                                  }

                                  _formKey.currentState.save();
                                  return null;
                                },

                                onSaved: (String value){
                                  _deviceTypeController.text=value;
                                },
                              ),

                              SizedBox(height:30.0 ,),


                              Text("Mac Address",style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),),
                              SizedBox(height:10.0 ,),

                              TextFormWidget(
                                height: 50,
                                text: _deviceMacAddressController.text,
                                isEmail: true,
                                hintText: "eg. Dhanmondi,dhaka",
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Enter Your Address";
                                  }

                                  _formKey.currentState.save();
                                  return null;
                                },

                                onSaved: (String value){
                                  _deviceTypeController.text=value;
                                },
                              ),


                              SizedBox(height:30.0 ,),

                              Text("Authorization Code",style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),),
                              SizedBox(height:10.0 ,),

                              PinInputTextField(
                                pinLength: 8,
                                decoration: _pinDecoration,
                                controller: _pinEditingController,
                                autoFocus: true,
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

                              SizedBox(height: 30,),

                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    providerDevice.addDevices(_deviceMacAddressController.text,context,_deviceTypeController.text,_pinEditingController.text,"New Device");
                                  }
                                },
                                child: Container(
                                  height: 40.0,
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





                            ],
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

