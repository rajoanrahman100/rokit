import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rokit/base/material_app.dart';
import 'package:rokit/base/static_value.dart';
import 'package:rokit/screens/emailSignInScreen/registerWithEmail.dart';
import 'package:rokit/screens/emailSignInScreen/signInWithEmail.dart';
import 'package:rokit/screens/home_screen.dart';
import 'package:rokit/screens/logIn_screen.dart';
import 'package:rokit/screens/phoneAuthScreen/phoneLogIn.dart';
import 'package:rokit/screens/splash_screen.dart';

/// test screen to grasp router easily

/// add project screens here
const String SplashScreenRoute = "/splashScreen";
const String SignInScreenRoute = "/loginScreen";
const String MainScreenRoute = "/mainScreen";
const String SignWithEmailScreenRoute = "/signInWithEmailScreen";
const String RegisterWithEmailScreenRoute = "/registerWithEmailScreen";
const String PhoneLogInScreenRoute = "/phoneLogInScreen";

class RouteGenerator {
  // this @generateRoute can share dynamic object with another screen
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {

      ///
      /// ----------- our app required screens starts from below ---------
      ///

      ///
      /// ----------- our app required screens starts from below ---------
      ///

      case SplashScreenRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case SignInScreenRoute:
        return MaterialPageRoute(builder: (_) => MainLogInPage());

      case SignWithEmailScreenRoute:
        return MaterialPageRoute(builder: (_) => SignInWithEmail());

      case RegisterWithEmailScreenRoute:
        return MaterialPageRoute(builder: (_) => RegisterWithEmail());


      case PhoneLogInScreenRoute:
        return MaterialPageRoute(builder: (_) => LogInWithPhone());

      case MainScreenRoute:
        return MaterialPageRoute(builder: (_) => RokkhiMaterialApp(home: HomeScreen()));
      default:
        return ErrorRouteScreen();
    }
  }

  static Route<dynamic> ErrorRouteScreen() {
    return MaterialPageRoute(builder: (context) {
      return WillPopScope(
        onWillPop: () => helpMeToNavigatePop(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Route error"),
          ),
          body: Center(
            child: Text(
              "No view found on that name!",
              style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
            ),
          ),
        ),
      );
    });
  }

  static void helpMeToNavigatePush(BuildContext context, String routeName, {Object argument}) {
    argument != null ? Tag("navigation switching with argument ${argument.toString()}") : Tag("argument is null");
    argument != null ? Navigator.of(context).pushNamed(routeName, arguments: argument) : Navigator.of(context).pushNamed(routeName);
  }

  static Future<bool> helpMeToNavigatePop(BuildContext context) async {
    Navigator.pop(context);
    return true;
  }

  static Future<bool> closeApp() async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return true;
  }

  static void pushNamedAndRemoveUntilWithData(BuildContext context, String routeName, Object argument) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (r) => false, arguments: argument);
  }

  static void clearBackStack(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (r) => false);
  }

  static void navigatePush(BuildContext context, Widget routeName) {
    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: routeName));
  }
}
