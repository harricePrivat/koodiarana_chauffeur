import 'package:flutter/material.dart';

import '../pages/one_notif_pages.dart';

// ignore: must_be_immutable
class NotifComposant extends StatelessWidget {
  String title;
  String subTitle;
   NotifComposant({super.key, required this.subTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.notifications_none),
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OneNotifPages()));
      },
    );
  }
}
