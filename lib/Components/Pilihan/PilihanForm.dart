import 'package:flutter/material.dart';
import 'package:food_sharing/Components/Pilihan/PenerimaComponent.dart';
import 'package:food_sharing/Screens/Register/PenerimaScreen.dart';

import '../../Screens/Register/Register.dart';
import '../../utils/constans.dart';
import '../default_button_custome_color.dart';

class Pilihanform extends StatefulWidget {
  const Pilihanform({Key? key}) : super(key: key);

  @override
  _Pilihanform createState() => _Pilihanform();
}

class _Pilihanform extends State<Pilihanform> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Donor",
            press: () {
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
          ),
        ),
        SizedBox(height: 40), // Jarak antara button sebelumnya dan button baru
        GestureDetector(
          child: DefaultButtonCustomeColor(
            color: Colors.blue, // Warna button baru
            text: "Receiver",
            press: () {
              Navigator.pushNamed(context, PenerimaScreen.routeName);
              // Fungsi yang akan dijalankan saat button baru ditekan
            },
          ),
        ),
      ],
    );
  }
}
