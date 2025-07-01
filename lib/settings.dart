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
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              onIncrement: () {
                setState(() {
                  int value = int.parse(workController.text);
                  workController.text = (value + 1).toString();
                });
              },
              onDecrement: () {
                setState(() {
                  int value = int.parse(workController.text);
                  if (value > 1) {
                    workController.text = (value - 1).toString();
                  }
                });
              },
            ),
            SizedBox(height: 12),
            buildSettingCard(
              icon: Icons.coffee,
              title: "Pause courte",
              controller: shortBreakController,
              onIncrement: () {
                setState(() {
                  int value = int.parse(shortBreakController.text);
                  shortBreakController.text = (value + 1).toString();
                });
              },
              onDecrement: () {
                setState(() {
                  int value = int.parse(shortBreakController.text);
                  if (value > 1) {
                    shortBreakController.text = (value - 1).toString();
                  }
                });
              },
            ),
            SizedBox(height: 12),
            buildSettingCard(
              icon: Icons.hotel,
              title: "Pause longue",
              controller: longBreakController,
              onIncrement: () {
                setState(() {
                  int value = int.parse(longBreakController.text);
                  longBreakController.text = (value + 1).toString();
                });
              },
              onDecrement: () {
                setState(() {
                  int value = int.parse(longBreakController.text);
                  if (value > 1) {
                    longBreakController.text = (value - 1).toString();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );

  }
}
