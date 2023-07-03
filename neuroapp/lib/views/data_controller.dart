import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuroapp/services/soundService.dart';
import 'package:neuroapp/views/resultView.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../services/service_models.dart';
import '../services/vibrationService.dart';

class DataController extends GetxController {
  static DataController get to => Get.find();
  static double brainDataThreshold = 0.8;
  static int brainDataAboveThresholdDuration = 2000; // milliseconds

  late Socket client;
  late StreamSubscription<Uint8List> subscription;

  double brainData = 0.0;

  bool isMuted = false;
  bool canVibrate = false;

  bool showOverlay = true;

  double sum = 0;
  double counter = 0;

  // To determine if the routine is over.
  DateTime? startTime;
  DateTime? firstTimeAboveThreshold;
  bool brainDataAboveThreshold = false;
  bool routineIsActive = false;

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  Future<void> hideOverlay() async {
    //hide iverlay after 5 seconds
    await Future.delayed(const Duration(seconds: 2), () {
      showOverlay = false;
      update(['stack']);
    });
  }

  Future<void> initMethod() async {
    SoundService.setVolume(1.0);
    SoundService.playSound('bleep-sound.mp3');
    showOverlay = true;
    await hideOverlay();
    soundManager();
  }

  void soundManager() async {
    if (!isMuted && !SoundService.isSoundPlaying) {
      SoundService.playSound('bleep-sound.mp3');
    }
    if (isMuted) {
      SoundService.stopSound();
    }
  }

  void toggleMute() {
    isMuted = !isMuted;
    if (isMuted) {
      SoundService.stopSound();
    } else {
      soundManager();
    }
    update(['controlColumn']);
  }

  void toggleVibrate() {
    canVibrate = !canVibrate;
    update(['controlColumn']);
  }

  void getData() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (routineIsActive) {
        var currentTime = DateTime.now().millisecondsSinceEpoch;
        brainData = (sin(currentTime / 1000) / (pi / 2)).abs();
        brainData += Random().nextDouble() / 10;
        sum += brainData;
        counter++;
        SoundService.setVolume(1 - brainData);
        update(['brainDataIndicator']);
        if (brainData > brainDataThreshold &&
            startTime != null &&
            DateTime.now().difference(startTime!) >=
                const Duration(milliseconds: 20000)) {
          if (firstTimeAboveThreshold == null) {
            firstTimeAboveThreshold = DateTime.now();
            print('First time above threshold: ' + brainData.toString());
          }
          if (firstTimeAboveThreshold != null &&
              DateTime.now().difference(firstTimeAboveThreshold!) >=
                  Duration(milliseconds: brainDataAboveThresholdDuration)) {
            print('Routine is over now!');
            SoundService.stopSound();
            VibrationService.stopVibration();
            routineIsActive = false;
            Navigator.pushReplacement(
              Get.context!,
              MaterialPageRoute(
                builder: (_) => ResultView(),
              ),
            );
          }
        } else {
          firstTimeAboveThreshold = null;
          print('Reset FirstTimeAboveThreshold.');
        }
      }
    });
  }

  void closeConnection() {
    if (client != null) {
      subscription.cancel();
      print('Connection closed');
    }
  }
}
