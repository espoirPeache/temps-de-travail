import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_de_temps/homePage.dart';

import 'timer.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await preloadFont();
  runApp(MyApp());
}

Future<void> preloadFont() async {
  final fontLoader = FontLoader('Digital');
  fontLoader.addFont(rootBundle.load("fonts/digital-7 (mono).ttf"));
  await fontLoader.load();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "gestion de temps",
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: Homepage(),

    );
  }
}