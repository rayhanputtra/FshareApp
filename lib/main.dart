import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/Login/SplashScreen.dart';
import 'package:food_sharing/routes.dart';
import 'package:food_sharing/theme.dart';

import 'Screens/Login/LoginScreen.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Food Share",
    theme: theme(),
    initialRoute: SplashScreen.routeName,
    routes: routes,
  ));
}
