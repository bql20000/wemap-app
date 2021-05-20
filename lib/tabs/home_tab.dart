import 'package:flutter/material.dart';
import 'package:wemap_test_app/enums.dart';
import 'package:wemapgl/wemapgl.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  WeMapController mapController;
  LatLng currentPosition = LatLng(21.038282, 105.782885);
  WeMapPlace place;
  bool reverse = true;

  void _onMapCreated(WeMapController controller) {
    mapController = controller;
    mapController.addCircle(
      CircleOptions(
        circleColor: AppColors.currentPos,
        geometry: currentPosition
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WeMap(
            initialCameraPosition: CameraPosition(
              target: currentPosition,
              zoom: 16.0,
            ),
            onMapCreated: _onMapCreated,
            destinationIcon: "assets/symbols/destination.png",
            reverse: true,
            onMapClick: (point, latlng, _place) async {
              // print('yoyo');
              place = await _place;
              // mapController.showPlaceCard(place);
            },
          ),
        ],
      )
    );
  }
}
