import 'package:flutter/material.dart';
import 'package:food_sharing/Components/User/Transaksi/NotifikasiMakanan/NotifikasiForm.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import 'NotifikasiAdminForm.dart';

class NotifikasiAdminComponent extends StatefulWidget {
  const NotifikasiAdminComponent({Key? key}) : super(key: key);

  @override
  _NotifikasiAdminComponent createState() => _NotifikasiAdminComponent();
}

class _NotifikasiAdminComponent extends State<NotifikasiAdminComponent> {
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
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Request",
                          style: mTitleStyle,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const NotifikasiAdminForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
