import 'package:flutter/material.dart';
import 'package:gestion_de_temps/timer.dart';
import 'package:gestion_de_temps/widget.dart';

class Settings extends StatefulWidget {
  final CountTimer timer;
  const Settings(this.timer,{super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late TextEditingController workController;
  late TextEditingController shortBreakController;
  late TextEditingController longBreakController;

  @override
  void initState() {
    super.initState();

      workController = TextEditingController(text: widget.timer.work.toString());
      shortBreakController = TextEditingController(text: widget.timer.pauseCourte.toString());
      longBreakController = TextEditingController(text: widget.timer.pauseLongue.toString());
  }

  void updateValue(TextEditingController controller, int delta) {
    int currentValue = int.tryParse(controller.text) ?? 0;
    currentValue += delta;
    if (currentValue < 1) currentValue = 1; // Pas de durée < 1
    controller.text = currentValue.toString();
  }

  void saveValues() {
    setState(() {
      widget.timer.work = int.tryParse(workController.text) ?? widget.timer.work;
      widget.timer.pauseCourte = int.tryParse(shortBreakController.text) ?? widget.timer.pauseCourte;
      widget.timer.pauseLongue = int.tryParse(longBreakController.text) ?? widget.timer.pauseLongue;
    });
    Navigator.pop(context); // Revenir à la page principale
  }


  @override
  void dispose() {
    workController.dispose();
    shortBreakController.dispose();
    longBreakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 24);
    return Scaffold(
      appBar: AppBar(
        title: Text("Parametre"),
        backgroundColor: Theme.of(context).primaryColorLight,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveValues,
          ),
        ],

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
          SettingsButton(Colors.blue, "-", 1, onPressed: ()=>updateValue(workController, -1),),
          TextField(
            controller: workController,
            style: style,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(Colors.blue, "+", 1, onPressed: ()=>updateValue(workController, 1),),

          Text("Pause courte", style: style,),
          Text(""),
          Text(""),
          SettingsButton(Colors.blue, "-", 1, onPressed: ()=>updateValue(shortBreakController, -1),),
          TextField(
            controller: shortBreakController,
            style: style,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(Colors.blue, "+", 1, onPressed: ()=> updateValue(shortBreakController, 1)),
          Text("Pause longue", style: style,),
          Text(""),
          Text(""),
          SettingsButton(Colors.blue, "-", 1, onPressed: ()=> updateValue(longBreakController, -1),),
          TextField(
            controller: longBreakController,
            style: style,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(Colors.blue, "+", 1, onPressed: ()=> updateValue(longBreakController, 1),),
        ],
      ) ,
    );

  }
}
