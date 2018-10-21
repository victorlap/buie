import 'package:buie/model/location.dart';
import 'package:buie/model/rain.dart';
import 'package:http/http.dart' as http;

class RainService {
  Future<RainList> getRainListForLocation(Location loc) async {
    final response = await http.get(_url(loc.lat, loc.lon));

    if (response.statusCode == 200) {
      return BuienradarResponseTransformer.fromResponse(response.body, loc)
          .toRainList();
    } else {
      throw Exception('Failed to fetch rain data');
    }
  }

  String _url(double lat, double lon) {
    return "https://gpsgadget.buienradar.nl/data/raintext?lat=$lat&lon=$lon";
  }
}

class BuienradarResponseTransformer {
  final List<String> entries;
  final Location location;

  BuienradarResponseTransformer(this.entries, this.location);

  factory BuienradarResponseTransformer.fromResponse(
      String response, Location location) {
    return BuienradarResponseTransformer(response.split("\n"), location);
  }

  RainList toRainList() {
    return RainList.fromBuienradarResponse(this.entries, this.location);
  }
}
