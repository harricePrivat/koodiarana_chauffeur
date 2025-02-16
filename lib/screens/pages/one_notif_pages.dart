import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OneNotifPages extends StatefulWidget {
  // String title;
  //   String subTitle;

  const OneNotifPages({super.key
      //  ,required this.subTitle, required this.title
      });

  @override
  State<OneNotifPages> createState() => _OneNotifPagesState();
}

class _OneNotifPagesState extends State<OneNotifPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hianatra"),
        ),
        body: Column(
          spacing: 16.00,
          children: [
            Center(
              child: Text("Hianatra a Ankatso"),
            ),
          ],
        ));
  }
}
