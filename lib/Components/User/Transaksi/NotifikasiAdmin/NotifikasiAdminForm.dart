import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/Admin/AdminKhususScreen.dart';
import 'package:food_sharing/Screens/Admin/HomeAdminScreen.dart';
import 'package:food_sharing/Screens/User/Transaksi/AdminTransaksiScreen.dart';
import '../../../../Api/configApi.dart';
import '../../../../Screens/User/Transaksi/NotifikasiAdminScreen.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import '../../../default_button_custome_color.dart';

class NotifikasiAdminForm extends StatefulWidget {
  const NotifikasiAdminForm({Key? key}) : super(key: key);

  @override
  _NotifikasiAdminForm createState() => _NotifikasiAdminForm();
}

class _NotifikasiAdminForm extends State<NotifikasiAdminForm> {
  FocusNode focusNode = FocusNode();
  File? image;

  Response? response;
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    int status = NotifikasiAdmin.dataPermintaan['status'];
    String statusText = '';
    Color statusColor = mTitleColor;
    if (status == 0) {
      statusText = 'Waiting for Photo Uploads';
      statusColor =
          Color.fromARGB(255, 255, 123, 0); // Warna oranye untuk status 00
    } else if (status == 1) {
      statusText = 'Request Accepted';
      statusColor = Colors.green; // Warna hijau untuk status 1
    } else if (status == 2) {
      statusText = 'Waiting for approval';
      statusColor =
          Color.fromARGB(255, 226, 204, 3); // Warna biru untuk status 3
    } else if (status == 3) {
      statusText = 'Request Rejected';
      statusColor = Colors.red; // Warna biru untuk status 3
    }
    return Form(
      child: Column(
        children: [
          Image.network(
            "$baseUrl/${NotifikasiAdmin.dataPermintaan['buktiPembayaran']}",
            width: 350,
            height: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date",
                  style: mTitleStyle,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${NotifikasiAdmin.dataPermintaan['tanggal']}",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
                    style: const TextStyle(
                      color: mTitleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          DefaultButtonCustomeColor(
              color: Color.fromARGB(255, 59, 146, 62),
              text: "Accept Request",
              press: () {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.INFO,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Are You Sure You Want To Accept The Request?',
                        btnOkOnPress: () {
                          editStatus(
                              1); // Mengirimkan nilai status yang diinginkan, misalnya 1
                        },
                        btnCancelOnPress: () {})
                    .show();
                // print("Boleh Transaksi");
              }),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
              color: Color.fromARGB(255, 196, 54, 44),
              text: "Reject Request",
              press: () {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.INFO,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Are You Sure You Want to Reject the Request?',
                        btnOkOnPress: () {
                          report(1);
                          tolakstatus(
                              3); // Mengirimkan nilai status yang diinginkan, misalnya 1
                        },
                        btnCancelOnPress: () {})
                    .show();
                // print("Boleh Transaksi");
              }),
        ],
      ),
    );
  }

  void editStatus(status) async {
    utilsApps.hideDialog(context);
    bool info;
    var msg;
    try {
      response = await dio
          .put('$editstatus/${NotifikasiAdmin.dataPermintaan['_id']}', data: {
        'status':
            '1', // Menggunakan nilai '1' sebagai parameter untuk mengupdate status
      });

      info = response!.data['sukses'];
      msg = response!.data['msg'];
      if (info) {
        NotifikasiAdmin.dataPermintaan['status'] = '1'; // Perbarui nilai status

        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'Successful Transaction',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, AdminKhususScreen.routeName,
                arguments: AdminTransaksiScreen.dataPemberi);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'Failed Transaction, $msg',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Disclaimer',
        desc: 'An Error Occurred On The Server',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
    }
  }

  void tolakstatus(status) async {
    utilsApps.hideDialog(context);
    bool info;
    var msg;
    try {
      response = await dio
          .put('$editstatus/${NotifikasiAdmin.dataPermintaan['_id']}', data: {
        'status':
            '3', // Menggunakan nilai '1' sebagai parameter untuk mengupdate status
      });

      info = response!.data['sukses'];
      msg = response!.data['msg'];
      if (info) {
        NotifikasiAdmin.dataPermintaan['status'] = '3'; // Perbarui nilai status

        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'Successful Transaction',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, AdminKhususScreen.routeName,
                arguments: AdminTransaksiScreen.dataPemberi);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'Failed Transaction, $msg',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Disclaimer',
        desc: 'Server Error Occurred',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
    }
  }

  void report(verifikasi) async {
    utilsApps.hideDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        'verifikasi': 1,
      });
      response = await dio.put(
          '$editMobil/${NotifikasiAdmin.dataPermintaan['idBarang']}',
          data: formData);
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            title: 'Disclaimer',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
              Navigator.pushNamed(context, AdminKhususScreen.routeName,
                  arguments: NotifikasiAdmin.dataPermintaan);
            }).show();
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Disclaimer',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
            }).show();
      }
    } catch (e) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'An Error Occurred On The Server !!!',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
