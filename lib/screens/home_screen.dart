import 'package:flutter/material.dart';

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
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
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
          Text('New Delhi',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('15 may 2020'),
          ),
        ],
      ),
    );
  }
}
