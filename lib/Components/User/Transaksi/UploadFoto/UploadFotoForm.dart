import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_sharing/Screens/User/HomeUserScreen.dart';
import 'package:food_sharing/Screens/User/Transaksi/UploadBukti.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Api/configApi.dart';
import '../../../../Screens/Map/LocationScreen.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import '../../../custom_surfix_icon.dart';
import '../../../default_button_custome_color.dart';

class UploadFotoForm extends StatefulWidget {
  const UploadFotoForm({Key? key}) : super(key: key);

  @override
  _UploadFotoForm createState() => _UploadFotoForm();
}

class _UploadFotoForm extends State<UploadFotoForm> {
  FocusNode focusNode = FocusNode();
  File? image;
  LatLng? position;

  Response? response;
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        image == null
            ? Container()
            : Image.file(
                image!,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
        SizedBox(height: getProportionateScreenHeight(30)),
        ElevatedButton(
          onPressed: () {
            pilihKamera();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(
              //   Icons.camera_alt,
              //   color: Colors.white,
              //   size: 24,
              // ),
              SizedBox(width: 10),
              Text(
                "Take a selfie",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
        ElevatedButton(
          onPressed: () {
            statusmakanan(2);
            if (image != null) {
              UploadSelfie(image!);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            onPrimary: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                "Submit",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
  }

  Future<void> pilihKamera() async {
    try {
      final image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      setState(() => this.image = image);
    } on PlatformException catch (e) {
      print("Failed to Take Photo : $e");
    }
  }

  void UploadSelfie(File gambar) async {
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        'buktiPembayaran': await MultipartFile.fromFile(gambar.path),
        // 'lokasi': await Geolocator.getCurrentPosition()
      });

      // Ganti URL sesuai kebutuhan Anda
      response = await dio.put(
          '$uploadFotoSelfie/${UploadBuktiScreen.dataTransaksi['_id']}',
          data: formData);
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            title: 'Success',
            desc: 'Photo Upload Successfully',
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
                title: 'Error',
                desc: 'Gagal Upload Foto',
                btnOkOnPress: () {
                  // Tambahkan tindakan lain jika diperlukan
                })
            .show();
      }
    } catch (e) {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.RIGHSLIDE,
              title: 'Error',
              desc: 'Terjadi Kesalahan Pada Server !!!',
              btnOkOnPress: () {
                // Tambahkan tindakan lain jika diperlukan
              })
          .show();
    }
  }

  void statusmakanan(status) async {
    utilsApps.hideDialog(context);
    bool info;
    var msg;
    {
      response = await dio
          .put('$editstatus/${UploadBuktiScreen.dataTransaksi['_id']}', data: {
        'status':
            '2', // Menggunakan nilai '1' sebagai parameter untuk mengupdate status
      });
    }
  }
}
