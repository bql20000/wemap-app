import 'package:flutter/material.dart';
import 'package:wemap_test_app/enums.dart';
import 'package:wemap_test_app/utils.dart';
import 'package:wemapgl/wemapgl.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  WeMapController mapController;
  LatLng lastPos;
  LatLng currentPos = getCurrentPosition();

  List<LatLng> coordinates = [];
  Line currentLine;

  bool onJourney = false;
  String buttonTitle = 'Start journey';

  void _onMapCreated(WeMapController controller) async {
    mapController = controller;

    mapController.addCircle(
      CircleOptions(
        geometry: currentPos,
        circleColor: AppColors.currentPos,
      )
    );

    // todo: move below code to startJourney
    coordinates.add(currentPos);
    currentLine = await mapController.addLine(LineOptions(
      geometry: coordinates,
      lineColor: AppColors.basicLine,
    ));
  }

  void updatePath() {
    // Update line each (fixed) duration of time.
    coordinates.add(getCurrentPosition());
    mapController.updateLine(currentLine, LineOptions(
      geometry: coordinates
    ));
  }

  void startJourney() {
    // reset variables
    // some mechanism to update the path/line consecutively
  }

  void endJourney() {
    // reset variables
    // show a screen to summarize journey
    // save journey information to account tab
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WeMap(
            initialCameraPosition: CameraPosition(
              target: currentPos,
              zoom: 16.0,
            ),
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(buttonTitle),
                  onPressed: () {
                    if (!onJourney) {
                      startJourney();
                      setState(() {
                        buttonTitle = 'Start journey';
                        onJourney = true;
                      });
                    }
                    else {
                      endJourney();
                      setState(() {
                        buttonTitle = 'End journey';
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
