import 'package:buie/model/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Location> currentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return Location(
      position.latitude,
      position.longitude,
      placemark.first.subLocality ?? placemark.first.locality,
    );
  }
}
