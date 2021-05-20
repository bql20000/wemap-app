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



  void _onMapCreated(WeMapController controller) {
    mapController = controller;
    mapController.addCircle(
      CircleOptions(
        geometry: currentPos,
        circleColor: AppColors.currentPos,
      )
    );
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
        ],
      )
    );
  }
}
