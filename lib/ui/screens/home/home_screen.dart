import 'package:flutter/material.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/location.dart';
import 'package:sweaterweather/router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade300,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopBarWidget(),
            HeaderWidget(),
          ],
        ),
      ),
    );
  }
}

class TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            final city = City(id: 625144, name: 'Minsk', country: 'BY', location: Location(lat: 53.9, lon: 27.57));
            Navigator.pushNamed(context, Router.WEATHER, arguments: city);
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, Router.ADD_CITY);
          },
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('New Delhi', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('15 may 2020'),
          ),
        ],
      ),
    );
  }
}
