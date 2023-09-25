import 'package:flutter/material.dart';

import '../../Components/Register/RegisterComponent.dart';
import '../../size_config.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const RegisterComponent(),
    );
  }
}
