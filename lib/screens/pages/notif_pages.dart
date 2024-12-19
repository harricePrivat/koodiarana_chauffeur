import 'package:flutter/material.dart';

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
            children: [Text("Aucune notification")],
          ),
        ),
      ),
    );
  }
}
