import 'package:flutter/material.dart';
import 'package:food_sharing/Components/Pilihan/PenerimaComponent.dart';

import '../../size_config.dart';

class PenerimaScreen extends StatelessWidget {
  static String routeName = "/penerima_up";

  const PenerimaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const PenerimaComponent(),
    );
  }
}
