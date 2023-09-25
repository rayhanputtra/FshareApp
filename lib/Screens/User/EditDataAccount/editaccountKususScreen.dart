import 'package:flutter/material.dart';

import '../../../Components/User/EditAccountAdmin/EditAccountKususComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';
import '../../Admin/AdminKhususScreen.dart';
import '../Transaksi/AdminTransaksiScreen.dart';
import '../Transaksi/PemberiTransaksiScreen.dart';

class EditaccountKususScreen extends StatelessWidget {
  static var routeName = '/edit_account_kusus_screen';
  static var dataAccount;

  const EditaccountKususScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataAccount = ModalRoute.of(context)!.settings.arguments as Map;
    print(dataAccount);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 175, 101),
        title: const Text(
          "Admin Account Information",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const EditAccountKususComponent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 17, 175, 101),
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, AdminKhususScreen.routeName,
                arguments: dataAccount);
          } else if (index == 1) {
            Navigator.pushNamed(context, AdminTransaksiScreen.routeName,
                arguments: dataAccount);
          } else if (index == 2) {
            // Navigator.pushNamed(context, EditAccountKususScreen.routeName,
            //     arguments: dataAccount);
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
