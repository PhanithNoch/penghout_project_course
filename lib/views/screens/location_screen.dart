import 'package:flutter/material.dart';

import 'get_location_lat_lng.dart';
import 'get_location_page.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Location Screen'),
        ),
        body: GetLocationLatLng(
          interactive: true,
          mapTitle: 'Location',
          locationLatLngString: '11.516957,104.953511',
        ));
  }
}
