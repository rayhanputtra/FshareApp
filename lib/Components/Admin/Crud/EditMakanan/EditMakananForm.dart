import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Api/configApi.dart';
import '../../../../Screens/Admin/Crud/EditDataScreen.dart';
import '../../../../Screens/Admin/HomeAdminScreen.dart';
import '../../../../Screens/Map/LocationScreen.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import '../../../custom_surfix_icon.dart';
import '../../../default_button_custome_color.dart';

class EditMakananForm extends StatefulWidget {
  const EditMakananForm({Key? key}) : super(key: key);

  @override
  _EditMakananForm createState() => _EditMakananForm();
}

class _EditMakananForm extends State<EditMakananForm> {
  TextEditingController txtNamaMakanan =
          TextEditingController(text: '${EditDataScreen.dataMobil['nama']}'),
      // selectedValue =
      //     TextEditingController(text: '${EditDataScreen.dataMobil['tipe']}'),
      txtPorsiMakanan =
          TextEditingController(text: '${EditDataScreen.dataMobil['porsi']}'),
      txtTglMakanan =
          TextEditingController(text: '${EditDataScreen.dataMobil['tgl']}'),
      txtKadaluarsa = TextEditingController(
          text: '${EditDataScreen.dataMobil['kadaluarsa']}'),
      txtAlamatMakanan =
          TextEditingController(text: '${EditDataScreen.dataMobil['alamat']}');

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
          SizedBox(height: getProportionateScreenHeight(30)),
          image == null
              ? Image.network(
                  '$baseUrl/${EditDataScreen.dataMobil['gambar']}',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  image!,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: Colors.red[400],
            text: "Select Food Picture",
            press: () {
              pilihGambar();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: Colors.red[400],
            text: "Your Current Location",
            press: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const LocationScreen();
              }));
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Submit",
            press: () {
              if (txtNamaMakanan.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Food Name Cannot be Empty',
                        btnOkOnPress: () {})
                    .show();
              } else if (selectedValue == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Food Type Cannot Be Empty',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtTglMakanan.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Upload date cannot be empty',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtKadaluarsa.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Expired Food Cannot Be Empty',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtPorsiMakanan.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Amount of Food Can Not Be Empty',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtAlamatMakanan.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Address cannot be empty',
                        btnOkOnPress: () {})
                    .show();
              } else {
                editDataMobil(
                    txtNamaMakanan.text,
                    selectedValue,
                    txtPorsiMakanan.text,
                    txtTglMakanan.text,
                    txtKadaluarsa.text,
                    txtAlamatMakanan.text,
                    image?.path,
                    position ?? LatLng);
              }
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
          hintText: 'Insert Food Name',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/tagline.svg",
          )),
    );
  }

  final List<String> value = [
    'Ready to Eat',
    'Fruits and Vegetables',
    'Instant or Packaged',
    'Snack',
  ];
  String? selectedValue;
  DropdownButtonFormField<String> buildTipeMakanan() {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      items: value.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Type',
        hintText: 'Select Food Type',
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/brand.svg",
        ),
      ),
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
          hintText: 'Insert Post Time',
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
          hintText: 'Insert Food Expiration',
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
          hintText: 'Insert the Number of Food Servings',
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
          labelText: 'Alamat Donatur',
          hintText: 'Insert the Donors address',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/brand.svg",
          )),
    );
  }

  Future pilihGambar() async {
    try {
      final image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = image);
    } on PlatformException catch (e) {
      print("Failed to Take Picture : $e");
    }
  }

  void editDataMobil(
      nama, tipe, porsi, tgl, kadaluarsa, alamat, gambar, lokasi) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        'nama': nama,
        'tipe': tipe,
        'porsi': porsi,
        'tgl': tgl,
        'kadaluarsa': kadaluarsa,
        'alamat': alamat,
        'gambar': image == null ? '' : await MultipartFile.fromFile(gambar),
        'lokasi': await Geolocator.getCurrentPosition()
      });

      response = await dio.put('$editMobil/${EditDataScreen.dataMobil['_id']}',
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
              Navigator.pushNamed(context, HomeAdminScreens.routeName,
                  arguments: HomeAdminScreens.dataAdminLogin);
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
