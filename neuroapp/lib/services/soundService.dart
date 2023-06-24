import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class SoundService {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static double _volume = 1.0;

  static Future<void> playSoundAndStopAfterDelay(
      String soundPath, int stopAfterDelay) async {
    try {
      await _audioPlayer.play(AssetSource(soundPath));
      Timer(Duration(seconds: stopAfterDelay), () {
        _audioPlayer.stop();
      });
    } catch (e) {
      print('Failed to play sound: $e');
    }
  }

  static Future<void> playSound(String soundPath) async {
    try {
      //loop the sound
      await _audioPlayer.play(AssetSource(soundPath));
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      print('Failed to play sound: $e');
    }
  }

  static void stopSound() {
    _audioPlayer.stop();
  }

  static void setVolume(double volume) {
    _volume = volume;
    if (_volume <= 0.0) {
      _volume = 0.00001;
    } else if (_volume > 1.0) {
      _volume = 1.0;
    }
    _audioPlayer.setVolume(_volume);
  }

  static void increaseVolume(double increment) {
    _volume = (_volume + increment).clamp(0.0, 1.0);
    _audioPlayer.setVolume(_volume);
  }

  static void decreaseVolume(double decrement) {
    _volume = (_volume - decrement).clamp(0.0, 1.0);
    _audioPlayer.setVolume(_volume);
  }
}
