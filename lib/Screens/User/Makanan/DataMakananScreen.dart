import 'package:flutter/material.dart';

import '../../../Components/User/Makanan/MakananComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';

class DataMakananScreen extends StatelessWidget {
  static var routeName = '/list_gitar_user_screens';

  const DataMakananScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorBlue,
        title: const Text(
          "Food list",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const MakananComponent(),
    );
  }
}
