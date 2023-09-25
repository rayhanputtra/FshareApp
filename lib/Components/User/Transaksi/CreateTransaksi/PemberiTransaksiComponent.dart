import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/User/Transaksi/NotifikasiScreen.dart';
import '../../../../Api/configApi.dart';
import '../../../../Screens/Admin/HomeAdminScreen.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import 'PemberiTransaksiForm.dart';

class PemberiTransaksiComponent extends StatefulWidget {
  const PemberiTransaksiComponent({Key? key}) : super(key: key);

  @override
  _PemberiTransaksiComponent createState() => _PemberiTransaksiComponent();
}

class _PemberiTransaksiComponent extends State<PemberiTransaksiComponent> {
  Response? response;
  var dio = Dio();
  List<dynamic> dataIdBarang = [];
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
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dataIdBarang.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardTransaksi(dataIdBarang[index]);
                    },
                  ),
                )
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
      statusColor = Color.fromARGB(255, 192, 173, 2);
    } else if (data['status'] == 3) {
      statusText = "Request Rejected"; // Teks untuk status 2
      statusColor = Colors.red; // Warna teks untuk status 2
    } else if (data['status'] == 4) {
      statusText = 'Your donation has been received';
      statusColor =
          Color.fromARGB(255, 45, 117, 47); // Warna merah untuk status 3
      // Warna teks untuk status 2
    } else {
      statusText =
          ""; // Teks default jika status tidak sesuai dengan kondisi di atas
      statusColor = Colors.black; // Warna teks default
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, NotifikasiScreen.routeName,
            arguments: data);
      },
      child: Card(
        elevation: 10.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2), // Mengatur bayangan
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                Navigator.pushNamed(context, NotifikasiScreen.routeName,
                    arguments: data);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              '$baseUrl/${data['buktiPembayaran']}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['dataBarang']['nama']}",
                            style: TextStyle(
                              color: mTitleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status",
                                style: TextStyle(
                                  color: mTitleColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                statusText,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: mTitleColor,
                      size: 32.0,
                    ),
                  ],
                ),
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
      response = await dio
          .get('$getByIdAdmin/${HomeAdminScreens.dataAdminLogin['_id']}');

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          datatransaksi = response!.data['data'];
          print(datatransaksi);
          getDatabyIdBarang();
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
        title: 'Peringatan',
        desc: 'Terjadi Kesalahan Pada Server',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
    }
  }

  void getDatabyIdBarang() async {
    bool status;
    var msg;
    try {
      for (var i = 0; i < datatransaksi.length; i++) {
        response = await dio.get('$getbarang/${datatransaksi[i]['_id']}');

        status = response!.data['sukses'];
        msg = response!.data['msg'];
        if (status) {
          setState(() {
            dataIdBarang.add(response!.data['data']);
          });
        } else {
          // AwesomeDialog(
          //     context: context,
          //     dialogType: DialogType.ERROR,
          //     animType: AnimType.RIGHSLIDE,
          //     title: 'Peringatan',
          //     desc: '$msg',
          //     btnOkOnPress: () {
          //       utilsApps.hideDialog(context);
          //     }).show();
        }
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
