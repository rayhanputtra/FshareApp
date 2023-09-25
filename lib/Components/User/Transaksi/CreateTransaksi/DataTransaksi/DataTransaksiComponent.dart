import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Api/configApi.dart';
import 'package:food_sharing/Screens/User/Transaksi/UploadBukti.dart';
import '../../../../../Screens/User/HomeUserScreen.dart';
import '../../../../../size_config.dart';
import '../../../../../utils/constans.dart';

class DataTransaksiComponent extends StatefulWidget {
  const DataTransaksiComponent({Key? key}) : super(key: key);

  @override
  State<DataTransaksiComponent> createState() => _DataTransaksiComponent();
}

class _DataTransaksiComponent extends State<DataTransaksiComponent> {
  Response? response;
  var dio = Dio();
  var dataTransaksi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            getProportionateScreenHeight(20),
            getProportionateScreenHeight(
                20), // Tambahkan jarak di atas daftar kartu
            getProportionateScreenHeight(20),
            getProportionateScreenHeight(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: dataTransaksi == null ? 0 : dataTransaksi.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cardTransaksi(dataTransaksi[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardTransaksi(data) {
    var status = data['status'];
    String statusText = '';
    Color statusColor = mTitleColor;
    bool isClickable = status == 0;
    bool showIcon = status == 0;

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
    } else if (status == 4) {
      statusText = 'Done Taken';
      statusColor =
          Color.fromARGB(255, 45, 117, 47); // Warna merah untuk status 3
    }

    return GestureDetector(
      onTap: isClickable
          ? () {
              Navigator.pushNamed(
                context,
                UploadBuktiScreen.routeName,
                arguments: data,
              );
            }
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 3.0, color: Colors.white24),
                image: DecorationImage(
                  image:
                      NetworkImage('$baseUrl/${data['dataBarang']['gambar']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${data['dataBarang']['nama']}",
                    style: const TextStyle(
                      color: mTitleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Donor's address",
                        style: const TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${data['dataBarang']['alamat']}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
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
            if (showIcon)
              const Icon(
                Icons.keyboard_arrow_right,
                color: mTitleColor,
                size: 40.0,
              ),
          ],
        ),
      ),
    );
  }

  void getDataTransaksi() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio
          .get('$getTransaksiUser/${HomeUserScreen.dataUserLogin['_id']}');

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          dataTransaksi = response!.data['data'];
          print(dataTransaksi);
        });
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Peringatan',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
            }).show();
      }
    } catch (e) {
      print(e);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Terjadi Kesalahan Pada Server',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
