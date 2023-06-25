import 'dart:ffi';

import 'package:get/get.dart';
import 'package:neuroapp/services/soundService.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../services/service_models.dart';

class DataController extends GetxController {
  static DataController get to => Get.find();

  late Socket client;
  late StreamSubscription<Uint8List> subscription;

  double brainData = 0.0;

  bool isMuted = false;
  bool canVibrate = false;

  bool showOverlay = true;

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

  void stopSound() {
    SoundService.stopSound();
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
          SoundService.setVolume(1 - brainData);
          update(['brainDataIndicator']);
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
