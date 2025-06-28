import 'package:flutter/material.dart';
import 'package:gestion_de_temps/timerModel.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'timer.dart';
import 'widget.dart';

class Homepage extends StatelessWidget {
   Homepage({super.key});

  final paddingDefault = 8.0;
  final CountTimer timer = CountTimer();

  void method1(){

  }
  void method2(){

  }

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon temps de travail"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: LayoutBuilder(
          builder: (context, BoxConstraints contraints){
            final double width = contraints.maxWidth;
            final double height = contraints.maxHeight;
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(paddingDefault),
                        child: Button(color: Colors.blueAccent, size: 0, text: "Travail", onPresed: method1,),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(paddingDefault),
                        child: Button(color: Colors.lightBlueAccent, size: 0, text: "Pause courte", onPresed: method1,),

                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(paddingDefault),
                        child: Button(color: Colors.blueGrey, size: 0, text: "Pause longue", onPresed: method1,),

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
                          lineWidth: 20,
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
                                fontFamily: 'RobotoMono', // police numérique sympa
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
                          child: Button(size: 0, color: Colors.red, text: "stop", onPresed: method2),
                        )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(paddingDefault),
                          child: Button(size: 0, color: Colors.green, text: "start", onPresed:method2),
                        )
                    )
                  ],
                )


              ],
            );
          }
      ),
    );
  }
}
