import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokit/base/material_app.dart';
import 'package:rokit/providers_class/apiServiceProvider.dart';
import 'package:rokit/providers_class/firebase_auth_service.dart';
import 'package:rokit/screens/splash_screen.dart';
import 'package:rokit/utils/global_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RokkhiConfig.pref = await SharedPreferences.getInstance();

  runApp(RokkhiApp());
}

class RokkhiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
      ],
      child:RokkhiMaterialApp(home: SplashScreen()),

    );
  }
}




