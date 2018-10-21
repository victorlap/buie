import 'package:buie/model/location.dart';

class RainList {
  final List<Rain> list;
  final DateTime start;
  final DateTime end;
  final Location location;

  RainList({this.list, this.start, this.end, this.location});

  factory RainList.fromBuienradarResponse(
      List<String> entries, Location location) {
    final List<Rain> list = entries
        .where((entry) => entry != '')
        .map((String entry) => Rain.fromBuienradarResponse(entry))
        .toList();

    return RainList(
      list: list,
      start: list.first.time,
      end: list.last.time,
      location: location,
    );
  }
}

class Rain {
  final DateTime time;
  final double rain;

  Rain(this.time, this.rain);

  factory Rain.fromBuienradarResponse(String entry) {
    final String minute = entry.substring(4, 6);
    final String second = entry.substring(7);
    final String rain = entry.substring(0, 3);

    final DateTime now = DateTime.now();
    final DateTime dt = DateTime(
        now.year, now.month, now.day, int.parse(minute), int.parse(second));

    return Rain(dt, double.parse(rain));
  }
}
