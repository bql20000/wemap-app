import 'package:geolocator/geolocator.dart';
import 'package:wemapgl/wemapgl.dart';

Future<Position> getCurrentPos() async {
  // todo: implement
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true
  );
  return position;
}

Map calculateSummaryInfo(List<LatLng> coordinates, DateTime startTime) {
  Map info = {};

  // calculate total run time
  Duration timeDiff = DateTime.now().difference(startTime);
  info['totalTime'] = timeDiff;
  print('### 1: Total time in seconds = ${timeDiff.inSeconds}');

  // calculate total run distance
  double dist = 0;  // measured in meters
  for (int i = 1; i < coordinates.length; ++i) {
    dist += Geolocator.distanceBetween(
      coordinates[i-1].latitude, coordinates[i-1].longitude,
      coordinates[i].latitude, coordinates[i].longitude
    );
  }
  info['totalDistance'] = dist / 1000;
  print('### 2: Total distance in meters = $dist');

  // calculate center position
  double centerLatitude = 0;
  double centerLongitude = 0;
  for (var pos in coordinates) {
    centerLatitude += pos.latitude;
    centerLongitude += pos.longitude;
  }
  LatLng centerPos = LatLng(
    centerLatitude / coordinates.length,
    centerLongitude / coordinates.length
  );
  info['centerPos'] = centerPos;
  print('### 3: center Position = ${info['centerPos']}');

  return info;
}