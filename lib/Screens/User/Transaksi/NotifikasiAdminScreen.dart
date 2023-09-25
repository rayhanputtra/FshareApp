import 'package:flutter/material.dart';
import 'package:food_sharing/Components/User/Transaksi/NotifikasiMakanan/NotifikasiComponent.dart';
import '../../../Components/User/Transaksi/CreateTransaksi/TransaksiComponent.dart';
import '../../../Components/User/Transaksi/NotifikasiAdmin/NotifikasiAdminComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';

class NotifikasiAdmin extends StatelessWidget {
  static var routeName = '/form_notifikasi_admin';
  static var dataPermintaan;

  const NotifikasiAdmin({Key? key}) : super(key: key);
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
      body: const NotifikasiAdminComponent(),
    );
  }
}
