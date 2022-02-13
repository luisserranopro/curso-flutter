import 'package:flutter/material.dart';
import 'package:mongodb/bd/mongodb.dart';
import 'package:mongodb/ui/portada.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.conectar();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Portada(),
    );
  }
}
