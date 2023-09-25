import 'package:flutter/material.dart';
import '../../Components/Pilihan/PilihanComponent.dart';
import '../../size_config.dart';

class PilihanScreen extends StatelessWidget {
  static String routeName = "/pilihan";

  const PilihanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const PilihanComponent(),
    );
  }
}
