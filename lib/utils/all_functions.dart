import 'package:flutter/material.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/widget/text_formWidget.dart';

Future buildShowModalBottomSheet(BuildContext context, ProviderDevice providerDevice,controller,formKey) {
  return showModalBottomSheet(
    isScrollControlled: true,

    context: context,

    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 200.0,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text("Enter Device Mac Address"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormWidget(
                  hintText: "device mac address",
                  controller: controller,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "your device mac address";
                    }
                    formKey.currentState.save();
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {

                    providerDevice.addDevices(controller.text, context);
                  }
                },
                child: Text("add device"),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


Future editDeviceModalBottomSheet(BuildContext context, ProviderDevice providerDevice,controller,formKey,macID,initialTex) {
  return showModalBottomSheet(
    isScrollControlled: true,

    context: context,

    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 200.0,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text("Enter Device Mac Address"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormWidget(
                  text: initialTex,
                  hintText: "device mac address",
                  controller: controller,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "your device mac address";
                    }
                    formKey.currentState.save();
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    providerDevice.editDevices(controller.text,macID,context);
                  }
                },
                child: Text("add device"),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}



