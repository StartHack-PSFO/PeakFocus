import 'dart:ffi';

import 'package:get/get.dart';
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

  @override
  void onReady() {
    // TODO: implement onReady
    getData();
    super.onReady();
  }

  void toggleMute() {
    isMuted = !isMuted;
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
