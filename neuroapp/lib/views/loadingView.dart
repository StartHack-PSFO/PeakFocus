import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neuroapp/views/homeView.dart';

class LoadingView extends StatefulWidget {
  final int delay;

  const LoadingView({Key? key, required this.delay}) : super(key: key);

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
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
              builder: (context) => HomeView(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.1),
        child: Center(
          child: Image(
            image:
                AssetImage('assets/Logo@4.png'), // Replace with your image path
          ),
        ),
      ),
    );
  }
}
