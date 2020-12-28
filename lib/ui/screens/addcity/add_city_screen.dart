import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_controller.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_item.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_tile.dart';
import 'package:sweaterweather/ui/screens/addcity/search_bar_widget.dart';

class AddCityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => AddCityController(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _TopBarWidget(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                child: _SearchBar(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 26, top: 20, right: 26, bottom: 0),
                  child: _CityListWidget(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: const Color(0xFF7F808C),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'Add location',
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: const Color(0xFF3D3F4E),
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
        )
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddCityController>(
      builder: (context, value, child) {
        return SearchBarWidget((text) {
          Provider.of<AddCityController>(context, listen: false).findByName(text);
        });
      },
    );
  }
}

class _CityListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddCityController>(builder: (context, value, child) {
      if (value.isProgress) {
        return Center(child: CircularProgressIndicator());
      } else {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return false;
          },
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(color: Colors.white),
            itemCount: value.listItems.length,
            itemBuilder: (context, index) => AddCityListTile(
                value.listItems[index],
                (CityListItem item) =>
                    Provider.of<AddCityController>(context, listen: false).itemTapped(item)),
          ),
        );
      }
    });
  }
}
