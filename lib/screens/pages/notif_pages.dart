import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/screens/composants/notif_composant.dart';

class NotifPages extends StatefulWidget {
  const NotifPages({super.key});

  @override
  State<NotifPages> createState() => _NotifPagesState();
}

class _NotifPagesState extends State<NotifPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NotifComposant(
                title: "Hianatra",
                subTitle: "a 17h a Ankatso",
              )
            ],
          ),
        ),
      ),
    );
  }
}
