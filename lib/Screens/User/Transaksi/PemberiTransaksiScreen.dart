import 'package:flutter/material.dart';
import '../../../Components/User/Transaksi/CreateTransaksi/PemberiTransaksiComponent.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';
import '../../Admin/HomeAdminScreen.dart';
import '../EditDataAccount/editaccountScreen.dart';

class PemberiTransaksiScreen extends StatelessWidget {
  static var routeName = '/pemberi_transaksi_screen';
  static var dataPemberi;

  const PemberiTransaksiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataPemberi = ModalRoute.of(context)!.settings.arguments as Map;
    print(dataPemberi);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Food Request List",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const PemberiTransaksiComponent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, HomeAdminScreens.routeName,
                arguments: dataPemberi);
          } else if (index == 1) {
            // Navigator.pushNamed(context, PemberiTransaksiScreen.routeName,
            //     arguments: dataPemberi);
          } else if (index == 2) {
            Navigator.pushNamed(context, EditAccountScreen.routeName,
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
