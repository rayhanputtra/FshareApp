import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/configApi.dart';
import '../../Screens/Admin/AdminKhususScreen.dart';
import '../../Screens/Admin/HomeAdminScreen.dart';
import '../../Screens/Pilihan/PilihanScreen.dart';
import '../../Screens/User/HomeUserScreen.dart';
import '../../size_config.dart';
import '../../utils/constans.dart';
import '../custom_surfix_icon.dart';
import '../default_button_custome_color.dart';

class SignInform extends StatefulWidget {
  const SignInform({Key? key}) : super(key: key);

  @override
  _SignInform createState() => _SignInform();
}

class _SignInform extends State<SignInform> {
  final _formkey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool remember = false;

  TextEditingController txtUserName = TextEditingController(),
      txtPassword = TextEditingController();

  FocusNode focusNode = FocusNode();

  Response? response;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    // Mendapatkan username terakhir yang tersimpan
    getSavedUsername();
  }

  Future<void> getSavedUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('savedUsername');
    if (savedUsername != null && savedUsername.isNotEmpty) {
      setState(() {
        username = savedUsername;
        remember = true;
      });
      txtUserName.text = savedUsername;
    }
  }

  Future<void> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedUsername', username);
  }

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          buildUserName(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassword(),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            children: [
              Checkbox(
                value: remember,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              const Text("Remember Me"),
              // const Spacer(),
              // GestureDetector(
              //   onTap: () {},
              //   child: const Text(
              //     "Lupa Password",
              //     style: TextStyle(decoration: TextDecoration.underline),
              //   ),
              // )
            ],
          ),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Log in",
            press: () {
              if (_formkey.currentState!.validate()) {
                _formkey.currentState!.save();
                prosesLogin(username, password);
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PilihanScreen.routeName);
            },
            child: const Text(
              "Don't have an account yet? Register here",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUserName,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Insert your Username',
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.account_circle_outlined, color: mSubtitleColor),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Username is required";
        }
        return null;
      },
      onSaved: (newValue) => username = newValue,
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: !isPasswordVisible,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Insert your Password',
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          child: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: isPasswordVisible ? Colors.blue : mSubtitleColor,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Password is required";
        }
        return null;
      },
      onSaved: (newValue) => password = newValue,
    );
  }

  void prosesLogin(String? userName, String? password) async {
    utilsApps.hideDialog(context);
    bool status;
    var msg;
    var dataUser;
    var dataAdmin;
    var dataKhusus;
    try {
      response = await dio.post(urlLogin, data: {
        'username': userName,
        'password': password,
      });

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Login Successful',
          // desc: 'Berhasil Login',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            dataUser = response!.data['data'];
            dataAdmin = response!.data['data'];
            dataKhusus = response!.data['data'];
            if (dataUser['role'] == 1) {
              // print("Lempar ke halaman user");
              Navigator.pushNamed(context, HomeUserScreen.routeName,
                  arguments: dataUser);
            } else if (dataUser['role'] == 2) {
              Navigator.pushNamed(context, HomeAdminScreens.routeName,
                  arguments: dataAdmin);
            } else if (dataUser['role'] == 3) {
              Navigator.pushNamed(context, AdminKhususScreen.routeName,
                  arguments: dataKhusus);
            } else {
              print("Page not found");
            }
            // Navigator.pushNamed(context, LoginScreen.routeName);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'Log in failed, $msg',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          },
        ).show();
      }
      if (remember) {
        saveUsername(username!);
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
