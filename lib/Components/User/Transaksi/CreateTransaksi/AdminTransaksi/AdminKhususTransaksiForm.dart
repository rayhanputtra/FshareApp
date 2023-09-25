import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Api/configApi.dart';
import 'package:food_sharing/Screens/User/Transaksi/UploadBukti.dart';
import '../../../../../Screens/User/HomeUserScreen.dart';
import '../../../../../size_config.dart';
import '../../../../../utils/constans.dart';
import 'AdminKususTransaksiComponent.dart';

class AdminKhususTransaksiForm extends StatefulWidget {
  const AdminKhususTransaksiForm({Key? key}) : super(key: key);

  @override
  State<AdminKhususTransaksiForm> createState() => _AdminKhususTransaksiForm();
}

class _AdminKhususTransaksiForm extends State<AdminKhususTransaksiForm> {
  Response? response;
  var dio = Dio();
  var dataTransaksi;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: dataTransaksi == null ? 0 : dataTransaksi.length,
                  itemBuilder: (BuildContext context, int index) {},
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
