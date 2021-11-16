import 'package:geolocator/geolocator.dart';

class PositionProvider {
  static Future<Position> get() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
  }
}
