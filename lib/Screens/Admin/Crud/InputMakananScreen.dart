import 'package:flutter/material.dart';
import 'package:food_sharing/Components/Admin/Crud/InputMakanan/InputMakananComponent.dart';

import '../../../utils/constans.dart';

class InputMakananScreen extends StatelessWidget {
  static var routeName = '/input_makanan_screens';

  const InputMakananScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Food Data Input",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const InputMakananComponent(),
    );
  }
}
