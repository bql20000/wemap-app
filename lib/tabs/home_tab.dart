import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wemap_test_app/enums.dart';
import 'package:wemap_test_app/models/result.dart';
import 'package:wemap_test_app/utils.dart';
import 'package:wemapgl/wemapgl.dart';

import '../global_variables.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  WeMapController mapController;

  DateTime startTime;
  LatLng currentPos;

  List<LatLng> coordinates = [];
  Line currentLine;

  bool onJourney = false;
  String buttonTitle = 'Start journey';

  void _onMapCreated(WeMapController controller) async {
    mapController = controller;

    updateLocation(await getCurrentPos());

    currentLine = await mapController.addLine(LineOptions(
      geometry: [],
      lineColor: AppColors.basicLine,
      lineWidth: 8,
    ));
  }

  void updateLocation(Position position) {
    currentPos = LatLng(position.latitude, position.longitude);
    // print('### ${currentPos.latitude} ${currentPos.longitude}');
    mapController.animateCamera(CameraUpdate.newLatLng(currentPos));
  }

  void updatePath() {
    // Update line each (fixed) duration of time
    print('@@@ ${coordinates.length}');
    coordinates.add(currentPos);
    mapController.updateLine(currentLine, LineOptions(
      geometry: coordinates
    ));
  }

  void setupLocationStream() {
    positionStream = Geolocator.getPositionStream(
      intervalDuration: LocationUpdateOptions.intervalDuration,
      distanceFilter: LocationUpdateOptions.minDistance
    ).listen((Position position) {
      updateLocation(position);
      if (onJourney) updatePath();
    });
  }

  Future<void> resetLine() async {
    coordinates.clear();
    updateLocation(await getCurrentPos());
    updatePath();
  }

  void startJourney() async {
    await resetLine();
    startTime = DateTime.now();
    setupLocationStream();
    mapController.animateCamera(CameraUpdate.newLatLngZoom(currentPos, 16));
  }

  void endJourney() {
    // calculate summary information
    Map summaryInfo = calculateSummaryInfo(coordinates, startTime);

    Result result = Result(
      totalTime: summaryInfo['totalTime'],
      totalDistance: summaryInfo['totalDistance']
    );

    // navigate to summary screen
    Navigator.pushNamed(context, '/summary', arguments: result);

    // move camera to larger
    LatLng centerPos = summaryInfo['centerPos']; // ?? coordinates.last;
    mapController.animateCamera(CameraUpdate.newLatLngZoom(centerPos, 14));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WeMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 16.0,
            ),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,            // this currently not working
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(onJourney ? 'END JOURNEY' : 'START NEW JOURNEY'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    textStyle: TextStyle(
                      fontFamily: 'Oswald',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (!onJourney) {
                      startJourney();
                      setState(() {
                        onJourney = true;
                      });
                    }
                    else {
                      endJourney();
                      setState(() {
                        onJourney = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
