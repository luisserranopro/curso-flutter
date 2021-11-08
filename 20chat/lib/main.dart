import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat/listamensajes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejemplo Chat',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ListaMensajes(),
    );
  }



}
