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
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 8, right: 8, bottom: 8),
                child: _TopBarWidget(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  child: _CityListWidget(),
                ),
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
        shape: CircleBorder(
            side: BorderSide(color: const Color(0xFFDBDDF1), style: BorderStyle.solid, width: 1.0)),
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
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'My locations',
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: const Color(0xFF3D3F4E),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800)),
          ),
        ),
        PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 1,
                      child: Text("About",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: const Color(0xFF3D3F4E),
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal)))),
                ],
            onSelected: (value) {
              if (value == 1) {
                Navigator.pushNamed(context, Router.ABOUT);
              }
            }),
      ],
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
          child: RefreshIndicator(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(color: Colors.white),
              itemCount: items.length,
              itemBuilder: (context, index) => GestureDetector(
                child: _CityListItemWidget(items[index]),
                onTap: () =>
                    Navigator.pushNamed(context, Router.WEATHER, arguments: items[index].city),
              ),
            ),
            onRefresh: () => Provider.of<HomeController>(context, listen: false).getLocation(),
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
    return Container(
      height: 94,
      decoration: BoxDecoration(
        color: const Color(0xFFDDEEF3),
        borderRadius: BorderRadius.all(const Radius.circular(8)),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Image(image: AssetImage(data.image)),
            ),
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
                      data.city.name,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: const Color(0xFF3D3F4E),
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800)),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 150,
                      child: Text(
                        data.weatherDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: const Color(0xFF7F808C),
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
