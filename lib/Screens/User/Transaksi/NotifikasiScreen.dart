import 'package:flutter/material.dart';
import 'package:food_sharing/Components/User/Transaksi/NotifikasiMakanan/NotifikasiComponent.dart';
import '../../../Components/User/Transaksi/CreateTransaksi/TransaksiComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';

class NotifikasiScreen extends StatelessWidget {
  static var routeName = '/form_notifikasi';
  static var dataPermintaan;

  const NotifikasiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataPermintaan = ModalRoute.of(context)!.settings.arguments as Map;
    print(dataPermintaan);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Food Request Form",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const NotifikasiComponent(),
    );
  }
}
