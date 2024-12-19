import 'package:flutter/material.dart';

class Historiques extends StatefulWidget {
  const Historiques({super.key});

  @override
  State<Historiques> createState() => _HistoriquesState();
}

class _HistoriquesState extends State<Historiques> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Historiques"),
        ),
        body: Center(
          child: Text("Aucune historique pour ce moment"),
        ));
  }
}
