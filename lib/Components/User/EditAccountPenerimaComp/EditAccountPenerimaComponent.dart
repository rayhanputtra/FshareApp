import 'package:flutter/material.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import 'EditAccountPenerimaForm.dart';

class EditUserPenerimaComponent extends StatefulWidget {
  const EditUserPenerimaComponent({Key? key}) : super(key: key);

  @override
  _EditUserPenerimaComponent createState() => _EditUserPenerimaComponent();
}

class _EditUserPenerimaComponent extends State<EditUserPenerimaComponent> {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 270, // ukuran ikon disesuaikan
                        color: Colors.black, // warna ikon disesuaikan
                      ),
                      SizedBox(height: 0), // jarak antara ikon dan teks
                      Text(
                        "Edit Receiver Data",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // tebalkan teks
                          fontSize: 18, // ukuran teks disesuaikan
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const EditAccountPenerimaForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
