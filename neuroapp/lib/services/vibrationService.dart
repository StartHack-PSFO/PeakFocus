import 'package:vibration/vibration.dart';

class VibrationService {
  static Future<void> vibrateForDuration({int duration = 1}) async {
    var hasVibration = await Vibration.hasVibrator();
    if (hasVibration != null && hasVibration) {
      Vibration.vibrate(duration: duration * 1000);
    }
  }

  static Future<void> startVibration() async {
    var hasVibration = await Vibration.hasVibrator();
    if (hasVibration != null && hasVibration) {
      Vibration.vibrate();
    }
  }

  static void stopVibration() {
    Vibration.cancel();
  }

}
