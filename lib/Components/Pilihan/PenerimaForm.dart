import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../Api/configApi.dart';
import '../../Screens/Login/LoginScreen.dart';
import '../../size_config.dart';
import '../../utils/constans.dart';
import '../custom_surfix_icon.dart';
import '../default_button_custome_color.dart';

class PenerimaForm extends StatefulWidget {
  const PenerimaForm({Key? key}) : super(key: key);

  @override
  _PenerimaForm createState() => _PenerimaForm();
}

class _PenerimaForm extends State<PenerimaForm> {
  final _formkey = GlobalKey<FormState>();
  String? namalengkap;
  String? username;
  String? email;
  String? password;
  String? role;
  bool? remember = false;

  TextEditingController txtNamaLengkap = TextEditingController(),
      txtUserName = TextEditingController(),
      txtEmail = TextEditingController(),
      txtPassword = TextEditingController(),
      txtRole = TextEditingController();

  FocusNode focusNode = FocusNode();

  Response? response;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildNamaLengkap(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUserName(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmail(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassword(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: Colors.blue,
            text: "Register",
            press: () {
              print(txtNamaLengkap.text);
              print(txtUserName.text);
              print(txtEmail.text);
              print(txtPassword.text);
              prosesRegistrasi(
                txtUserName.text,
                txtPassword.text,
                txtNamaLengkap.text,
                txtEmail.text,
                "1",
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: const Text(
              "Have an account already? Login here",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildNamaLengkap() {
    return TextFormField(
      controller: txtNamaLengkap,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Full name',
          hintText: 'Insert Full Name',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUserName,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Username',
          hintText: 'Insert Username',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/account.svg",
          )),
    );
  }

  TextFormField buildEmail() {
    return TextFormField(
      controller: txtEmail,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Phone number',
          hintText: 'Insert Phone number',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/Phone.svg",
          )),
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Insert Password',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          )),
    );
  }

  void prosesRegistrasi(userName, password, nama, email, role) async {
    utilsApps.hideDialog(context);
    bool status;
    var msg;
    if (nama.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Disclaimer',
        desc: 'Full name cannot be empty',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
      return; // Halt the execution if the name is not filled.
    }

    if (email.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Disclaimer',
        desc: 'Email cannot be empty',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
      return; // Halt the execution if the email is not filled.
    }

    if (password.length < 8) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Disclaimer',
        desc: 'Password must have at least 8 characters',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
      return; // Hentikan eksekusi fungsi jika password tidak memenuhi syarat
    }

    try {
      response = await dio.post(urlRegister, data: {
        'username': userName,
        'password': password,
        'nama': nama,
        'email': email,
        'role': role,
      });

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'Successful Registration',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'Registration Failed, $msg',
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
}
