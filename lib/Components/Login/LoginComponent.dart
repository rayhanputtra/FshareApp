import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import '../../size_config.dart';
import '../../utils/constans.dart';
import 'LoginForm.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({Key? key}) : super(key: key);

  @override
  _LoginComponent createState() => _LoginComponent();
}

class _LoginComponent extends State<LoginComponent> {
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
                // SizedBox(
                //   height: SizeConfig.screenHeight * 0.04,
                // ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    "FShare",
                    style: TextStyle(
                      fontFamily: "LeckerliOne",
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SimpleShadow(
                  opacity: 0.5,
                  color: kSecondaryColor,
                  offset: const Offset(5, 5),
                  sigma: 2,
                  child: Image.asset(
                    "assets/images/food-donation.png",
                    height: 150,
                    width: 202,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Log in",
                        style: mTitleStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SignInform()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
