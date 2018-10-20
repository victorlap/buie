import 'package:buie/model/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Location> currentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return new Location(
      position.latitude,
      position.longitude,
      position.toString(),
    );
  }
}
