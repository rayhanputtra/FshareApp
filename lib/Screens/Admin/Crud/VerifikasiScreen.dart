import 'package:flutter/material.dart';
import 'package:food_sharing/Components/Admin/Crud/Verifikasi/VerifikasiComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';

class VerifikasiScreen extends StatelessWidget {
  static var routeName = '/verif_screens';
  static var dataverifikasi;

  const VerifikasiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataverifikasi = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 175, 101),
        title: const Text(
          "Data Checking Page",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const VerifikasiComponent(),
    );
  }
}
