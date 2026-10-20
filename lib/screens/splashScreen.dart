import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movieapp/screens/authGate.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              AuthGate() ,
        ),
      );
    });
  }

@override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242A32),
      body: Center(
        child: Lottie.asset('assets/animations/Popcorn.json'),
      ),
    );  }
}
