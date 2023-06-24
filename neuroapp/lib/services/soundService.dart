import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class SoundService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playSound(String soundPath, int stopAfterDelay) async {
    try {
      await _audioPlayer.play(AssetSource(soundPath));
      Timer(Duration(seconds: stopAfterDelay), () {
        _audioPlayer.stop();
      });
    } catch (e) {
      print('Failed to play sound: $e');
    }
  }

  static void stopSound() {
    _audioPlayer.stop();
  }
}
