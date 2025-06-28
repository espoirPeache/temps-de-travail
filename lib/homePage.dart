import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'widget.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  final paddingDefault = 8.0;
  void method1(){

  }
  void method2(){

  }

  @override
  Widget build(BuildContext context) {
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
                Expanded(
                    child: CircularPercentIndicator(
                        radius: width/2.3,
                      lineWidth: 20,
                      percent: 0.8,
                      backgroundColor: Colors.blue,
                      center: Text("30:00", style: Theme.of(context).textTheme   .displayMedium,),
                      progressColor: Colors.lightGreen,


                    )
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
