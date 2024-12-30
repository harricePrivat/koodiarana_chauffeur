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
          // title: Text(widget.title),
          ),
      body: Center(
          // child: Text(widget.subTitle),
          ),
    );
  }
}
