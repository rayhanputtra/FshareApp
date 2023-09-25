import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../../utils/constans.dart';
import 'RegisterForm.dart';

class RegisterComponent extends StatefulWidget {
  const RegisterComponent({Key? key}) : super(key: key);

  @override
  _RegisterComponent createState() => _RegisterComponent();
}

class _RegisterComponent extends State<RegisterComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.07,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 250,
                      height: 100,
                      alignment: Alignment.center,
                      child: const Text(
                        "Donor",
                        style: TextStyle(
                          fontSize: 40,
                          color: kPrimaryColor,
                        ),
                      ),
                    )),
                const SignUpform()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
