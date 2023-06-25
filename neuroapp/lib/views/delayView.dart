import 'dart:async';
import 'dart:ffi';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:neuroapp/services/vibrationService.dart';
import 'package:neuroapp/views/rotatingDotCircle.dart';
import 'package:neuroapp/views/routineView.dart';
import 'package:vibration/vibration.dart';

import '../services/soundService.dart';
import './rotatingDotCircle.dart';

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
          // SoundService.playSoundAndStopAfterDelay('bleep-sound.mp3', 2);
          // VibrationService.vibrateForDuration(duration: 2);
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
        child: Padding(
          padding: EdgeInsets.all(80.0), // Adjust the padding value as needed
          child: RotatingDotCircle(countdown: _countdown),
        ),
      ),
    );
  }
}
