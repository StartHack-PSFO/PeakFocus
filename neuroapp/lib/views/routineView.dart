import 'package:flutter/material.dart';

class RoutineView extends StatefulWidget {
  const RoutineView({Key? key}) : super(key: key);

  @override
  _RoutineViewState createState() => _RoutineViewState();
}

class _RoutineViewState extends State<RoutineView> {
  double _progress = 0.42; // Set your initial percentage value here
  bool _isMuted = false; // Track the mute state
  bool _canVibrate = false; // Track the mute state

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });

    // Call your service here with the _isMuted value
    // For example: _myService.setMute(_isMuted);
  }

  void _toggleVibrate() {
    setState(() {
      _canVibrate = !_canVibrate;
    });

    // Call your service here with the _isMuted value
    // For example: _myService.setMute(_isMuted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Routine View'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: -1, // Rotate the progress bar by 90 degrees
                    child: Container(
                      width: 500.0, // Custom width for the progress bar
                      height: 100.0, // Custom height for the progress bar
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: LinearProgressIndicator(
                          value: _progress,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('$_progress%'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 32.0,
            right: 16.0,
            child: Column(
              children: [
                SizedBox(
                  height: 70.0,
                  width: 70.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        50.0), // Set the border radius for rounded corners
                    child: Container(
                      // color: Theme.of(context).colorScheme.tertiary,
                      child: TextButton(
                        onPressed: _toggleMute,
                        child: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                          size: 42.0, // Set the size of the icon
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70.0,
                  width: 70.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        50.0), // Set the border radius for rounded corners
                    child: Container(
                      // color: Theme.of(context).colorScheme.tertiary,
                      child: TextButton(
                        onPressed: _toggleVibrate,
                        child: Icon(
                          _canVibrate
                              ? Icons.vibration
                              : Icons.phone_android_rounded,
                          size: 42.0, // Set the size of the icon
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
