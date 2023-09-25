import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:food_sharing/Api/configApi.dart';
import 'package:food_sharing/Screens/User/HomeUserScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../Screens/User/Transaksi/TransaksiScreen.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import '../../../default_button_custome_color.dart';

class TransaksiForm extends StatefulWidget {
  const TransaksiForm({Key? key}) : super(key: key);

  @override
  State<TransaksiForm> createState() => _TransaksiFormState();
}

class _TransaksiFormState extends State<TransaksiForm> {
  late GoogleMapController googleMapController;
  Response? response;
  var dio = Dio();
  // var jumlahAmbil = 0.0;

  // static const CameraPosition initialCameraPosition =
  //     CameraPosition(target: LatLng(-6.175392, 106.827153), zoom: 14.0);
  Set<Marker> markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    String lokasi = TransaksiScreen.dataMakanan['lokasi'];

    RegExp latitudePattern = RegExp(r'Latitude: (.*?),');
    RegExp longitudePattern = RegExp(r'Longitude: (.*?)$');

    double latitude =
        double.parse(latitudePattern.firstMatch(lokasi)?.group(1) ?? '0');
    double longitude =
        double.parse(longitudePattern.firstMatch(lokasi)?.group(1) ?? '0');

    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.0,
    );

    Marker redMarker = Marker(
      markerId: MarkerId('redMarker'),
      position: LatLng(latitude, longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    markers.add(redMarker);
    print(TransaksiScreen.dataMakanan);
    return Form(
        child: Column(
      children: [
        Image.network(
          "$baseUrl/${TransaksiScreen.dataMakanan['gambar']}",
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
                "Food name",
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
                "${TransaksiScreen.dataMakanan['nama']}",
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Food Type",
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
                "${TransaksiScreen.dataMakanan['tipe']}",
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Posting Time",
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
                "${TransaksiScreen.dataMakanan['tgl']}",
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Expired",
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
                "${TransaksiScreen.dataMakanan['kadaluarsa']}",
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Food Amount",
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
                "${TransaksiScreen.dataMakanan['porsi']}",
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address",
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
                "${TransaksiScreen.dataMakanan['alamat']}",
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 10, top: 5),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Jumlah Ambil",
        //         style: mTitleStyle,
        //       )
        //     ],
        //   ),
        // ),
        // Padding(
        //     padding: const EdgeInsets.only(left: 10, top: 5),
        //     child: SpinBox(
        //       min: 0,
        //       max: 100,
        //       value: 0,
        //       onChanged: (value) {
        //         setState(() {
        //           jumlahAmbil = value;
        //         });
        //       },
        //     )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 10, top: 5),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Total",
        //         style: mTitleStyle,
        //       )
        //     ],
        //   ),
        // ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        SizedBox(
          width: 350,
          height: 200,
          child: GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
              markers.clear();
            },
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton.extended(
            onPressed: () async {
              Position position = await _determinePosition();

              googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14,
                ),
              ));

              Marker blueMarker = Marker(
                markerId: MarkerId('LokasiSekarang'),
                position: LatLng(position.latitude, position.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure),
              );
              markers.add(blueMarker);

              setState(() {});
            },
            label: const Text("Your Current Location"),
            icon: const Icon(Icons.location_history),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),

        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Take",
            press: () {
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.RIGHSLIDE,
                      title: 'Disclaimer',
                      desc:
                          'Are you sure you want to take food? ${TransaksiScreen.dataMakanan['nama']}',
                      btnOkOnPress: () {
                        report();
                        prosesTransaksi(
                            TransaksiScreen.dataMakanan['_id'],
                            HomeUserScreen.dataUserLogin['_id'],
                            TransaksiScreen.dataMakanan['idAdmin']);
                      },
                      btnCancelOnPress: () {})
                  .show();
              print("Get Transactions");
            }),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        DefaultButtonCustomeColor(
            color: kColorRedSlow,
            text: "Report",
            press: () {
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.RIGHSLIDE,
                      title: 'Disclaimer',
                      desc:
                          'Are You Sure You Want to Report Food? ${TransaksiScreen.dataMakanan['nama']}',
                      btnOkOnPress: () {
                        report();
                      },
                      btnCancelOnPress: () {})
                  .show();
            }),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
      ],
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disable');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location services are disable');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  void prosesTransaksi(idBarang, idUser, idPemberi) async {
    utilsApps.hideDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.post(createTransaksi, data: {
        'idBarang': idBarang,
        'idUser': idUser,
        'idPemberi': idPemberi,
      });

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'Food Request successfully created',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, HomeUserScreen.routeName,
                arguments: HomeUserScreen.dataUserLogin);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'Fail, $msg',
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

  void report() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        'verifikasi': 4,
      });

      response = await dio.put(
          '$editMobil/${TransaksiScreen.dataMakanan['_id']}',
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
              Navigator.pushNamed(context, HomeUserScreen.routeName,
                  arguments: HomeUserScreen.dataUserLogin);
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
          desc: 'An Error Occurred On The Server!!!',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
