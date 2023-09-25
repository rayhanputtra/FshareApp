import 'package:flutter/material.dart';
import 'package:food_sharing/Components/Login/LoginComponent.dart';
import 'package:food_sharing/size_config.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const LoginComponent(),
    );
  }
}
