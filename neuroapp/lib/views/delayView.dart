import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:neuroapp/views/routineView.dart';

import '../services/soundService.dart';

class DelayView extends StatefulWidget {
  final int delay;

  const DelayView({Key? key, required this.delay}) : super(key: key);

  @override
  _DelayViewState createState() => _DelayViewState();
}

class _DelayViewState extends State<DelayView> {
  late Timer _timer;
  int _countdown = 0;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdown = widget.delay;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
          SoundService.playSound('bleep-sound.mp3', 2);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RoutineView(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$_countdown',
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
