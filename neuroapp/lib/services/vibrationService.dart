import 'package:vibration/vibration.dart';

class VibrationService {
  static Future<void> vibrate({int duration = 1}) async {
    var hasVibration = await Vibration.hasVibrator();
    if (hasVibration != null && hasVibration) {
      Vibration.vibrate(duration: duration * 1000);
    }
  }
}
