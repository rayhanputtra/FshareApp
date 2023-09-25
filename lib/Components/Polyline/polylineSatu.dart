import 'package:flutter/material.dart';
import 'package:food_sharing/Screens/Polyline/PolylineScreen.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';

class polylineSatuComponent extends StatefulWidget {
  const polylineSatuComponent({Key? key}) : super(key: key);

  @override
  _polylineSatuComponent createState() => _polylineSatuComponent();
}

class _polylineSatuComponent extends State<polylineSatuComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Travel route",
          style: TextStyle(color: mTitleColor),
        ),
        automaticallyImplyLeading: false,
      ),
      body: const PolylineScreen(),
    );
  }
}
