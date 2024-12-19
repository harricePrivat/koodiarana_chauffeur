import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/providers/navigation_manager.dart';
import 'package:koodiarana_chauffeur/screens/composants/notif.dart';
import 'package:koodiarana_chauffeur/screens/pages/page1.dart';
import 'package:koodiarana_chauffeur/screens/pages/page2.dart';
import 'package:koodiarana_chauffeur/services/connectivity.dart';

import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<Widget> listPages = [Page1(), Page2()];

  @override
  void initState() {
    super.initState();
    ConnectivityServices().checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<NavigationManager>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 16,
          title: Text(
            tabManager.tabValue == 0 ? "Activités" : "Comptes",
            style: theme.textTheme.displayLarge,
          ),
          actions: [Notif()],
        ),
        body: listPages[tabManager.tabValue],
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            selectedIconTheme:
                IconThemeData(size: 40, color: theme.primaryColor),
            unselectedItemColor: theme.primaryColor,
            unselectedLabelStyle: TextStyle(color: theme.primaryColor),
            currentIndex: tabManager.tabValue,
            onTap: (value) {
              tabManager.changeTab(value);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.motorcycle), label: 'Acitivite'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Compte')
            ]),
      );
    });
  }
}
