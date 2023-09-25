import 'package:flutter/material.dart';
import '../../../Components/Admin/Crud/EditMakanan/EditMakananComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';

class EditDataScreen extends StatelessWidget {
  static var routeName = '/edit_mobil_screens';
  static var dataMobil;

  const EditDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataMobil = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Edit Food Data",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const EditMakananComponent(),
    );
  }
}
