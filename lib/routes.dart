import 'package:flutter/cupertino.dart';
import 'package:food_sharing/Screens/Admin/Crud/InputMakananScreen.dart';
import 'package:food_sharing/Screens/Login/LoginScreen.dart';
import 'package:food_sharing/Screens/User/Transaksi/DataTransaksi.dart';
import 'package:food_sharing/Screens/User/Transaksi/UploadBukti.dart';
import 'Components/Admin/HomeAdminComponent.dart';
import 'Components/User/Transaksi/CreateTransaksi/PemberiTransaksiComponent.dart';
import 'Screens/Admin/AdminKhususScreen.dart';
import 'Screens/Admin/Crud/EditDataScreen.dart';
import 'Screens/Admin/Crud/VerifikasiScreen.dart';
import 'Screens/Admin/HomeAdminScreen.dart';
import 'Screens/Login/SplashScreen.dart';
import 'Screens/Pilihan/PilihanScreen.dart';
// import 'Screens/Polyline/PolylineScreen.dart';
import 'Screens/Polyline/beforepolyline.dart';
import 'Screens/Register/PenerimaScreen.dart';
import 'Screens/Register/Register.dart';
import 'Screens/User/EditDataAccount/editaccountKususScreen.dart';
import 'Screens/User/EditDataAccount/editaccountPenerimaScreen.dart';
import 'Screens/User/EditDataAccount/editaccountScreen.dart';
import 'Screens/User/HomeUserScreen.dart';
import 'Screens/User/Makanan/DataMakananScreen.dart';
import 'Screens/User/Transaksi/AdminTransaksiScreen.dart';
import 'Screens/User/Transaksi/NotifikasiAdminScreen.dart';
import 'Screens/User/Transaksi/NotifikasiScreen.dart';
import 'Screens/User/Transaksi/PemberiTransaksiScreen.dart';
import 'Screens/User/Transaksi/TransaksiScreen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  PilihanScreen.routeName: (context) => const PilihanScreen(),
  PenerimaScreen.routeName: (context) => const PenerimaScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),

  //USER
  HomeUserScreen.routeName: (context) => const HomeUserScreen(),
  DataMakananScreen.routeName: (context) => const DataMakananScreen(),
  TransaksiScreen.routeName: (context) => const TransaksiScreen(),
  DataTransaksiScreen.routeName: (context) => const DataTransaksiScreen(),
  UploadBuktiScreen.routeName: (context) => const UploadBuktiScreen(),
  // PolylineScreen.routeName: (context) => const PolylineScreen(),
  beforePolyline.routeName: (context) => const beforePolyline(),
  EditAccountScreen.routeName: (context) => const EditAccountScreen(),
  EditAccountPenerimaScreen.routeName: (context) =>
      const EditAccountPenerimaScreen(),

  //ADMIN
  HomeAdminScreens.routeName: (context) => const HomeAdminScreens(),
  InputMakananScreen.routeName: (context) => const InputMakananScreen(),
  EditDataScreen.routeName: (context) => const EditDataScreen(),
  AdminKhususScreen.routeName: (context) => const AdminKhususScreen(),
  PemberiTransaksiScreen.routeName: (context) => const PemberiTransaksiScreen(),
  NotifikasiScreen.routeName: (context) => const NotifikasiScreen(),
  VerifikasiScreen.routeName: (context) => const VerifikasiScreen(),
  EditaccountKususScreen.routeName: (context) => const EditaccountKususScreen(),
  AdminTransaksiScreen.routeName: (context) => const AdminTransaksiScreen(),
  NotifikasiAdmin.routeName: (context) => const NotifikasiAdmin(),
};
