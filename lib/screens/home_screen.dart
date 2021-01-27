import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/providers_class/provider_sensor_data.dart';
import 'package:rokit/utils/all_functions.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_app_bar.dart';
import 'package:rokit/widget/loader_widget.dart';
import 'package:rokit/widget/no_data_found.dart';
import 'package:rokit/widget/text_formWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderSensorData()),
        ChangeNotifierProvider(create: (_) => ProviderDevice()),
      ],
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FirebaseAuth _auth = FirebaseAuth.instance;

  var userID;

  final _formKey = GlobalKey<FormState>();

  var _controllerMacAddress = TextEditingController();
  var _editControllerMacAddress = TextEditingController();

  String _message = "";

  // registerToken() {
  //   _firebaseMessaging.getToken().then((value) {
  //     print("token:- $value");
  //   });
  // }

  getUserID() async {
    userID = _auth.currentUser.uid;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(KEY_USER_ID, userID);
  }

  getMessage() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();


    _firebaseMessaging.getToken().then((value)async{
      print("token value $value");
      await prefs.setString(KEY_TOKEN_ID, value);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() {
          _message = message["notification"]["title"];
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() {
          _message = message["notification"]["title"];
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          _message = message["notification"]["title"];
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getUserID();
   // getUserToken();
    getMessage();
  }

  @override
  Widget build(BuildContext context) {
    var providerSensorList = Provider.of<ProviderSensorData>(context, listen: false);
    var providerDevice = Provider.of<ProviderDevice>(context, listen: false);

    //providerSensorList.getAllSensorsData();

    providerDevice.getAddedDevices();

    return Scaffold(
      backgroundColor: appBack,
      appBar: RokkhiAppBar(
        mTitle: "Home",
        backColor: appBack,
        mAction: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _logOutAlert();
              }),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {

                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,

                  builder: (context) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      height: 200.0,
                      child: Form(
                        key: _formKey,
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
                                text: _controllerMacAddress.text,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "your device mac address";
                                  }
                                  _formKey.currentState.save();
                                  return null;
                                },
                                onSaved: (String value){
                                  _controllerMacAddress.text=value;
                                },

                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {

                                  providerDevice.addDevices(_controllerMacAddress.text, context);
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
              }),
        ],
      ),

      body: Consumer<ProviderDevice>(
          builder: (_, data, child) => data.deviceDataModel == null
              ? showShimmerDesign(context)
              : data.deviceDataModel.data.length == 0
                  ? NoDataFoundWidget(
                      height: 250.0,
                      width: 250.0,
                    )
                  : ListView.builder(
                      itemCount: data.deviceDataModel.data.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: IconButton(icon: Icon(Icons.delete_forever), onPressed:()async{
                               await data.deleteDevice(data.deviceDataModel.data[index].id);
                               await data.getAddedDevices();
                               await  data.notifyListeners();
                              }),
                              title: Text(data.deviceDataModel.data[index].deviceMacAddress),
                              trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                                //editDeviceModalBottomSheet(context,providerDevice,_controllerMacAddress,_formKey,data.deviceDataModel.data[index].id,_controllerMacAddress.text);

                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,

                                  builder: (context) => Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      height: 200.0,
                                      child: Form(
                                        key: _formKey,
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
                                                text: data.deviceDataModel.data[index].deviceMacAddress,
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return "your device mac address";
                                                  }
                                                  _formKey.currentState.save();
                                                  return null;
                                                },
                                                onSaved: (String value){
                                                  _editControllerMacAddress.text=value;
                                                },

                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            RaisedButton(
                                              onPressed: () async{
                                                if (_formKey.currentState.validate()) {

                                               await data.editDevices(_editControllerMacAddress.text,data.deviceDataModel.data[index].id ,context);
                                               await data.getAddedDevices();
                                               await data.notifyListeners();
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

                              }),
                            ),
                            Divider(
                              height: 1.0,
                              color: headerColor,
                            )
                          ],
                        );
                      })),

      /*floatingActionButton: Consumer<ProviderDevice>(
        builder: (_,data,child)=>data.deviceDataModel==null?Container() :FloatingActionButton.extended(
          onPressed: () async{


            showModalBottomSheet(
              isScrollControlled: true,
              context: context,

              builder: (context) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 200.0,
                  child: Form(
                    key: _formKey,
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
                            text: _controllerMacAddress.text,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "your device mac address";
                              }
                              _formKey.currentState.save();
                              return null;
                            },
                            onSaved: (String value){
                              _controllerMacAddress.text=value;
                            },

                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        RaisedButton(
                          onPressed: ()async {
                            if (_formKey.currentState.validate()) {


                               await data.addDevices(_controllerMacAddress.text, context);
                               await data.getAddedDevices();
                               await data.notifyListeners();
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
          },
          label: Text('Add Device'),
          icon: Icon(Icons.devices),
          backgroundColor: Colors.deepOrange,
        ),
      )*/

    );


  }


  Future signOut() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      setState(() async {
        await _auth.signOut();
        RouteGenerator.clearBackStack(context, SignInScreenRoute);
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _logOutAlert() {
    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              title: Text("Do you want to logout from the app?"),
              actions: <Widget>[
                FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("No")),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, true);

                      signOut();
                    },
                    child: Text("Yes")),
              ],
            ));
  }
}
