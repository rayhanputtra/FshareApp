import 'package:flutter/material.dart';
import 'package:food_sharing/Components/Admin/Crud/EditMakanan/EditMakananForm.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';

class EditMakananComponent extends StatefulWidget {
  const EditMakananComponent({Key? key}) : super(key: key);

  @override
  _EditMakananComponent createState() => _EditMakananComponent();
}

class _EditMakananComponent extends State<EditMakananComponent> {
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
                          "Edit Food Data !",
                          style: mTitleStyle,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const EditMakananForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
