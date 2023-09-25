import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Api/configApi.dart';
import '../../../../Screens/Admin/HomeAdminScreen.dart';
import '../../../../Screens/Map/LocationScreen.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import '../../../custom_surfix_icon.dart';
import '../../../default_button_custome_color.dart';

class InputMakananForm extends StatefulWidget {
  const InputMakananForm({Key? key}) : super(key: key);

  @override
  _InputMakananForm createState() => _InputMakananForm();
}

class _InputMakananForm extends State<InputMakananForm> {
  GoogleMapController? mapController;
  TextEditingController txtNamaMakanan = TextEditingController(),
      txtPorsiMakanan = TextEditingController(),
      txtKadaluarsa = TextEditingController(),
      txtTglMakanan = TextEditingController(),
      txtAlamatMakanan = TextEditingController();

  FocusNode focusNode = FocusNode();
  File? image;
  // LatLng? position;
  LatLng? selectedLocation;

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
              ? Container()
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
          // SizedBox(height: getProportionateScreenHeight(30)),
          // DefaultButtonCustomeColor(
          //   color: Colors.red[400],
          //   text: "Pilih Lokasi",
          //   press: () {
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (BuildContext context) {
          //       return const SimpleMapScreen();
          //     }));
          //   },
          // ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
            height: 200, // Adjust the height as needed
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedLocation ?? LatLng(-6.1754, 106.8272),
                zoom: 15.0,
              ),
              onTap: (LatLng location) {
                setState(() {
                  selectedLocation = location;
                });
              },
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              markers: selectedLocation != null
                  ? Set<Marker>.from([
                      Marker(
                        markerId: MarkerId('selected_location'),
                        position: selectedLocation!,
                      ),
                    ])
                  : null,
            ),
          ),
          ElevatedButton(
            onPressed: getCurrentLocation,
            child: Text('Get Current Location'),
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
                        desc: 'Food name is required',
                        btnOkOnPress: () {})
                    .show();
              } else if (selectedValue == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Food Types is required',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtKadaluarsa.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Expiry date is required',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtPorsiMakanan.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Portion is required',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtTglMakanan.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Post Date is required',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtAlamatMakanan.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Address is required',
                        btnOkOnPress: () {})
                    .show();
              } else {
                inputDataMobil(
                    HomeAdminScreens.dataAdminLogin['_id'],
                    HomeAdminScreens.dataAdminLogin['nama'],
                    HomeAdminScreens.dataAdminLogin['email'],
                    txtNamaMakanan.text,
                    selectedValue,
                    txtPorsiMakanan.text,
                    txtTglMakanan.text,
                    txtKadaluarsa.text,
                    txtAlamatMakanan.text,
                    image?.path,
                    selectedLocation ?? LatLng);
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
    // Mendapatkan waktu saat ini
    DateTime currentTime = DateTime.now();

    // Mengonversi waktu saat ini menjadi format yang diinginkan (nama hari, tanggal, dan jam)
    String formattedTime =
        '${_getDayName(currentTime.weekday)}, ${currentTime.day}-${currentTime.month}-${currentTime.year} | Pukul : ${currentTime.hour}:${_formatMinute(currentTime.minute)}';

    // Membuat controller dan mengatur nilai awal dengan waktu saat ini

    return TextFormField(
      controller: txtTglMakanan = TextEditingController(text: formattedTime),
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      readOnly: true,
      decoration: InputDecoration(
          labelText: 'Posting Time',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/tags.svg",
          )),
    );
  }

  String _getDayName(int day) {
    List<String> days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];
    return days[day - 1];
  }

  String _formatMinute(int minute) {
    return minute < 10 ? '0$minute' : minute.toString();
  }

  TextFormField buildKadaluarsaMakanan() {
    return TextFormField(
      controller: txtKadaluarsa,
      keyboardType: TextInputType.number,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Expiry Date',
          hintText: 'Insert Expiry Date',
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
          labelText: 'Donors Address',
          hintText: 'Insert the Donors Address',
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
      print("Failed to Take Photo : $e");
    }
  }

  // Future pilihLokasi() async {
  //     final GoogleMapController controller =  await _controller.future;
  //     controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  // }

  void inputDataMobil(idAdmin, uradmin, tlpadmin, nama, tipe, porsi, tgl,
      kadaluarsa, alamat, gambar, formattedLocation) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    var formData = FormData.fromMap;
    try {
      var formData = FormData.fromMap({
        'idAdmin': idAdmin,
        'uradmin': uradmin,
        'tlpadmin': tlpadmin,
        'nama': nama,
        'tipe': tipe,
        'kadaluarsa': kadaluarsa,
        'porsi': porsi,
        'alamat': alamat,
        'tgl': tgl,
        'gambar': await MultipartFile.fromFile(gambar),
        'lokasi': formattedLocation =
            'Latitude: ${selectedLocation!.latitude.toString()}, Longitude: ${selectedLocation!.longitude.toString()}',
      });

      response = await dio.post(inputMobil, data: formData);
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
          desc: 'Food photos and food locations cannot be empty  !!!',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      selectedLocation = LatLng(position.latitude, position.longitude);
      final formattedLocation =
          'Latitude: ${selectedLocation!.latitude.toString()}, Longitude: ${selectedLocation!.longitude.toString()}';
      print(formattedLocation);
    });

    // Arahkan kamera ke lokasi terkini setelah tombol ditekan
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(selectedLocation!, 15.0),
      );
    }
  }
}
