import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokit/getX_class/addedDoorDeviceGet.dart';

class AddedDoorWithGetX extends StatelessWidget {
  DoorDevicesController doorDevicesController = Get.put(DoorDevicesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => ListView.builder(
            itemCount: doorDevicesController.doorDeviceModel.length,
            itemBuilder: (_, index) {
              return Center(child: Text("device Name: ${doorDevicesController.doorDeviceModel[index].data[index].deviceName}"));
            },
          ),
        ),
      ),
    );
  }
}
