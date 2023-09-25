import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/Login/LoginScreen.dart';
import 'package:food_sharing/Screens/User/EditDataAccount/editaccountScreen.dart';
import '../../Components/User/UserComponent.dart';
import '../../size_config.dart';
import '../../utils/constans.dart';
import 'EditDataAccount/editaccountPenerimaScreen.dart';
import 'Transaksi/DataTransaksi.dart';

class HomeUserScreen extends StatelessWidget {
  static String routeName = "/home_user";
  static var dataUserLogin;

  const HomeUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataUserLogin = ModalRoute.of(context)!.settings.arguments as Map;
    print(dataUserLogin);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kColorBlue,
          title: const Text(
            "FShare",
            style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
          ),
          leading: const Icon(
            Icons.home,
            color: mTitleColor,
          ),
          actions: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(
            //         context, EditAccountPenerimaScreen.routeName,
            //         arguments: dataUserLogin);
            //   },
            //   child: const Icon(
            //     Icons.person,
            //     color: mTitleColor,
            //   ),
            // ),
            // const SizedBox(
            //   width: 10,
            // ),
            // SizedBox(width: 10),
            // SizedBox(width: 10),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, LoginScreen.routeName);
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Color.fromARGB(255, 240, 101, 91),
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            //     child: Text(
            //       'Logout',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(width: 10),
          ]),
      body: HomeUserComponent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kColorBlue,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // Navigator.pushNamed(context, HomeUserScreen.routeName,
            //     arguments: dataUserLogin);
          } else if (index == 1) {
            Navigator.pushNamed(context, DataTransaksiScreen.routeName,
                arguments: dataUserLogin);
          } else if (index == 2) {
            Navigator.pushNamed(context, EditAccountPenerimaScreen.routeName,
                arguments: dataUserLogin);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 70, 69, 69),
      ),
    );
  }
}
