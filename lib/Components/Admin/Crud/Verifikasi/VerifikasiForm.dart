import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_sharing/Screens/Admin/AdminKhususScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Api/configApi.dart';
import '../../../../Screens/Admin/Crud/VerifikasiScreen.dart';
import '../../../../Screens/Admin/HomeAdminScreen.dart';
import '../../../../Screens/Map/LocationScreen.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import '../../../custom_surfix_icon.dart';
import '../../../default_button_custome_color.dart';

class VerifikasiForm extends StatefulWidget {
  const VerifikasiForm({Key? key}) : super(key: key);

  @override
  _VerifikasiForm createState() => _VerifikasiForm();
}

class _VerifikasiForm extends State<VerifikasiForm> {
  TextEditingController txtNamaMakanan = TextEditingController(
          text: '${VerifikasiScreen.dataverifikasi['nama']}'),
      txtTipeMakanan = TextEditingController(
          text: '${VerifikasiScreen.dataverifikasi['tipe']}'),
      txtPorsiMakanan = TextEditingController(
          text: '${VerifikasiScreen.dataverifikasi['porsi']}'),
      txtTglMakanan = TextEditingController(
          text: '${VerifikasiScreen.dataverifikasi['tgl']}'),
      txtKadaluarsa = TextEditingController(
          text: '${VerifikasiScreen.dataverifikasi['kadaluarsa']}'),
      txtAlamatMakanan = TextEditingController(
          text: '${VerifikasiScreen.dataverifikasi['alamat']}');

  FocusNode focusNode = FocusNode();
  File? image;
  LatLng? position;

  Response? response;
  var dio = Dio();
  Set<Marker> markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    String lokasi = VerifikasiScreen.dataverifikasi['lokasi'];

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
    return Form(
      child: Column(
        children: [
          image == null
              ? Image.network(
                  '$baseUrl/${VerifikasiScreen.dataverifikasi['gambar']}',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  image!,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildNamaMakanan(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildTipeMakanan(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildKadaluarsaMakanan(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildJumlahMakanan(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAlamatMakanan(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildTglPost(),

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
                var googleMapController = controller;
                markers.clear();
              },
            ),
          ),

          // SizedBox(height: getProportionateScreenHeight(30)),
          // DefaultButtonCustomeColor(
          //   color: Colors.red[400],
          //   text: "Pilih Gambar Makanan",
          //   press: () {
          //     pilihGambar();
          //   },
          // ),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // DefaultButtonCustomeColor(
          //   color: Colors.red[400],
          //   text: "Lokasi Anda Sekarang",
          //   press: () {
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (BuildContext context) {
          //       return const LocationScreen();
          //     }));
          //   },
          // ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: Colors.green[600],
            text: "Verify",
            press: () {
              editdataverifikasi(
                  txtNamaMakanan.text,
                  txtTipeMakanan.text,
                  txtPorsiMakanan.text,
                  txtTglMakanan.text,
                  txtKadaluarsa.text,
                  txtAlamatMakanan.text,
                  image?.path,
                  position ?? LatLng);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButtonCustomeColor(
            color: Colors.red[600],
            text: "Reject",
            press: () {
              editDataVerifikasi(
                  txtNamaMakanan.text,
                  txtTipeMakanan.text,
                  txtPorsiMakanan.text,
                  txtTglMakanan.text,
                  txtKadaluarsa.text,
                  txtAlamatMakanan.text,
                  image?.path,
                  position ?? LatLng);
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextFormField buildNamaMakanan() {
    return TextFormField(
      controller: txtNamaMakanan,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Food name',
          hintText: 'Enter Food Name',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/tagline.svg",
          )),
    );
  }

  TextFormField buildTipeMakanan() {
    return TextFormField(
      controller: txtTipeMakanan,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Type',
          hintText: 'Enter Food Type',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/tagline.svg",
          )),
    );
  }

  TextFormField buildTglPost() {
    return TextFormField(
      controller: txtTglMakanan,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      readOnly: true,
      decoration: InputDecoration(
          labelText: 'Posting Time',
          hintText: 'Enter Post Time',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/tags.svg",
          )),
    );
  }

  TextFormField buildKadaluarsaMakanan() {
    return TextFormField(
      controller: txtKadaluarsa,
      keyboardType: TextInputType.number,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Food Expiration',
          hintText: 'Enter Food Expiration',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/medium.svg",
          )),
    );
  }

  TextFormField buildJumlahMakanan() {
    return TextFormField(
      controller: txtPorsiMakanan,
      keyboardType: TextInputType.number,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Food Amount',
          hintText: 'Enter the Number of Food Servings',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/tag.svg",
          )),
    );
  }

  TextFormField buildAlamatMakanan() {
    return TextFormField(
      controller: txtAlamatMakanan,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Donors Address',
          hintText: 'Enter Donors Address',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/brand.svg",
          )),
    );
  }

  void editdataverifikasi(
      nama, tipe, porsi, tgl, kadaluarsa, alamat, gambar, lokasi) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        // 'nama': nama,
        // 'tipe': tipe,
        // 'porsi': porsi,
        // 'tgl': tgl,
        // 'kadaluarsa': kadaluarsa,
        // 'alamat': alamat,
        // 'gambar': image == null ? '' : await MultipartFile.fromFile(gambar),
        // 'lokasi': await Geolocator.getCurrentPosition(),
        'verifikasi': 1,
      });

      response = await dio.put(
          '$editMobil/${VerifikasiScreen.dataverifikasi['_id']}',
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
                arguments: AdminKhususScreen.datakhusus);
          },
        ).show();
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
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Disclaimer',
        desc: 'An Error Occurred On The Server  !!!',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
    }
  }

  void editDataVerifikasi(
      nama, tipe, porsi, tgl, kadaluarsa, alamat, gambar, lokasi) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        // 'nama': txtNamaMakanan.text,
        // 'tipe': txtTipeMakanan.text,
        // 'porsi': txtPorsiMakanan.text,
        // 'tgl': txtTglMakanan.text,
        // 'kadaluarsa': txtKadaluarsa.text,
        // 'alamat': txtAlamatMakanan.text,
        // 'gambar': image == null ? '' : await MultipartFile.fromFile(image!.path),
        // 'lokasi': position != null ? '${position!.latitude},${position!.longitude}' : '',
        'verifikasi': 2,
      });

      response = await dio.put(
        '$editMobil/${VerifikasiScreen.dataverifikasi['_id']}',
        data: formData,
      );
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: '$msg',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, AdminKhususScreen.routeName,
                arguments: AdminKhususScreen.datakhusus);
          },
        ).show();
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
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Peringatan',
        desc: 'Terjadi Kesalahan Pada Server !!!',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
    }
  }
}
