import 'dart:async';
import 'timerModel.dart';

class CountTimer{
  double _raduis = 1;
  bool _isActive = true;
  late Timer timer;
  late Duration _time;
  late Duration _fulltime;

  String returnTime(Duration t){
    String minutes = (t.inMinutes < 10)? "0"+t.inMinutes.toString(): t.inMinutes.toString();
    int minSeconds = t.inSeconds -(t.inMinutes*60);
    String seconds = (minSeconds < 10) ? "0"+minSeconds.toString() : minSeconds.toString();
    return minutes + ":" +seconds;
  }

  Stream<TimerModel> stream() async*{
    yield*  Stream.periodic(Duration(seconds: 1),(int a){
      String time;
      if(_isActive){
        _time = _time - Duration(seconds: 1);
        _raduis = _time.inSeconds/_fulltime.inSeconds;
        if(_time.inSeconds<=0){
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time, _raduis);
    }
    );
  }


}