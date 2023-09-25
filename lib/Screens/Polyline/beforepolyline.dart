import 'package:flutter/material.dart';
import 'package:food_sharing/Components/Polyline/polylineSatu.dart';
import 'package:food_sharing/Screens/Polyline/PolylineScreen.dart';
import '../../../Components/User/Transaksi/CreateTransaksi/TransaksiComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';

class beforePolyline extends StatelessWidget {
  static var routeName = '/before_polyline';
  static var dataTransaksi;

  const beforePolyline({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataTransaksi = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Maps",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const polylineSatuComponent(),
    );
  }
}
