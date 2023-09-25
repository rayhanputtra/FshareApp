import 'package:flutter/material.dart';
import '../../../Components/User/Transaksi/UploadFoto/UploadFotoComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';

class UploadBuktiScreen extends StatelessWidget {
  static var routeName = '/upload_bukti_foto';
  static var dataTransaksi;

  const UploadBuktiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataTransaksi = ModalRoute.of(context)!.settings.arguments as Map;
    print(dataTransaksi);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorBlue,
        title: const Text(
          "Upload Photos",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: UploadFotoComponent(),
    );
  }
}
