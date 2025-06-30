import 'package:flutter/material.dart';
import 'package:gestion_de_temps/widget.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 24);
    return Scaffold(
      appBar: AppBar(
        title: Text("Parametre"),
        backgroundColor: Theme.of(context).primaryColorDark
      ),

      body:GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 3,
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          Text("Travail", style: style,),
          Text(""),
          Text(""),
          SettingsButton(Colors.blue, "-", 1),
          TextField(
            style: style,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(Colors.blue, "+", 1),

          Text("Pause courte", style: style,),
          Text(""),
          Text(""),
          SettingsButton(Colors.blue, "-", 1),
          TextField(
            style: style,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(Colors.blue, "+", 1),
          Text("Pause longue", style: style,),
          Text(""),
          Text(""),
          SettingsButton(Colors.blue, "-", 1),
          TextField(
            style: style,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(Colors.blue, "+", 1),
        ],
      ) ,
    );

  }
}
