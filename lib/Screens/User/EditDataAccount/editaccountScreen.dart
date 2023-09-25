import 'package:flutter/material.dart';

import '../../../Components/User/EditAccontComp/EditAccountComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';
import '../../Admin/HomeAdminScreen.dart';
import '../Transaksi/PemberiTransaksiScreen.dart';

class EditAccountScreen extends StatelessWidget {
  static var routeName = '/edit_account';
  static var dataAccount;

  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataAccount = ModalRoute.of(context)!.settings.arguments as Map;
    print(dataAccount);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Account Information",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const EditUserComponent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, HomeAdminScreens.routeName,
                arguments: dataAccount);
          } else if (index == 1) {
            Navigator.pushNamed(context, PemberiTransaksiScreen.routeName,
                arguments: dataAccount);
          } else if (index == 2) {
            // Navigator.pushNamed(context, EditAccountScreen.routeName,
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
