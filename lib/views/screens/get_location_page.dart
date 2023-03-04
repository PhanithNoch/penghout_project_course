import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../data/models/location_axis/location_axis.dart';

class GetLocationPage extends StatefulWidget {
  bool? interactive = false;
  bool? isAppBar = false;
  double? lat;
  double? log;
  GetLocationPage(
      {Key? key, this.interactive, this.isAppBar, this.lat, this.log})
      : super(key: key);

  @override
  _GetLocationPageState createState() {
    return _GetLocationPageState();
  }
}

class _GetLocationPageState extends State<GetLocationPage> {
  // final controller = Get.put(LocationController());

  Future? getLocation;
  double localLat = 0;
  double localLog = 0;

  var location = Location();
  late LocationAxis userLocation;
  bool isLocated = false;
  double zoom = 16;
  String mapUrl = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  @override
  void initState() {
    userLocation = LocationAxis(0, 0);
    getLocation = _getLocation();
    if (widget.lat != null && widget.log != null) {
      // controller.localLat = widget.lat;
      // controller.localLog = widget.log;
      userLocation.latitude = widget.lat;
      userLocation.longitude = widget.log;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLocation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // singleton.isLocated = true;
          isLocated = true;
          return Stack(
            children: <Widget>[
              FlutterMap(
                options: MapOptions(
                    interactiveFlags: widget.interactive!
                        ? InteractiveFlag.all
                        : InteractiveFlag.none,
                    center: LatLng(localLat, localLog),
                    zoom: zoom,
                    onTap: (tap, LatLng) {
                      // controller.localLat = LatLng.latitude;
                      // controller.localLog = LatLng.longitude;
                      // print('tapped $localLat');
                      // singleton.isChangeLocation = true;
                      setState(() {});
                    }),
                children: [
                  TileLayer(
                    urlTemplate: mapUrl,
                    subdomains: ['a', 'b', 'c'],
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1IjoiYmNpbm5vdmF0aW9udGVhbSIsImEiOiJjazVveXBwdzUxZXp0M29wY3djN2xjMmNhIn0.KSQ7lGfLfQW3G91MZoZX0A',
                      'id': 'mapbox.streets',
                    },
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 200.0,
                        height: 200.0,
                        point: LatLng(localLat, localLog),
                        builder: (ctx) => Image.asset(
                          "assets/images/marker.png",
                          scale: 15,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          getLocation = _getLocation();
                          isLocated = false;

                          setState(() {});
                          // singleton.isLocated = false;
                          // singleton.isChangeLocation = false;
                        },
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.my_location,
                          color: Colors.blue,
                        ),
                      )),
                ),
              ),
              Card(
                  color: Colors.white,
                  child: ToggleSwitch(
                    minWidth: 90.0,
                    totalSwitches: 3,
                    initialLabelIndex: 0,
                    activeBgColor: [Colors.red],
                    inactiveBgColor: Colors.white,
                    labels: ['ផ្លូវ', 'ផ្កាយរណប', 'Modern'],
                    onToggle: (index) {
                      if (index == 0) {
                        setState(() {
                          mapUrl =
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
                        });
                      } else if (index == 1) {
                        setState(() {
                          mapUrl =
                              "https://api.mapbox.com/styles/v1/bcinnovationteam/ck67b2bvn08771iqh25p3o3ul/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYmNpbm5vdmF0aW9udGVhbSIsImEiOiJjazVveXBwdzUxZXp0M29wY3djN2xjMmNhIn0.KSQ7lGfLfQW3G91MZoZX0A";
                        });
                      } else {
                        setState(() {
                          mapUrl =
                              "https://api.mapbox.com/styles/v1/bcinnovationteam/ckh0fk5up031i19mtuhri7pfz/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYmNpbm5vdmF0aW9udGVhbSIsImEiOiJjazVveXBwdzUxZXp0M29wY3djN2xjMmNhIn0.KSQ7lGfLfQW3G91MZoZX0A";
                        });
                      }
                    },
                  )),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  /// get current user location
  Future<bool> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    if (widget.lat == null)
      await location.getLocation().then((value) {
        // print('get location');
        // print('lat long ${value}');
        userLocation.latitude = value.latitude;
        userLocation.longitude = value.longitude;
        // controller.localLog = userLocation.longitude;
        // controller.localLat = userLocation.latitude;
        return true;
        // if (!singleton.isLocated || !singleton.isChangeLocation) {
        //   print('lat long ${value}');
        //   userLocation.latitude = value.latitude;
        //   userLocation.longitude = value.longitude;
        //   return true;
        // } else
        //   return false;
      });
    return true;
  }
}
