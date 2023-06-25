import 'dart:ffi';

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
    // TODO: implement onReady
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
    if (!isMuted) {
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

  void getData() async {
    try {
      print('connecting to server...');
      client = await Socket.connect('10.181.64.35', 14535);
      ClientInitPackage clientInitPackage = ClientInitPackage();
      print('Connected to: '
          '${client.remoteAddress.address}:${client.remotePort}');
      client.write('${jsonEncode(clientInitPackage)}\n');
      client.flush();

      print("listening to socket... " +
          '${client.remoteAddress.address}:${client.remotePort}');
      subscription = client.listen((var data) {
        try {
          num json = jsonDecode(utf8.decode(data));

          // if (json != '') {
          brainData = json * 1.0;
          counter++;
          sum += brainData;
          SoundService.setVolume(1- brainData);
          update(['brainDataIndicator']);

          if (routineIsActive) {
            if (brainData > brainDataThreshold) {
              if (firstTimeAboveThreshold == null) {
                firstTimeAboveThreshold = DateTime.now();
                print('First time above threshold: ' + brainData.toString());
              }
              if (firstTimeAboveThreshold != null &&
                  DateTime.now().difference(firstTimeAboveThreshold!) >=
                      Duration(milliseconds: brainDataAboveThresholdDuration)) {
                print('Routine is over now!');
                SoundService.stopSound();
                Navigator.pushReplacement(
                  Get.context!,
                  MaterialPageRoute(
                    builder: (context) => ResultView(),
                  ),
                );

                routineIsActive = false;
              }
            } else {
              firstTimeAboveThreshold = null;
              print('Reset FirstTimeAboveThreshold.');
            }
          }
          // }
        } catch (e) {
          print("stream error" + e.toString());
        }
      }, onDone: () {
        print('Done');
        // client.close();
      }, onError: (e) {
        print('Got error $e');
        subscription.cancel();
      });
      print('main done');
    } catch (e) {
      print('Catched error $e');
    }
  }

  void closeConnection() {
    if (client != null) {
      subscription.cancel();
      print('Connection closed');
    }
  }
}
