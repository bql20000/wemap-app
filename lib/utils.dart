import 'package:geolocator/geolocator.dart';
import 'package:wemapgl/wemapgl.dart';

Future<LatLng> getCurrentPos() async {
  // todo: implement
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true
  );
  return LatLng(position.latitude, position.longitude);
}

Map calculateSummaryInfo(List<LatLng> coordinates, DateTime startTime) {
  return {};
}