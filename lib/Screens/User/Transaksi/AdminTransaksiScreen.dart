import 'package:flutter/material.dart';
import 'package:food_sharing/Components/User/Transaksi/CreateTransaksi/AdminTransaksi/AdminKhususTransaksiForm.dart';
import 'package:food_sharing/Screens/Admin/AdminKhususScreen.dart';
import 'package:food_sharing/Screens/User/EditDataAccount/editaccountKususScreen.dart';
import '../../../Components/User/Transaksi/CreateTransaksi/AdminTransaksi/AdminKususTransaksiComponent.dart';
import '../../../Components/User/Transaksi/CreateTransaksi/PemberiTransaksiComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';
import '../EditDataAccount/editaccountScreen.dart';

class AdminTransaksiScreen extends StatelessWidget {
  static var routeName = '/Admin_transaksi_screen';
  static var dataPemberi;

  const AdminTransaksiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataPemberi = ModalRoute.of(context)!.settings.arguments as Map;
    print(dataPemberi);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 175, 101),
        title: const Text(
          "Food Request List",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const AdminKususTransaksiComponent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 17, 175, 101),
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, AdminKhususScreen.routeName,
                arguments: dataPemberi);
          } else if (index == 1) {
            // Navigator.pushNamed(context, AdminTransaksiScreen.routeName,
            //     arguments: dataPemberi);
          } else if (index == 2) {
            Navigator.pushNamed(context, EditaccountKususScreen.routeName,
                arguments: dataPemberi);
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
