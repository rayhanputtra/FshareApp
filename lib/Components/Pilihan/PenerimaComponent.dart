import 'package:flutter/material.dart';
import 'package:food_sharing/Components/Pilihan/PenerimaForm.dart';

import '../../size_config.dart';
import '../../utils/constans.dart';

class PenerimaComponent extends StatefulWidget {
  const PenerimaComponent({Key? key}) : super(key: key);

  @override
  _PenerimaComponent createState() => _PenerimaComponent();
}

class _PenerimaComponent extends State<PenerimaComponent> {
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
                        "Receiver",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.blue,
                        ),
                      ),
                    )),
                const PenerimaForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
