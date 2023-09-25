import 'package:flutter/material.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import 'InputMakananForm.dart';

class InputMakananComponent extends StatefulWidget {
  const InputMakananComponent({Key? key}) : super(key: key);

  @override
  _InputMakananComponent createState() => _InputMakananComponent();
}

class _InputMakananComponent extends State<InputMakananComponent> {
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
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Food Data!",
                          style: mTitleStyle,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const InputMakananForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
