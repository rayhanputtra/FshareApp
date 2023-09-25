import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../size_config.dart';
import '../../utils/constans.dart';
import 'PilihanForm.dart';

class PilihanComponent extends StatefulWidget {
  const PilihanComponent({Key? key}) : super(key: key);

  @override
  _PilihanComponent createState() => _PilihanComponent();
}

class _PilihanComponent extends State<PilihanComponent> {
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
                  height: SizeConfig.screenHeight * 0.04,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                SimpleShadow(
                  opacity: 0.5,
                  color: kSecondaryColor,
                  offset: const Offset(5, 5),
                  sigma: 2,
                  child: Image.asset(
                    "assets/images/recruitment.png",
                    height: 200,
                    width: 252,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select a role",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Pilihanform()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
