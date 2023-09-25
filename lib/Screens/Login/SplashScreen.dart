import 'package:flutter/material.dart';
import 'package:food_sharing/size_config.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Tambahkan delay untuk beberapa detik sebelum pindah ke LoginScreen
    Future.delayed(const Duration(seconds: 3), () {
      // Pindah ke LoginScreen setelah 3 detik dengan animasi slide ke atas yang lebih pelan
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(
              milliseconds: 1200), // Durasi animasi lebih lama (1.2 detik)
          pageBuilder: (context, animation, secondaryAnimation) =>
              LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.5);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
