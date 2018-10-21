import 'package:buie/model/location.dart';
import 'package:buie/model/rain.dart';
import 'package:buie/service/location.dart';
import 'package:buie/service/rain.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Location _location = new Location(.0, .0, 'Unknown');

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Buie'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Current Location:',
            ),
            new Text(
              _location.name,
              style: Theme.of(context).textTheme.display1,
            ),
            FutureBuilder<RainList>(
              future: _fetchRain(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.location.name);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<RainList> _fetchRain() async {
    Location loc = await LocationService().currentLocation();
    setState(() {
      this._location = loc;
    });
    return RainService().getRainListForLocation(loc);
  }
}
