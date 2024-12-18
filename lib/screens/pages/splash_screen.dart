import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/main.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppManager>(context, listen: false).initializeApp();
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Koodiarana',
          style: TextStyle(
              fontSize: 35.0,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
