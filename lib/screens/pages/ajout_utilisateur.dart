import 'package:flutter/material.dart';

class AjoutUtilisateur extends StatefulWidget {
  const AjoutUtilisateur({super.key});

  @override
  State<AjoutUtilisateur> createState() => _AjoutUtilisateurState();
}

class _AjoutUtilisateurState extends State<AjoutUtilisateur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout d'utilisateur"),
      ),
      body: Center(
        child: Text("Ajout d'utilisateur"),
      ),
    );
  }
}
