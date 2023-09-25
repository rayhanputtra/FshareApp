import 'package:flutter/material.dart';
import 'package:food_sharing/Components/User/Transaksi/CreateTransaksi/DataTransaksi/DataTransaksiComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';
import '../EditDataAccount/editaccountPenerimaScreen.dart';
import '../HomeUserScreen.dart';

class DataTransaksiScreen extends StatelessWidget {
  static var routeName = '/data_transaksiusers_screens';
  static var dataTransaksi;

  const DataTransaksiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataTransaksi = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorBlue,
        title: const Text(
          "Transaction List",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: DataTransaksiComponent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kColorBlue,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, HomeUserScreen.routeName,
                arguments: dataTransaksi);
          } else if (index == 1) {
            // Navigator.pushNamed(context, DataTransaksiScreen.routeName,
            //     arguments: dataTransaksi);
          } else if (index == 2) {
            Navigator.pushNamed(context, EditAccountPenerimaScreen.routeName,
                arguments: dataTransaksi);
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
