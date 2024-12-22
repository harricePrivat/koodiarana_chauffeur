import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityServices {
  StreamSubscription<List<ConnectivityResult>> checkConnectivity(
      BuildContext context) {
    return Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      connectivitySnackBar(checkConnexion(result, context), context);
    });
  }

  Widget checkConnexion(List<ConnectivityResult> result, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (result.contains(ConnectivityResult.none)) {
      return Row(
        spacing: 16,
        children: [
          Icon(
            Icons.wifi_off,
            color: Colors.red,
          ),
          Text(
            'Hors ligne',
            style: textTheme.titleMedium,
          )
        ],
      );
    } 
    else {
      return Row(
        spacing: 16,
        children: [
          Icon(Icons.wifi, color: Colors.greenAccent),
          Text('En ligne', style: textTheme.titleMedium)
        ],
      );
    }
  }
}

void connectivitySnackBar(Widget message, BuildContext context) {
  final theme = Theme.of(context);

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: theme.scaffoldBackgroundColor,
    duration: Duration(seconds: 2),
    content: message,
  ));
}
