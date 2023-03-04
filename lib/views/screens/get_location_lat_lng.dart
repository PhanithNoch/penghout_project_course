import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart' as map;
import 'package:geocoding/geocoding.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../data/models/locations/geo_coding.dart';

class GetLocationLatLng extends StatefulWidget {
  String? locationLatLngString;
  bool? interactive = false;
  bool mapOption = false;
  String? mapDescription;
  String? mapTitle;
  late List<String> locationAxis;
  GetLocationLatLng({
    Key? key,
    required String locationLatLngString,
    bool? interactive,
    bool? mapOption,
    String? mapDescription,
    String? mapTitle,
  }) : super(key: key) {
    locationAxis = locationLatLngString.split(",");
    this.locationLatLngString = locationLatLngString;
    this.interactive = interactive;
    this.mapOption = mapOption ?? false;
    this.mapDescription = mapDescription;
    this.mapTitle = mapTitle;
  }

  @override
  _GetLocationLatLngState createState() {
    return _GetLocationLatLngState();
  }
}

class _GetLocationLatLngState extends State<GetLocationLatLng> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String mapOption = 'streets';
  String mapUrl = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  String? address = '';

  Future<bool> getGeocoding(String lat, String long) async {
    Dio dio = Dio();
    final res = await dio
        .get(
            "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$long&accept-language=kh",
            options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                }))
        .catchError((err) => {});
    if (res.statusCode == 200) {
      Geocoding geocoding = Geocoding.fromJson(res.data);
      address = geocoding.displayName;
      return true;
    } else
      return false;
  }

  void onClickMarker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                'ព៌តមាន',
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  size: 30,
                ),
                title: Text(
                  address!,
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  var google =
                      await map.MapLauncher.isMapAvailable(map.MapType.google);
                  if (google!) {
                    await map.MapLauncher.launchMap(
                      mapType: map.MapType.google,
                      coords: map.Coords(double.parse(widget.locationAxis[0]),
                          double.parse(widget.locationAxis[1])),
                      title: widget.mapTitle == null
                          ? 'មិនមានឈ្មោះ'
                          : widget.mapTitle!,
                      description: widget.mapDescription == null
                          ? 'មិនមានឈ្មោះ'
                          : widget.mapDescription,
                    );
                  } else {
                    await map.MapLauncher.launchMap(
                      mapType: map.MapType.apple,
                      coords: map.Coords(double.parse(widget.locationAxis[0]),
                          double.parse(widget.locationAxis[1])),
                      title: widget.mapTitle == null
                          ? 'មិនមានឈ្មោះ'
                          : widget.mapTitle!,
                      description: widget.mapDescription == null
                          ? 'មិនមានឈ្មោះ'
                          : widget.mapDescription,
                    );
                  }
                },
                // padding: EdgeInsets.all(0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                    child: Text(
                      'ផ្លូវទៅទីតាំង',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        FlutterMap(
          options: MapOptions(
            interactiveFlags: widget.interactive!
                ? InteractiveFlag.all
                : InteractiveFlag.none,
            center: LatLng(double.parse(widget.locationAxis[0]),
                double.parse(widget.locationAxis[1])),
            zoom: 15,
          ),
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
                  width: 70, height: 70,
                  point: new LatLng(
                    double.parse(widget.locationAxis[0]),
                    double.parse(
                      widget.locationAxis[1],
                    ),
                  ),
//                  builder: (ctx) => Icon(
//                    Icons.location_on,
//                    size: 40,
//                    color: Colors.red,
//                  ),
                  builder: (ctx) => TextButton(
                    // padding: EdgeInsets.all(0),
                    onPressed: () async {
                      // AnimateLoading().showLoading(context,
                      //     content: 'កំពុងដំណើរការ', dismiss: false);
                      final res = await getGeocoding(
                          widget.locationAxis[0].toString(),
                          widget.locationAxis[1].toString());
                      Navigator.pop(context);
                      if (res) onClickMarker();
                    },
                    child: Image.asset(
                      "assets/images/marker.png",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 20, left: 20),
            alignment: Alignment.topLeft,
            child: ToggleSwitch(
              minWidth: 90.0,
              initialLabelIndex: 0,
              // activeBgColor: [StyleColor.appBarColor],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.grey[900],
              totalSwitches: 3,
              labels: ['ផ្លូវ', 'ផ្កាយរណប', 'Modern'],
              onToggle: (index) {
                if (index == 0) {
                  mapUrl = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
                } else if (index == 1) {
                  mapUrl =
                      "https://api.mapbox.com/styles/v1/bcinnovationteam/ck67b2bvn08771iqh25p3o3ul/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYmNpbm5vdmF0aW9udGVhbSIsImEiOiJjazVveXBwdzUxZXp0M29wY3djN2xjMmNhIn0.KSQ7lGfLfQW3G91MZoZX0A";
                } else {
                  mapUrl =
                      "https://api.mapbox.com/styles/v1/bcinnovationteam/ckh0fk5up031i19mtuhri7pfz/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYmNpbm5vdmF0aW9udGVhbSIsImEiOiJjazVveXBwdzUxZXp0M29wY3djN2xjMmNhIn0.KSQ7lGfLfQW3G91MZoZX0A";
                }
                setState(() {});
              },
            )),
      ],
    );
  }
}
