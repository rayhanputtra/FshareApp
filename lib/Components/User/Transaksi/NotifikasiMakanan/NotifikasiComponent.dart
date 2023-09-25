import 'package:flutter/material.dart';
import 'package:food_sharing/Components/User/Transaksi/NotifikasiMakanan/NotifikasiForm.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';

class NotifikasiComponent extends StatefulWidget {
  const NotifikasiComponent({Key? key}) : super(key: key);

  @override
  _NotifikasiComponent createState() => _NotifikasiComponent();
}

class _NotifikasiComponent extends State<NotifikasiComponent> {
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Receiver photo",
                          style: TextStyle(
                              color: mTitleColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const NotifikasiForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
