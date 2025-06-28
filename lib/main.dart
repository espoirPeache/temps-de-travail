import 'package:flutter/material.dart';
import 'package:gestion_de_temps/homePage.dart';

import 'timer.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "gestion de temps",
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: Homepage(),

    );
  }
}