import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:koodiarana_chauffeur/models/user.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/providers/navigation_manager.dart';
import 'package:koodiarana_chauffeur/screens/composants/notif.dart';
import 'package:koodiarana_chauffeur/screens/pages/page1.dart';
import 'package:koodiarana_chauffeur/screens/pages/page2.dart';
import 'package:koodiarana_chauffeur/services/connectivity.dart';
import 'package:latlong2/latlong.dart';
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
  LatLng? _currentPosition;

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
      _currentPosition = LatLng(position.latitude, position.longitude);
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
      print(data);
      ws.sink.add(jsonEncode(data));
      print(data);
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
