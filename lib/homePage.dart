import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_de_temps/settings.dart';
import 'package:gestion_de_temps/timerModel.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lottie/lottie.dart';

import 'timer.dart';
import 'widget.dart';

class Homepage extends StatefulWidget {

  late final String selectedBackground;

   Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final paddingDefault = 8.0;
  final CountTimer timer = CountTimer();

  final List<String> backgrounds = [
    'assets/animations/background1.json',
    'assets/animations/background2.json',
    'assets/animations/background3.json',
  ];
  late String selectedBackground;

  @override
  void initState() {
    super.initState();
    final random = Random();
    selectedBackground = backgrounds[random.nextInt(backgrounds.length)];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: timer.loadValues(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return _buildMainScreen(context);
      },
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon temps de travail"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Parametre",
                  child: Text("Parametre"),
                )
              ];
            },
            onSelected: (value) {
              if (value == "Parametre") {
                gotoSettings(context);
              }
            },
          )
        ],
      ),
      body: Stack(
        children:[
          Positioned.fill(
            child: Lottie.asset(selectedBackground, fit: BoxFit.cover),
          ),
          LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              final double width = constraints.maxWidth;
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(paddingDefault),
                          child: Button(color: Colors.blueAccent, size: 0, text: "Travail", onPresed:()=> timer.startWork(),),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(paddingDefault),
                          child: Button(color: Colors.lightBlueAccent, size: 0, text: "Pause courte", onPresed:()=>timer.startBreak(true),),

                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(paddingDefault),
                          child: Button(color: Colors.blueGrey, size: 0, text: "Pause longue", onPresed:()=>timer.startBreak(false)),

                        ),
                      ),
                    ],
                  ),
                  StreamBuilder(
                      stream: timer.stream(),
                      initialData: "00:00",
                      builder: (context, asyncSnapshot) {
                        TimerModel timer = (asyncSnapshot.data == "00:00") ? TimerModel("00:00", 1): asyncSnapshot.data as TimerModel;
                        return Expanded(
                            child: CircularPercentIndicator(
                              radius: width / 2.3,
                              lineWidth: 30,
                              animation: true,
                              animateFromLastPercent: true,
                              percent: timer.percent,
                              reverse: true,  // de droite vers la gauche
                              backgroundColor: Colors.grey.shade900,
                              circularStrokeCap: CircularStrokeCap.round, // bouts arrondis
                              linearGradient: LinearGradient(
                                colors: [
                                  Colors.cyanAccent,
                                  Colors.blueAccent,
                                  Colors.deepPurpleAccent,
                                ],
                              ),
                              center: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  timer.time,
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontFamily: 'Digital', // police numérique sympa
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyanAccent,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10,
                                        color: Colors.cyanAccent.withOpacity(0.7),
                                        offset: Offset(0, 0),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )

                        );
                      }
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(paddingDefault),
                            child: Button(size: 0, color: Colors.red, text: "stop", onPresed:()=> timer.stopTimer()),
                          )
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(paddingDefault),
                            child: Button(size: 0, color: Colors.green, text: "start", onPresed:()=> timer.startTimer()),
                          )
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ]
      ),
    );
  }

  void gotoSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Settings(timer),
      ),
    ).then((_) {
      setState(() {
        timer.startWork();
      });
    });
  }
}
