import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/User/HomeUserScreen.dart';
import '../../../Components/User/EditAccountPenerimaComp/EditAccountPenerimaComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';
import '../Transaksi/DataTransaksi.dart';

class EditAccountPenerimaScreen extends StatelessWidget {
  static var routeName = '/edit_account_penerima';
  static var dataAccount;

  const EditAccountPenerimaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataAccount = ModalRoute.of(context)!.settings.arguments as Map;
    print(dataAccount);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorBlue,
        title: const Text(
          "Informasi Account",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const EditUserPenerimaComponent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kColorBlue,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, HomeUserScreen.routeName,
                arguments: dataAccount);
          } else if (index == 1) {
            Navigator.pushNamed(context, DataTransaksiScreen.routeName,
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
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 70, 69, 69),
      ),
    );
  }
}
