import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:koodiarana_chauffeur/models/user.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/providers/navigation_manager.dart';
import 'package:koodiarana_chauffeur/providers/scroll_manager.dart';
import 'package:koodiarana_chauffeur/screens/composants/notif.dart';
import 'package:koodiarana_chauffeur/screens/pages/page1.dart';
import 'package:koodiarana_chauffeur/screens/pages/page2.dart';
import 'package:koodiarana_chauffeur/services/connectivity.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<Widget> listPages = [Page1(), Page2()];
  Position? currentPosition;
  // LatLng? _currentPosition;

  final ws =
      WebSocketChannel.connect(Uri.parse("ws://192.168.43.224:9999/position"));
  @override
  void initState() {
    super.initState();
    getCurrentLocalisation();
    ConnectivityServices().checkConnectivity(context);
  }

  Future<void> getCurrentLocalisation() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error('Vous avez besoin de la permission');
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('La permission a ete refuse');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('La permission a ete refuse de maniere permanente');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = position;
    });
  }

  void listeningPosition(Users user) {
    const locationSettings =
        LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 3);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((position) {
      currentPosition = position;
      final data = {
        "mail": user.email,
        "longitude": currentPosition!.longitude.toString(),
        "latitude": currentPosition!.latitude.toString()
      };
      ws.sink.add(jsonEncode(data));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = Provider.of<AppManager>(context).getUsers;
    listeningPosition(user!);
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
          actions: [if (tabManager.tabValue == 0) Notif()],
        ),
        body: listPages[tabManager.tabValue],
        bottomNavigationBar: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: Provider.of<ScrollManager>(context, listen: true)
                    .isVisibleBottomBar
                ? kBottomNavigationBarHeight
                : 0,
            child: BottomNavigationBar(
            
              currentIndex: tabManager.tabValue,
              onTap: (index) {
                tabManager.changeTab(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Accueil"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: "Comptes")
              ],
            )),
      );
    });
  }
}
