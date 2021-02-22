import 'package:get/get.dart';
import 'package:rokit/data_model/user_profile_model.dart';
import 'package:rokit/getX_class/service.dart';
import 'package:rokit/utils/getTokenId.dart';
import 'package:rokit/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController{
 // UserProfileModel userProfileModel;

  var userProfileModel=UserProfileModel().obs;
  Services services = Services();
  var postloading = true.obs;

  var totalDoor=0.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    callpostmethod();
  }


  callpostmethod() async {

    try {
      postloading.value = true;
      var result = await services.getallposts();
      if (result != null) {
        userProfileModel.value=result;
        totalDoor.value=userProfileModel.value.data.devices.totalDoor;
      } else {
        print("null");
      }
    } finally {
      postloading.value = false;
    }
    update();
  }

}