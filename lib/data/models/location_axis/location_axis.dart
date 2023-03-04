class LocationAxis {
  double? latitude;
  double? longitude;
  LocationAxis(this.latitude, this.longitude);
  String get latLngString {
    return latitude.toString() + "," + longitude.toString();
  }
}
