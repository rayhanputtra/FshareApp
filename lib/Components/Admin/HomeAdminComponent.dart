import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Api/configApi.dart';
import '../../Screens/Admin/Crud/EditDataScreen.dart';
import '../../Screens/Admin/Crud/InputMakananScreen.dart';
import '../../Screens/Admin/HomeAdminScreen.dart';
import '../../Screens/User/Transaksi/PemberiTransaksiScreen.dart';
import '../../size_config.dart';
import '../../utils/constans.dart';

class HomeAdminComponent extends StatefulWidget {
  const HomeAdminComponent({Key? key}) : super(key: key);

  @override
  _HomeAdminComponent createState() => _HomeAdminComponent();
}

class _HomeAdminComponent extends State<HomeAdminComponent> {
  Response? response;
  var dio = Dio();
  var dataMobil;
  List<dynamic> dataIdBarang = [];
  List<dynamic> datatransaksi = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataMobil();
    getDataTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    bool isStatusTwo = false;

    if (dataIdBarang.isNotEmpty) {
      for (var i = 0; i < dataIdBarang.length; i++) {
        if (dataIdBarang[i]['status'] == 2) {
          isStatusTwo = true;
          break; // Menghentikan perulangan jika status 2 ditemukan
        }
      }
    }

    return SafeArea(
      child: Stack(
        children: [
          Padding(
            // Tambahkan Padding di sini untuk menggeser card ke bawah
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(20),
              // Sesuaikan ukuran padding atas sesuai kebutuhan
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dataMobil == null || dataMobil.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 150,
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Mengatur konten ke tengah
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Mengatur konten ke tengah
                          children: [
                            Text(
                              'You have not made any transaction, please start your donation',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Center(
                              child: Image.asset(
                                'assets/images/donasi.png', // Ganti dengan path gambar Anda
                                width:
                                    300, // Sesuaikan ukuran gambar sesuai kebutuhan
                                height: 220,
                                // fit: BoxFit
                                //     .cover, // Atur tipe penyesuaian gambar
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (dataMobil != null &&
                        dataMobil
                            .isNotEmpty) // Tampilkan daftar card jika dataMobil tidak kosong
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          left: 10,
                        ), // Atur padding untuk membuat tulisan turun sedikit
                        child: Text(
                          'Postings', // Teks "Daftar Makanan" di sebelah kiri tombol
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    SizedBox(
                        height:
                            10), // Tambahkan spasi antara judul dan daftar card
                    Expanded(
                      child: ListView.builder(
                        itemCount: dataMobil == null ? 0 : dataMobil.length,
                        itemBuilder: (BuildContext context, int index) {
                          return cardDataMobil(dataMobil[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isStatusTwo)
            Positioned(
              bottom: getProportionateScreenHeight(20),
              left: getProportionateScreenWidth(20),
              child: GestureDetector(
                onTap: () {
                  // Tindakan ketika logo notifikasi ditekan
                },
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      PemberiTransaksiScreen.routeName,
                      arguments: HomeAdminScreens.dataAdminLogin,
                    );
                    // Tindakan ketika FAB ditekan
                  },
                  backgroundColor: Color.fromARGB(255, 255, 153, 0),
                  child: Icon(Icons.notification_add),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget cardDataMobil(data) {
    String statusText;
    Color statusColor;

    if (data['verifikasi'] == 0) {
      statusText = "Waiting for admin verification"; // Teks untuk status 0
      statusColor =
          Color.fromARGB(255, 255, 123, 0); // Warna teks untuk status 0
    } else if (data['verifikasi'] == 1) {
      statusText = "Successfully Posted"; // Teks untuk status 1
      statusColor = Colors.green; // Warna teks untuk status 1
    } else if (data['verifikasi'] == 2) {
      statusText =
          "Verification denied, Currently will be deleted"; // Teks untuk status 2
      statusColor = Colors.red;
    } else if (data['verifikasi'] == 3) {
      statusText = "Your post received a report"; // Teks untuk status 2
      statusColor =
          Color.fromARGB(255, 226, 204, 3); // Warna teks untuk status 2
      // Warna teks untuk status 2
    } else if (data['verifikasi'] == 4) {
      statusText = "Transaction in progress"; // Teks untuk status 2
      statusColor = Color.fromARGB(255, 0, 154, 214);
    } else if (data['verifikasi'] == 5) {
      statusText = "Food has been provided"; // Teks untuk status 2
      statusColor =
          Color.fromARGB(255, 4, 134, 134); // Warna teks untuk status 2
      // Warna teks untuk status 2
    } else {
      statusText =
          ""; // Teks default jika status tidak sesuai dengan kondisi di atas
      statusColor = Colors.black; // Warna teks default
    }
    if (data['verifikasi'] == 5) {
      // If "verifikasi" is 5, return an empty container (no card will be shown)
      return Container();
    }
    return Card(
      elevation: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // mengatur bayangan
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.white24),
              ),
            ),
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
                  color: mTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // ukuran teks disesuaikan
                ),
              ),
              Text(
                "[Status]",
                style: const TextStyle(
                  color: mTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                statusText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    EditDataScreen.routeName,
                    arguments: data,
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: kColorGreen,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Edit",
                      style: TextStyle(
                        color: mTitleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
                    },
                  ).show();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: kColorRedSlow,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Delete",
                      style: TextStyle(
                        color: mTitleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDataMobil() async {
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
          dataMobil = response!.data['data'];
          // print(dataMobil);
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
              //     context, HomeAdminScreens.routName, (route) => false);
              Navigator.pushNamed(context, HomeAdminScreens.routeName,
                  arguments: HomeAdminScreens
                      .dataAdminLogin); // Memperbarui data setelah menghapus mobil
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
          // print(datatransaksi);
          getDatabyIdBarang();
        });
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
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
            print(dataIdBarang);
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
          title: 'Disclaimer',
          desc: 'An Error Occurred On The Server',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
