import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuroapp/services/soundService.dart';
import 'package:neuroapp/services/vibrationService.dart';
import 'package:neuroapp/views/data_controller.dart';
import 'package:neuroapp/views/resultView.dart';

class RoutineView extends StatelessWidget {
  DateTime? startTime;

  RoutineView() {
    DataController.to.initMethod();
    startTime = DateTime.now();
    // Reset the Start Time of the Routine
    DataController.to.startTime = startTime;
    DataController.to.firstTimeAboveThreshold = null;
    DataController.to.brainDataAboveThreshold = false;
    DataController.to.routineIsActive = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        forceMaterialTransparency: true,
      ),
      body: GetBuilder<DataController>(
          id: 'stack',
          builder: (_) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns:
                              -1, // Rotate the progress bar by 90 degrees
                          child: Container(
                            width: 500.0, // Custom width for the progress bar
                            height: 100.0, // Custom height for the progress bar
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: GetBuilder<DataController>(
                                  id: 'brainDataIndicator',
                                  builder: (_) {
                                    return LinearProgressIndicator(
                                      value: DataController.to.brainData,
                                    );
                                  }),
                            ),
                          ),
                        ),
                        GetBuilder<DataController>(
                            id: 'brainDataIndicator',
                            builder: (_) {
                              return Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                    '${DataController.to.brainData.toStringAsFixed(2)}%'),
                              );
                            }),
                        ElevatedButton(
                          onPressed: () {
                            SoundService.stopSound();
                            VibrationService.stopVibration();
                            DataController.to.routineIsActive = false;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultView(),
                              ),
                            );
                          },
                          child: const Text(
                            'See results',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 32.0,
                  right: 16.0,
                  child: GetBuilder<DataController>(
                      id: 'controlColumn',
                      builder: (_) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 40,
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
                                    onPressed: DataController.to.toggleMute,
                                    child: Icon(
                                      DataController.to.isMuted
                                          ? Icons.volume_off
                                          : Icons.volume_up,
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
                                    onPressed: DataController.to.toggleVibrate,
                                    child: Icon(
                                      DataController.to.canVibrate
                                          ? Icons.vibration
                                          : Icons.phone_android_rounded,
                                      size: 42.0, // Set the size of the icon
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                if (DataController.to.showOverlay)
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Image.asset('assets/reach.png'),
                      ),
                    ),
                  ),
              ],
            );
          }),
    );
  }
}
