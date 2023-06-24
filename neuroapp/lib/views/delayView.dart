import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:neuroapp/views/routineView.dart';

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
          _playSound();
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

  void _playSound() async {
    try {
      final player = AudioPlayer();
      await player.play(AssetSource('bleep-sound.mp3'));
      Timer(Duration(seconds: 2), () {
        player.stop();
      });
    } catch (e) {
      print('Failed to play sound: $e');
    }
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
