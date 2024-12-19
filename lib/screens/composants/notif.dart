import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/screens/pages/notif_pages.dart';

class Notif extends StatelessWidget {
  const Notif({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(right: 24),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotifPages()));
            },
            icon: Icon(
              size: 35,
              Icons.notifications_none,
              color: theme.primaryColor,
            ),
          ),
          Positioned(
              left: 5,
              top: 5,
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: Colors.red),
                child: Center(
                  child: Text("0"),
                ),
              ))
        ],
      ),
    );
  }
}
