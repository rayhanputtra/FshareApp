import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/Admin/Crud/InputMakananScreen.dart';
import 'package:food_sharing/Screens/User/EditDataAccount/editaccountKususScreen.dart';
import '../../Components/Admin/HomeAdminKhususComp.dart';
import '../../size_config.dart';
import '../../utils/constans.dart';
import '../Login/LoginScreen.dart';
import '../User/EditDataAccount/editaccountScreen.dart';
import '../User/Transaksi/AdminTransaksiScreen.dart';
import '../User/Transaksi/PemberiTransaksiScreen.dart';

class AdminKhususScreen extends StatelessWidget {
  static var routeName = '/admin_khusus__screens';
  static var datakhusus;

  const AdminKhususScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    datakhusus = ModalRoute.of(context)!.settings.arguments as Map;
    print(datakhusus);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 175, 101),
        title: Padding(
          padding: EdgeInsets.only(left: 18), // Tambahkan padding di sini
          child: Text(
            "FShare",
            style: TextStyle(
              color: mTitleColor,
              fontWeight: FontWeight.bold,
              fontFamily: "LeckerliOne",
              fontSize: 24,
            ),
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, InputMakananScreen.routeName);
            },
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: mTitleColor,
                ),
                Text(
                  "Data input",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: const AdminKhususComponent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 17, 175, 101),
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // Navigator.pushNamed(context, AdminKhususScreen.routeName,
            //     arguments: datakhusus);
          } else if (index == 1) {
            Navigator.pushNamed(context, AdminTransaksiScreen.routeName,
                arguments: datakhusus);
          } else if (index == 2) {
            Navigator.pushNamed(context, EditaccountKususScreen.routeName,
                arguments: datakhusus);
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
