import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/Admin/AdminKhususScreen.dart';
import '../../../../Api/configApi.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import '../../../Screens/Login/LoginScreen.dart';
import '../../../Screens/User/EditDataAccount/editaccountKususScreen.dart';
import '../../custom_surfix_icon.dart';
import '../../default_button_custome_color.dart';

class EditAccountKususForm extends StatefulWidget {
  const EditAccountKususForm({Key? key}) : super(key: key);

  @override
  _EditAccountKususForm createState() => _EditAccountKususForm();
}

class _EditAccountKususForm extends State<EditAccountKususForm> {
  TextEditingController txtNama = TextEditingController(
          text: '${EditaccountKususScreen.dataAccount['nama']}'),
      txtNoTelp = TextEditingController(
          text: '${EditaccountKususScreen.dataAccount['email']}'),
      txtPassword = TextEditingController(text: '');

  FocusNode focusNode = FocusNode();

  Response? response;
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildNama(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildNoTelp(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassword(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: Color.fromARGB(255, 17, 175, 101),
            text: "Change Data",
            press: () {
              if (txtPassword.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Full Name cannot be empty',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtNama.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Phone Number Cannot Be Empty',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtNoTelp.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Disclaimer',
                        desc: 'Password cannot be empty',
                        btnOkOnPress: () {})
                    .show();
              } else {
                editDataUser(txtPassword.text, txtNama.text, txtNoTelp.text);
              }
            },
          ),
          IconButton(
            iconSize: 70,
            onPressed: () {
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.RIGHSLIDE,
                      title: 'Disclaimer',
                      desc: 'Are you sure you want to exit the app?',
                      btnCancelOnPress: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      btnOkText: 'Cancel',
                      btnCancelText: 'Logout',
                      btnOkOnPress: () {})
                  .show();
              // Tambahkan logika logout di sini
            },
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'log out',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.logout,
                  size: 18, // ukuran ikon disesuaikan
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildNama() {
    return TextFormField(
      controller: txtNama,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Admin name',
          hintText: 'Insert Admin Name',
          labelStyle: TextStyle(
            color: focusNode.hasFocus
                ? mSubtitleColor
                : Color.fromARGB(255, 17, 175, 101),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/tagline.svg",
          )),
    );
  }

  TextFormField buildNoTelp() {
    return TextFormField(
      controller: txtNoTelp,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Phone number',
          hintText: 'Insert the phone number',
          labelStyle: TextStyle(
            color: focusNode.hasFocus
                ? mSubtitleColor
                : Color.fromARGB(255, 17, 175, 101),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/tags.svg",
          )),
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: '*******',
          labelStyle: TextStyle(
            color: focusNode.hasFocus
                ? mSubtitleColor
                : Color.fromARGB(255, 17, 175, 101),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/medium.svg",
          )),
    );
  }

  void editDataUser(password, nama, email) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap(
          {'password': password, 'nama': nama, 'email': email});

      response = await dio.put(
          '$editDatauser/${EditaccountKususScreen.dataAccount['_id']}',
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
                  arguments: EditaccountKususScreen.dataAccount);
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
          desc: 'An Error Occurred On The Server !!!',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
