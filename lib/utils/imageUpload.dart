import 'dart:developer';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/imageUpload_model.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_progress.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> uploadSuccess(BuildContext context, File image, String userId) async {
  ImageUpload imageUpload;
  // show progressbar for image upload
  ProgressDialog pasdr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
  setProgressDialog(context, pasdr, "Image Uploading...");
  pasdr.show();

  if (image != null)
    print("image ------ " + image.toString());
  else
    print("image is empty");

  var response = await uploadImageFunction(
    image,
    context,
    userId == null ? "0" : userId,
  );

  await response.stream.transform(utf8.decoder).listen((value) async {
    log("value===========" + value);
    var jsonParse = json.decode(value);
    imageUpload = new ImageUpload();
    imageUpload = ImageUpload.fromJson(jsonParse);
    log('-------------------------response image Upload  = = =' + response.statusCode.toString());

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("Image Link:" + imageUpload.toString());
      pasdr.hide();
    } else {
      showToast("Image Upload problem");
      print("Image Upload problem = = "+response.toString());
      pasdr.hide();
    }
  });
  return imageUpload.data;
}


uploadImageFunction(File imageFile, context, String subFolderName) async {
  print('----------------------------------> upload start');

  SharedPreferences prefs=await SharedPreferences.getInstance();

  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();
  var uri = Uri.parse(uploadImageUrl);
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile('image', stream, length, filename: basename(imageFile.path));

  print("JWT from image upload  =   =  ${prefs.getString(KEY_AUTH_ID)}");
  request.headers.addAll(
    <String, String>{
      'firebaseToken': prefs.getString(KEY_AUTH_ID),
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  request.files.add(multipartFile);
  request.fields.addAll({'subFolderName': subFolderName, 'fileName': DateTime.now().millisecondsSinceEpoch.toString()});
  var response = await request.send();
  return response;
}
