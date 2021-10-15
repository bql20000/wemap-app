import 'package:wemapgl/wemapgl.dart';

// WEMAP
const String weMapApiKey = '';

// GENERAL
const LatLng initialPosition = LatLng(21.038282, 105.782885);    // VNU

// UPDATING LOCATION
class LocationUpdateOptions {
  static int minDistance = 5;
  static Duration intervalDuration = Duration(seconds: 3);
}

// COLORS
class AppColors {
  static const String currentPos = '#B3490A';
  static const String basicLine = '#F2610B';
}
