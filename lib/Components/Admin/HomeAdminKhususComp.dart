import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/Admin/AdminKhususScreen.dart';
import 'package:food_sharing/Screens/Admin/Crud/VerifikasiScreen.dart';
import '../../Api/configApi.dart';
import '../../Screens/Admin/Crud/EditDataScreen.dart';
import '../../Screens/Admin/HomeAdminScreen.dart';
import '../../size_config.dart';
import '../../utils/constans.dart';

class AdminKhususComponent extends StatefulWidget {
  const AdminKhususComponent({Key? key}) : super(key: key);

  @override
  _AdminKhususComponent createState() => _AdminKhususComponent();
}

class _AdminKhususComponent extends State<AdminKhususComponent> {
  Response? response;
  var dio = Dio();
  var dataMobil;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataMobil();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: ListView.builder(
            itemCount: dataMobil == null ? 0 : dataMobil.length,
            itemBuilder: (BuildContext context, int index) {
              return cardDataMobil(dataMobil[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget cardDataMobil(data) {
    String statusText;
    Color statusColor;
    Icon statusIcon;

    if (data['verifikasi'] == 0) {
      statusIcon = Icon(
        Icons.pending_actions,
        color: Color.fromARGB(255, 255, 123, 0),
      );
      statusText = "Waiting for verification"; // Teks untuk status 0
      statusColor =
          Color.fromARGB(255, 255, 123, 0); // Warna teks untuk status 0
    } else if (data['verifikasi'] == 1) {
      statusIcon = Icon(
        Icons.verified,
        color: Colors.green,
      );
      statusText = "Verified"; // Teks untuk status 1
      statusColor = Colors.green; // Warna teks untuk status 1
    } else if (data['verifikasi'] == 2) {
      statusIcon = Icon(
        Icons.dangerous,
        color: Colors.red,
      );
      statusText = "Delete This Post"; // Teks untuk status 2
      statusColor = Colors.red;
    } else if (data['verifikasi'] == 3) {
      statusIcon = Icon(
        Icons.report,
        color: Color.fromARGB(255, 226, 204, 3),
      );
      statusText = "This post received a report"; // Teks untuk status 2
      statusColor =
          Color.fromARGB(255, 226, 204, 3); // Warna teks untuk status 2
      // Warna teks untuk status 2
    } else if (data['verifikasi'] == 4) {
      statusIcon = Icon(Icons.motorcycle_rounded,
          color: Color.fromARGB(255, 0, 154, 214));
      statusText = "Transaction in progress"; // Teks untuk status 2
      statusColor = Color.fromARGB(255, 0, 154, 214);
    } else if (data['verifikasi'] == 5) {
      statusIcon = Icon(
        Icons.download_done_sharp,
        color: Color.fromARGB(255, 4, 134, 134),
      );
      statusText = "Food has been provided"; // Teks untuk status 2
      statusColor =
          Color.fromARGB(255, 4, 134, 134); // Warna teks untuk status 2
      // Warna teks untuk status 2
    } else {
      statusText =
          ""; // Teks default jika status tidak sesuai dengan kondisi di atas
      statusColor = Colors.black; // Warna teks default
      statusIcon = Icon(Icons.no_encryption_gmailerrorred_sharp);
    }
    return Card(
      elevation: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: Image.network(
              '$baseUrl/${data['gambar']}',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data['nama']}',
                style: const TextStyle(
                    color: mTitleColor, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman lain saat ikon ditekan
                  Navigator.pushNamed(context, VerifikasiScreen.routeName,
                      arguments: data);
                },
                child: Row(
                  children: [
                    statusIcon,
                    SizedBox(width: 5),
                    Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                // child: Row(
                //   statusText,
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: statusColor,
                //     fontSize: 12,
                //   ),
                // ),
              )
            ],
          ),
          subtitle: Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, EditDataScreen.routeName,
                    arguments: data);
              },
              child: Row(children: [
                Icon(
                  Icons.edit,
                  color: kColorGreen,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                )
              ]),
            ),
            GestureDetector(
              onTap: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    animType: AnimType.RIGHSLIDE,
                    title: 'Disclaimer',
                    desc:
                        'Are You Sure You Want To Delete? ${data['nama']} ......',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      HapusMobil('${data['_id']}');
                    }).show();
              },
              child: Row(children: [
                Icon(
                  Icons.delete,
                  color: kColorRedSlow,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Delete",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                )
              ]),
            )
          ]),
          // trailing: const Icon(
          //   Icons.keyboard_arrow_right,
          //   color: mTitleColor,
          //   size: 30.0,
          // ),
        ),
      ),
    );
  }

  void getDataMobil() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.get(getAllMobil);

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          dataMobil = response!.data['data'];
          print(dataMobil);
        });

        utilsApps.hideDialog(
            context); // Menyembunyikan dialog loading setelah pembaruan selesai
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
      print(e);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'An Error Occurred On The Server',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }

  void HapusMobil(id) async {
    bool status;
    var msg;
    try {
      response = await dio.delete('$hapusMobil/$id');

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
              // Navigator.pushAndRemoveUntil(
              //     context, AdminKhususScreen.routName, (route) => false);
              Navigator.pushNamed(context, AdminKhususScreen.routeName,
                  arguments: AdminKhususScreen
                      .datakhusus); // Memperbarui data setelah menghapus mobil
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
      print(e);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'An Error Occurred On The Server',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
