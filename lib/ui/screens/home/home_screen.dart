import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/router.dart';
import 'package:sweaterweather/ui/screens/home/home_controller.dart';
import 'package:sweaterweather/ui/screens/home/location_list_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 34.0, horizontal: 0.0),
            children: <Widget>[
              ListTile(
                title: Text('Item 1'),
                onTap: () => print('Item 1'),
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () => print('Item 2'),
              ),
              ListTile(
                title: Text('Item 3'),
                onTap: () => print('Item 3'),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              _TopBarWidget(),
              Expanded(
                child: _CityListWidget(),
              ),
            ],
          ),
        ),
        floatingActionButton: _FAB(),
      ),
    );
  }
}

class _FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF3D3F4E),
        child: Icon(Icons.add),
        elevation: 0.0,
        shape: CircleBorder(side: BorderSide(color: const Color(0xFFDBDDF1), style: BorderStyle.solid, width: 1.0)),
        onPressed: () async {
          await Navigator.pushNamed(context, Router.ADD_CITY);
          Provider.of<HomeController>(context, listen: false).getLocation();
        },
      ),
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 0.0, left: 20.0, right: 20.0),
      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          Text(
            'My locations',
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: const Color(0xFF3D3F4E),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800)),
          )
        ],
      ),
    );
  }
}

class _CityListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController value, Widget child) {
        final items = value.cities;
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return false;
          },
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(color: Colors.white),
            itemCount: items.length,
            itemBuilder: (context, index) => _CityListItemWidget(items[index]),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 34.0),
          ),
        );
      },
    );
  }
}

class _CityListItemWidget extends StatelessWidget {
  final LocationListItem data;

  _CityListItemWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      height: 93,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFDDEEF3),
          borderRadius: BorderRadius.all(const Radius.circular(8)),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Image.network('http://cdn.weatherapi.com/weather/128x128/night/113.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 27.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '${data.temp}°',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: const Color(0xFF3D3F4E),
                            fontSize: 52,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800)),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data.name,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: const Color(0xFF3D3F4E),
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w800)),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data.weatherDescription,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: const Color(0xFF7F808C),
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
