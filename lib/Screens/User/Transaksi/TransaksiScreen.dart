import 'package:flutter/material.dart';
import '../../../Components/User/Transaksi/CreateTransaksi/TransaksiComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';

class TransaksiScreen extends StatelessWidget {
  static var routeName = '/form_transaksi_screen';
  static var dataMakanan;

  const TransaksiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataMakanan = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorBlue,
        title: const Text(
          "Food Information",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const TransaksiComponent(),
    );
  }
}
