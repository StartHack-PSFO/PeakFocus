import 'dart:async';
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
          'Countdown: $_countdown',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
