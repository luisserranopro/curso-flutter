import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:firebaseapp/main.dart';




class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final User? usuario = FirebaseAuth.instance.currentUser;
    String? email = "";

    if (usuario!=null)
      email = usuario.email;

    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        title: TextButton.icon(
          onPressed: () {
            _salir(context);
          },
          label: Text('Salir',
              style: TextStyle(fontSize: 25, color: Colors.white)),
          icon: Icon(
            Icons.logout,
            color: Colors.white70,
          ),
        ),
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Center(
        child: Text(
          'Bienvenido \n' + email!,
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    );

  }


  void _salir(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }
}