import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/Admin/Crud/InputMakananScreen.dart';
import '../../Components/Admin/HomeAdminComponent.dart';
import '../../size_config.dart';
import '../../utils/constans.dart';
import '../Login/LoginScreen.dart';
import '../User/EditDataAccount/editaccountScreen.dart';
import '../User/Transaksi/PemberiTransaksiScreen.dart';

class HomeAdminScreens extends StatelessWidget {
  static var routeName = '/home_admin_screens';
  static var dataAdminLogin;

  const HomeAdminScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataAdminLogin = ModalRoute.of(context)!.settings.arguments as Map;
    print(dataAdminLogin);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
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
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: const HomeAdminComponent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // Navigator.pushNamed(context, HomeAdminScreens.routeName);
          } else if (index == 1) {
            Navigator.pushNamed(context, PemberiTransaksiScreen.routeName,
                arguments: dataAdminLogin);
          } else if (index == 2) {
            Navigator.pushNamed(context, EditAccountScreen.routeName,
                arguments: dataAdminLogin);
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
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 550, // Sesuaikan dengan posisi vertikal yang diinginkan
            right: 5, // Sesuaikan dengan posisi horizontal yang diinginkan
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 90),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, InputMakananScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kColorTealToSlow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ), // Ubah ukuran button sesuai kebutuhan
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Food Donation',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
