import 'package:flutter/material.dart';
import 'package:food_sharing/Components/Admin/Crud/EditMakanan/EditMakananForm.dart';
import 'package:food_sharing/Components/Admin/Crud/Verifikasi/VerifikasiForm.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';

class VerifikasiComponent extends StatefulWidget {
  const VerifikasiComponent({Key? key}) : super(key: key);

  @override
  _VerifikasiComponent createState() => _VerifikasiComponent();
}

class _VerifikasiComponent extends State<VerifikasiComponent> {
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
                  height: SizeConfig.screenHeight * 0.01,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Verification !",
                          style: mTitleStyle,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const VerifikasiForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
