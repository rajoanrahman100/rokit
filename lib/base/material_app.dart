import 'package:flutter/material.dart';
import 'package:rokit/base/route.dart';

class RokkhiMaterialApp extends MaterialApp {
  Widget home;
  ThemeData theme;
  RouteFactory onGenerateRoute;
  NavigatorObserver navigatorObserver;


  RokkhiMaterialApp({Key key, this.onGenerateRoute, this.home, this.theme,this.navigatorObserver}) {
    onGenerateRoute = onGenerateRoute != null
        ? onGenerateRoute
        : RouteGenerator.generateRoute;

    //theme = theme != null ? theme : basicAppTheme();
    //home = home != null ? home : RouteErrorScreen();



  }
}