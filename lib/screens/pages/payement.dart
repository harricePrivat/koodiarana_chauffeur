import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/screens/pages/loading.dart';

class Payement extends StatefulWidget {
  const Payement({super.key});

  @override
  State<Payement> createState() => _PayementState();
}

class _PayementState extends State<Payement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Loading(),
    );
  }
}
