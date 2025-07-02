import 'package:flutter/material.dart';
import 'package:gestion_de_temps/timer.dart';


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

  final List<String> units = ["seconds", "minutes", "hours"];
  String workUnit = "minutes";
  String shortUnit = "minutes";
  String longUnit = "minutes";


  @override
  void initState() {
    super.initState();

      workController = TextEditingController(text: "30");
      shortBreakController = TextEditingController(text: "5");
      longBreakController = TextEditingController(text: "10");
  }

  void updateValue(TextEditingController controller, int delta) {
    int currentValue = int.tryParse(controller.text) ?? 0;
    currentValue += delta;
    if (currentValue < 1) currentValue = 1; // Pas de durée < 1
    controller.text = currentValue.toString();
  }

  void saveValues() async {
    setState(() {
      widget.timer.work = int.tryParse(workController.text) ?? widget.timer.work;
      widget.timer.pauseCourte = int.tryParse(shortBreakController.text) ?? widget.timer.pauseCourte;
      widget.timer.pauseLongue = int.tryParse(longBreakController.text) ?? widget.timer.pauseLongue;
    });

    await widget.timer.saveValues();

    Navigator.pop(context); // Revenir à l'accueil
  }

  Widget buildSettingCard({
    required IconData icon,
    required String title,
    required TextEditingController controller,
    required String selectedUnit,
    required ValueChanged<String?> onUnitChanged,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: Theme.of(context).primaryColor),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                DropdownButton<String>(
                  value: selectedUnit,
                  items: units
                      .map((unit) => DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  ))
                      .toList(),
                  onChanged: onUnitChanged,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: onDecrement,
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.green),
                  onPressed: onIncrement,
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
          buildSettingCard(
          icon: Icons.work,
          title: "Travail",
          controller: workController,
          selectedUnit: workUnit,
          onUnitChanged: (value) {
            setState(() {
              workUnit = value ?? "minutes";
            });
          },
          onIncrement: () {
            setState(() {
              int v = int.parse(workController.text);
              workController.text = (v + 1).toString();
            });
          },
          onDecrement: () {
            setState(() {
              int v = int.parse(workController.text);
              if (v > 1) workController.text = (v - 1).toString();
            });
          },
        ),
            SizedBox(height: 12),
            buildSettingCard(
              icon: Icons.coffee,
              title: "pause courte",
              controller: shortBreakController,
              selectedUnit: shortUnit,
              onUnitChanged: (value) {
                setState(() {
                  shortUnit = value ?? "minutes";
                });
              },
              onIncrement: () {
                setState(() {
                  int v = int.parse(shortBreakController.text);
                  shortBreakController.text = (v + 1).toString();
                });
              },
              onDecrement: () {
                setState(() {
                  int v = int.parse(shortBreakController.text);
                  if (v > 1) shortBreakController.text = (v - 1).toString();
                });
              },
            ),
            SizedBox(height: 12),
        buildSettingCard(
          icon: Icons.hotel,
          title: "Longue Pause",
          controller: longBreakController,
          selectedUnit: longUnit,
          onUnitChanged: (value) {
            setState(() {
              longUnit = value ?? "minutes";
            });
          },
          onIncrement: () {
            setState(() {
              int v = int.parse(longBreakController.text);
              longBreakController.text = (v + 1).toString();
            });
          },
          onDecrement: () {
            setState(() {
              int v = int.parse(longBreakController.text);
              if (v > 1) longBreakController.text = (v - 1).toString();
            });
          },
        ),
          ],
        ),
      ),
    );

  }

  int getWorkInSeconds() {
    int value = int.parse(workController.text);
    switch (workUnit) {
      case "seconds":
        return value;
      case "minutes":
        return value * 60;
      case "hours":
        return value * 3600;
      default:
        return value * 60;
    }
  }
  int getShortBreakInSeconds() {
    int value = int.parse(shortBreakController.text);
    switch (shortUnit) {
      case "seconds":
        return value;
      case "minutes":
        return value * 60;
      case "hours":
        return value * 3600;
      default:
        return value * 60;
    }
  }

}
