import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Api/configApi.dart';
import 'package:food_sharing/Screens/User/Transaksi/NotifikasiAdminScreen.dart';
import '../../../../../Screens/Admin/AdminKhususScreen.dart';
import '../../../../../size_config.dart';
import '../../../../../utils/constans.dart';

class AdminKususTransaksiComponent extends StatefulWidget {
  const AdminKususTransaksiComponent({Key? key}) : super(key: key);

  @override
  _AdminKususTransaksiComponent createState() =>
      _AdminKususTransaksiComponent();
}

class _AdminKususTransaksiComponent
    extends State<AdminKususTransaksiComponent> {
  Response? response;
  var dio = Dio();
  List<dynamic> datatransaksi = [];

  @override
  void initState() {
    super.initState();
    getDataTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: datatransaksi.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cardTransaksi(datatransaksi[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardTransaksi(data) {
    if (data['buktiPembayaran'] == null) {
      return Container(); // Mengembalikan Container kosong jika tidak ada buktiPembayaran
    }

    String statusText;
    Color statusColor;

    if (data['status'] == 0) {
      statusText = "Waiting for Photo Uploads"; // Teks untuk status 0
      statusColor = Color.fromARGB(255, 255, 123, 0);
      ; // Warna teks untuk status 0
    } else if (data['status'] == 1) {
      statusText = "Request Accepted"; // Teks untuk status 1
      statusColor = Colors.green; // Warna teks untuk status 1
    } else if (data['status'] == 2) {
      statusText = "Waiting for approval"; // Teks untuk status 2
      statusColor = Color.fromARGB(255, 226, 204, 3);
    } else if (data['status'] == 3) {
      statusText = "Request Rejected"; // Teks untuk status 2
      statusColor = Colors.red; // Warna teks untuk status 2
      // Warna teks untuk status 2
    } else {
      statusText =
          ""; // Teks default jika status tidak sesuai dengan kondisi di atas
      statusColor = Colors.black; // Warna teks default
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, NotifikasiAdmin.routeName,
            arguments: data);
      },
      child: Card(
        elevation: 15.0,
        margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: Container(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              leading: Container(
                padding: const EdgeInsets.only(right: 1.0),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 3.0, color: Colors.white24),
                  ),
                ),
                child: Image.network(
                  ('$baseUrl/${data['buktiPembayaran']}'),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                "${data['dataBarang']['nama']}",
                style: const TextStyle(
                    color: mTitleColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
                    style: const TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    statusText,
                    style: TextStyle(
                        color: statusColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: mTitleColor,
                size: 40.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getDataTransaksi() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.get('$getAlltransaksi');

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          datatransaksi = response!.data['data'];
          print(datatransaksi);
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
          },
        ).show();
      }
    } catch (e) {
      print(e);
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
}
