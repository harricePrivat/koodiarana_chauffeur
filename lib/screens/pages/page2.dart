import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/providers/navigation_manager.dart';
import 'package:koodiarana_chauffeur/screens/composants/parameters.dart';
import 'package:koodiarana_chauffeur/screens/composants/rating.dart';
import 'package:koodiarana_chauffeur/screens/pages/historiques.dart';
import 'package:koodiarana_chauffeur/screens/pages/mention_legale.dart';
import 'package:koodiarana_chauffeur/screens/pages/payement.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'message.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page1State();
}

class _Page1State extends State<Page2> {
  late ScrollController _scrollController;
  bool isVisible = true;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          isVisible = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          isVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context, listen: false);
    final user = Provider.of<AppManager>(context, listen: false).getUsers;
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          elevation: 30,
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30.00))),
          bottom: isVisible
              ? PreferredSize(
                  preferredSize: const Size(double.infinity, 65),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16.00, left: 16.00, right: 16.00),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(user!.nom,
                                    style: textTheme.titleLarge),
                              ),
                              //Icon(Icons.person, size: 50)
                              ShadAvatar(
                                placeholder: Image.asset(
                                  "assets/Logo_koodiarana.png",
                                ),
                                "assets/Logo_koodiarana.png",
                                size: Size(65, 65),
                              )
                            ],
                          ),
                          Rating()
                        ],
                      )))
              : PreferredSize(preferredSize: Size(0, 0), child: SizedBox()),
        ),
        body: ListView(
          //  controller: _scrollController,
          children: [
            Padding(
              padding: EdgeInsets.all(16.00),
              child: Column(
                spacing: 16.00,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Parameters(
                        icon: Icon(Icons.help),
                        descri: "Aide",
                        onTap: () {
                          Provider.of<AppManager>(context, listen: false)
                              .reFirstLogin();
                        },
                      ),
                      Parameters(
                        icon: Icon(Icons.payment),
                        descri: "Paiement",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Payement()));
                        },
                      ),
                      Parameters(
                          onTap: () {
                            Provider.of<NavigationManager>(context,
                                    listen: false)
                                .goToFirst();
                          },
                          icon: Icon(Icons.motorcycle),
                          descri: "Activité")
                    ],
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Message()));
                    },
                    leading: const Icon(Icons.mail),
                    title: const Text(
                      'Messages',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Historiques()));
                    },
                    leading: const Icon(Icons.history),
                    title: const Text(
                      'Historiques',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LegalNoticeScreen()));
                    },
                    leading: const Icon(Icons.warning),
                    title: const Text(
                      'Mention Légale',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      'Mon compte Koodiarana',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ShadButton(
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      Provider.of<AppManager>(context, listen: false)
                          .disconnected();
                      Provider.of<NavigationManager>(context, listen: false)
                          .goToFirst();
                    },
                    backgroundColor: Colors.grey,
                    decoration: ShadDecoration(color: Colors.grey),
                    child: Text(
                      "Déconnexion",
                      style: TextStyle(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
