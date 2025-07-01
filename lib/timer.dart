import 'dart:async';
import 'timerModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountTimer{
  double _raduis = 1;
  bool _isActive = true;
  late Timer timer;
  late Duration _time;
  late Duration _fulltime;

  int work = 20;
  int pauseCourte = 5;
  int pauseLongue = 15;
  var percent;
  late String time;

  Future<void> loadValues() async {
    final prefs = await SharedPreferences.getInstance();

    work = prefs.getInt('work') ?? 20;
    pauseCourte = prefs.getInt('pauseCourte') ?? 5;
    pauseLongue = prefs.getInt('pauseLongue') ?? 15;
  }

  String returnTime(Duration t){
    String minutes = (t.inMinutes < 10)? "0${t.inMinutes}": t.inMinutes.toString();
    int minSeconds = t.inSeconds -(t.inMinutes*60);
    String seconds = (minSeconds < 10) ? "0$minSeconds" : minSeconds.toString();
    return "$minutes:$seconds";
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

  Future<void> saveValues() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('work', work);
    await prefs.setInt('pauseCourte', pauseCourte);
    await prefs.setInt('pauseLongue', pauseLongue);
  }


  void startWork(){
    _raduis = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fulltime = _time;
  }
  void stopTimer(){
    _isActive = false;
  }
  void startTimer(){
    if(_time.inSeconds > 0){
      _isActive = true;
    }
  }
  void startBreak(bool isShort){
    _raduis = 1;
    _time = Duration(minutes: (isShort)? pauseCourte : pauseLongue, seconds: 0);
    _fulltime = _time;

  }

}